//
//  QuickNewsViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/5/23.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "QuickNewsViewController.h"
#import "MomentNewsAnalyisis.h"
#import "MomentNewsAnalysisModel.h"
#import "MomontNewsAnalysisCell.h"
#import "MomentNewsBottomStockView.h"
#import "StockListModel.h"
#import "MyStockInfoAPI.h"
#import "StockCodesModel.h"
#import "AppDelegate.h"
#import "MarketConfig.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"

static NSString *cellID = @"QuickNewsViewControllerCell";

@interface QuickNewsViewController () <UITableViewDelegate,UITableViewDataSource,MomontNewsAnalysisCellDelegate>

@property (nonatomic, strong) MomentNewsAnalyisis *listAPI;
@property (nonatomic, strong) MyStockInfoAPI *stockInfoAPI;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *timeLine;

@property (nonatomic, strong) NSMutableArray <MomentNewsAnalysisModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray <StockCodeInfo *> *stockArray;
@property (nonatomic, strong) NSMutableArray <MomentNewsBottomStockView *> *stockViewArray;
@property (nonatomic, strong) NSArray <StockListModel *> *stockInfoArray;

@end

@implementation QuickNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _navBar.hidden = YES;
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0 * kScale);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TAB_BAR_HEIGHT);
    }];
    
    [self.view addSubview:self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(@(35 * kScale));
    }];
    
    _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.listAPI start];
}

#pragma mark loaddata

- (void)loadData {
    [_tableView.mj_header beginRefreshing];
}

- (void)loadMoreData {
    NSInteger page = self.listAPI.page.integerValue + 1;
    self.listAPI.page = [NSString stringWithFormat:@"%zd",page];
    [self.listAPI start];
}

- (void)loadNewData {
    self.listAPI.page = @"1";
    [self.listAPI start];
}

- (void)loadStockInfo {
    [self.stockInfoAPI setMyStockArray:self.stockArray];
    [self.stockInfoAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",[NSThread currentThread]);
        self.stockInfoArray = [MTLJSONAdapter modelsOfClass:[StockListModel class] fromJSONArray:request.responseJSONObject error:nil];
        [self updateStockInfo:self.stockViewArray];
    } failure:nil];
}

