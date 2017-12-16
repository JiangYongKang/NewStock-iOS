//
//  MyStockNewsViewController.m
//  NewStock
//
//  Created by Willey on 16/8/4.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MyStockNewsViewController.h"
#import "MarketConfig.h"
#import "StockListTitleCell.h"
#import "StockHistoryUtil.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "NewsListModel.h"
#import "WebViewController.h"
#import "AppDelegate.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "SearchViewController.h"

@implementation MyStockNewsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自选资讯";
    [_navBar setTitle:self.title];
    _navBar.hidden = YES;

    self.view.backgroundColor = REFRESH_BG_COLOR;
    
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    _stockNewsListAPI = [[StockNewsListAPI alloc] initWithArray:array];
    _stockNewsListAPI.delegate = self;
    
    _resultListArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
    _tableView.separatorInset = UIEdgeInsetsMake(0, 12 * kScale, 0, 12 * kScale);
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableView.superview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _noMyStockView = [[NoMyStockView alloc] initWithFrame:CGRectZero];
    _noMyStockView.backgroundColor = [UIColor whiteColor];
    _noMyStockView.delegate = self;
    [self.view addSubview:_noMyStockView];
    [_noMyStockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_noMyStockView setType:NO_RECORD_TYPE_NEWS];
    _noMyStockView.hidden = YES;
    
    _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadData {
    
    if (self.isSelectedRow) {
        self.isSelectedRow = NO;
        return;
    }
    [_tableView.mj_header beginRefreshing];

    NSMutableArray *array = [StockHistoryUtil getMyStock];
    if ([array count] > 0) {
        _noMyStockView.hidden = YES;
    }else {
        _noMyStockView.hidden = NO;
    }
}

- (void)scrollToTop {
    [_tableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark 下拉刷新数据
- (void)loadNewData {
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    [_stockNewsListAPI setMyStockArray:array];
    
    [_resultListArray removeAllObjects];
    
    [_stockNewsListAPI start];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData {
    [_stockNewsListAPI loadNestPage];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed");
    [_tableView.mj_header endRefreshing];
    
    NSArray *array = [_stockNewsListAPI.responseJSONObject objectForKey:@"list"];
    _totalNum = [[_stockNewsListAPI.responseJSONObject objectForKey:@"total"] intValue];
    _stockNewsListAPI.totalNum = _totalNum;
    
    NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[NewsListModel class] fromJSONArray:array error:nil];
    [_resultListArray addObjectsFromArray:modelArray];
    [_tableView reloadData];
    
    if (_totalNum > [_resultListArray count]) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } else {
        //没有更多数据的状态
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }

}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

#pragma UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListModel *model = [_resultListArray objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:15 * kScale];
    CGFloat w = [model.tt boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight) options:1 attributes:@{NSFontAttributeName : font} context:nil].size.width;
    
    if (w > MAIN_SCREEN_WIDTH - 24 * kScale) {
        return 85 * kScale;
    }
    
    return 64 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid=@"newsTableViewCell";
    NewsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    NSInteger row = [indexPath row];

    if([_resultListArray count] <= row) {
        //[cell setName:@"" time:@"" content:@""];
        return cell;
    }
    
    NewsListModel *model = [_resultListArray objectAtIndex:row];
    [cell setName:[NSString stringWithFormat:@"%@ %@",model.n,model.s] time:model.tm content:model.tt];
    cell.delegate = self;
    cell.tag = row;
    //[[cell layer] setBorderWidth:0.5];
    //[[cell layer] setBorderColor:SEP_LINE_COLOR.CGColor];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.isSelectedRow = YES;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([_resultListArray count] <= indexPath.row)return;

    NSInteger row=[indexPath row];
    NewsListModel *model = [_resultListArray objectAtIndex:row];

    NSDictionary *param = @{@"nid":model.nid};
    WebViewController *viewController = [[WebViewController alloc] init];
    
    NSString *url = [MarketConfig getUrlWithPath:H5_NEWS_DETAIL Param:param];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    viewController.myUrl = urlStr;
    viewController.type = WEB_VIEW_TYPE_ZIXUN;
    viewController.nId = model.nid;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

- (void)newsTableViewCell:(NewsTableViewCell*)cell selectedIndex:(NSUInteger)index {
    if([_resultListArray count]<=index)return;
    
    NewsListModel *item = [_resultListArray objectAtIndex:index];
    
    if (!(item.m && item.s && item.t && item.n)) {
        return;
    }
    
    if (([item.t intValue] == 1) || ([item.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.indexModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.stockListModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)noMyStockView:(NoMyStockView*)noMyStockView {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}


@end
