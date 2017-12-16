//
//  MyStockAnnounceListViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyStockAnnounceListViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "WebViewController.h"
#import "MarketConfig.h"
#import "StockAnnounceListAPI.h"
#import "NewsTableViewCell.h"
#import "NewsListModel.h"
#import "StockHistoryUtil.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJRefresh.h"
#import "AppDelegate.h"

static NSString *cellID = @"NewsTableViewCellID";

@interface MyStockAnnounceListViewController () <UITableViewDelegate,UITableViewDataSource,NewsTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) StockAnnounceListAPI *announceListAPI;

@end

@implementation MyStockAnnounceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    self.title = @"自选公告";
    _navBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0 * kScale);
    }];
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self
                                                           refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self
                                                           refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark loadData

- (void)loadData {
    if (self.tableView.mj_header.isRefreshing) {
        return;
    }
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    self.announceListAPI.page = @"1";
    [self.announceListAPI start];
}

- (void)loadMoreData {
    self.announceListAPI.page = [NSString stringWithFormat:@"%zd",_announceListAPI.page.integerValue + 1];
    [_announceListAPI start];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[NewsListModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
    
    if ([[request valueForKey:@"page"] isEqualToString:@"1"]) {
        [self.dataArray removeAllObjects];
        self.dataArray = [NSMutableArray arrayWithArray:array];
        [_tableView.mj_header endRefreshing];
    } else {
        [self.dataArray addObjectsFromArray:array];
    }
    
    [self.tableView reloadData];
    NSString *count = (NSString *)[request valueForKey:@"count"];
    if (array.count < count.integerValue) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [_tableView.mj_footer endRefreshing];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

#pragma mark action

- (void)scrollToTop {
    [_tableView setContentOffset:CGPointZero animated:YES];
}

- (void)newsTableViewCell:(NewsTableViewCell*)cell selectedIndex:(NSUInteger)index {
    if([self.dataArray count] <= index)return;
    
    NewsListModel *item = [self.dataArray objectAtIndex:index];
    
    if (!(item.m && item.s && item.t && item.n)) {
        return;
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (([item.t intValue] == 1) || ([item.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.indexModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.stockListModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListModel *model = self.dataArray[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:15 * kScale];
    CGFloat w = [model.tt boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight) options:1 attributes:@{NSFontAttributeName : font} context:nil].size.width;
    
    if (w > MAIN_SCREEN_WIDTH - 24 * kScale) {
        return 85 * kScale;
    }
    
    return 64 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    NewsListModel *model = self.dataArray[indexPath.row];
    [cell setName:[NSString stringWithFormat:@"%@(%@)",model.n,model.s] time:model.tm content:model.tt];
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.dataArray count] <= indexPath.row)return;
    
    NSInteger row = [indexPath row];
    NewsListModel *model = [self.dataArray objectAtIndex:row];
    
    NSDictionary *param = @{@"nid":model.nid};
    WebViewController *viewController = [[WebViewController alloc] init];
    
    NSString *url = [MarketConfig getUrlWithPath:H5_STOCK_NEWS_DETAIL Param:param];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    viewController.myUrl = urlStr;
    viewController.type = WEB_VIEW_TYPE_NOR;
    viewController.nId = model.nid;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma mark  lazyloading

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12 * kScale, 0, 12 * kScale);
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _tableView;
}

- (StockAnnounceListAPI *)announceListAPI {
    if (_announceListAPI == nil) {
        _announceListAPI = [StockAnnounceListAPI new];
        _announceListAPI.myStockArray = [StockHistoryUtil getMyStock];
        _announceListAPI.page = @"0";
        _announceListAPI.count = @"20";
        _announceListAPI.delegate = self;
    }
    return _announceListAPI;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