- (void)requestFinished:(APIBaseRequest *)request {
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[MomentNewsAnalysisModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
    
    if ([[request valueForKey:@"page"] isEqualToString:@"1"]) {
        [self.stockArray removeAllObjects];
        [self addStockToStockArray:array];
        self.dataArray = [NSMutableArray arrayWithArray:array];
        [_tableView.mj_header endRefreshing];
    } else {
        [self.dataArray addObjectsFromArray:array];
        [self addStockToStockArray:array];
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
//    [super requestFailed:request];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

#pragma mark action

- (void)timerRefresh {
    [self loadStockInfo];
}

- (void)scrollToTop {
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)momentNewsAnalysisCellStockPush:(MomentNewsAnalysisStockModel *)stock {
    if (!(stock.t && stock.s.length && stock.m && stock.n.length)) {
        return;
    }
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (([stock.t intValue] == 1) || ([stock.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = stock.m;
        model.symbol = stock.s;
        model.symbolName = stock.n;
        model.symbolTyp = stock.t;
        
        viewController.indexModel = model;
        [delegate.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = stock.m;
        model.symbol = stock.s;
        model.symbolName = stock.n;
        model.symbolTyp = stock.t;
        
        viewController.stockListModel = model;
        [delegate.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)momentNewsAnalysisCellDidInit:(NSArray *)array {
    [self.stockViewArray addObjectsFromArray:array];
}

#pragma mark function

- (void)addStockToStockArray:(NSArray <MomentNewsAnalysisModel *> *)array {
    NSMutableArray *arr = [NSMutableArray array];
    for (MomentNewsAnalysisModel *model in array) {
        if (model.sl.count) {
            [arr addObjectsFromArray:model.sl];
        }
    }
    
    for (MomentNewsAnalysisStockModel *model in arr) {
        StockCodeInfo *s = [StockCodeInfo new];
        s.t = model.t;
        s.m = model.m;
        s.s = model.s;
        s.m = model.m;
        [self.stockArray addObject:s];
    }
    [self loadStockInfo];
}

- (void)updateStockInfo:(NSArray *)array {
    for (MomentNewsBottomStockView *view in array) {
        NSString *s = view.stock.s;
        for (StockListModel *model in self.stockInfoArray) {
            if ([model.symbol isEqualToString:s]) {
                [view setRate:model.tradeIncrease];
                break;
            }
        }
    }
}

- (NSString *)getTopDateString:(NSString *)tm {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:tm];
    formatter.dateFormat = @"yyyy年M月d日";
    return [formatter stringFromDate:date];
}

#pragma mark tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MomentNewsAnalysisModel *model = self.dataArray[indexPath.row];
    if (model.isShow && model.showHeight != 0) {
        return model.showHeight;
    } else if (!model.isShow && model.hideHeight != 0) {
        return model.hideHeight;
    }
    MomontNewsAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = model;
    [cell.contentView layoutIfNeeded];
    UIView *v;
    if (model.sl.count >= 3) {
        v = [cell valueForKeyPath:@"stock3"];
    } else if (model.sl.count > 0) {
        v = [cell valueForKeyPath:@"stock1"];
    } else {
        v = [cell valueForKeyPath:@"c_lable"];
    }
    CGFloat height = CGRectGetMaxY(v.frame) + 15 * kScale;
    if (model.isShow) {
        model.showHeight = height;
    } else {
        model.hideHeight = height;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MomontNewsAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.delegate = self;
    MomentNewsAnalysisModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    [self updateStockInfo:cell.stockViewArray];
    self.timeLb.text = [self getTopDateString:model.tm];
    cell.contentView.backgroundColor = indexPath.row % 2 ? kUIColorFromRGB(0xf5f6f7) : kUIColorFromRGB(0xffffff);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MomontNewsAnalysisCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell showOrHideContentLabel];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark lazyloading

- (MomentNewsAnalyisis *)listAPI {
    if (_listAPI == nil) {
        _listAPI = [MomentNewsAnalyisis new];
        _listAPI.page = @"1";
        _listAPI.count = @"20";
        _listAPI.delegate = self;
    }
    return _listAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MomontNewsAnalysisCell class] forCellReuseIdentifier:cellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)stockArray {
    if (_stockArray == nil) {
        _stockArray = [NSMutableArray array];
    }
    return _stockArray;
}

- (NSMutableArray <MomentNewsBottomStockView *> *)stockViewArray {
    if (_stockViewArray == nil) {
        _stockViewArray = [NSMutableArray array];
    }
    return _stockViewArray;
}

- (UILabel *)timeLb {
    if (_timeLb == nil) {
        _timeLb = [UILabel new];
        _timeLb.textColor = kUIColorFromRGB(0x666666);
        _timeLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _timeLb;
}

- (UILabel *)timeLine {
    if (_timeLine == nil) {
        _timeLine = [UILabel new];
        _timeLine.backgroundColor = kUIColorFromRGB(0xe5e5e5);
    }
    return _timeLine;
}

- (UIView *)timeView {
    if (_timeView == nil) {
        _timeView = [UIView new];
        _timeView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.96];
        [_timeView addSubview:self.timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_timeView).offset(12 * kScale);
            make.centerY.equalTo(_timeView);
        }];
        
        [_timeView addSubview:self.timeLine];
        [_timeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(_timeView);
            make.height.equalTo(@0.5);
        }];
    }        
    return _timeView;
}

- (MyStockInfoAPI *)stockInfoAPI {
    if (_stockInfoAPI == nil) {
        _stockInfoAPI = [[MyStockInfoAPI alloc] initWithArray:self.stockArray];
    }
    return _stockInfoAPI;
}

@end
