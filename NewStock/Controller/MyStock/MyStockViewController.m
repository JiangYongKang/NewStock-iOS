//
//  MyStockViewController.m
//  NewStock
//
//  Created by Willey on 16/8/4.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MyStockViewController.h"
#import "SearchViewController.h"
#import "MyStockListViewController.h"
#import "MyStockNewsViewController.h"
#import "EditMyStockViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "IndexChartViewController.h"

#import "MarketConfig.h"
#import "StockHistoryUtil.h"
#import "AppDelegate.h"
#import "SystemUtil.h"
#import "UserInfoInstance.h"

#import "StockTableViewCell.h"
#import "MJChiBaoZiHeader.h"
#import "MyStockInfoAPI.h"
#import "StockListModel.h"
#import "MyStockTopView.h"
#import "IndexInfoAPI.h"
#import "IndexInfoModel.h"
#import "NativeUrlRedirectAction.h"

@interface MyStockViewController () <MyStockTopViewDelegate>
{
    MyStockInfoAPI *_myStockInfoAPI;
    
    MyStockTitle *_headerView;
}

@property (nonatomic, assign) BOOL isSelectedRow;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, strong) UILabel *bottomView;
@property (nonatomic, strong) MyStockTopView *myStockTopView;
@property (nonatomic, strong) IndexInfoModel *indexInfoModel;
@property (nonatomic, strong) IndexInfoAPI *indexInfoAPI;


@end

@implementation MyStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自选";
    _navBar.hidden = YES;
    [self setLeftBtnImg:nil];
    [self setRightBtnImg:[UIImage imageNamed:@"white_search_nor"]];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    _sortState = STOCK_SORT_NORMAL;
    
    self.view.backgroundColor = REFRESH_BG_COLOR;
    
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    
    _myStockArray = [[NSMutableArray alloc] init];
    [_myStockArray addObjectsFromArray:array];
    
    _myStockInfoAPI = [[MyStockInfoAPI alloc] initWithArray:_myStockArray];
    _myStockInfoAPI.delegate = self;
    
    _resultListArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 12 * kScale, 0, 12 * kScale);
    _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableView.superview).with.insets(UIEdgeInsetsMake(60 * kScale, 0, 0, 0));
    }];
    
    _noMyStockView = [[NoMyStockView alloc] initWithFrame:CGRectZero];
    _noMyStockView.backgroundColor = [UIColor whiteColor];
    _noMyStockView.delegate = self;
    [self.view addSubview:_noMyStockView];
    [_noMyStockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_noMyStockView setType:NO_RECORD_TYPE_STOCK];
    _noMyStockView.hidden = YES;
    
    [self.view addSubview:self.myStockTopView];
    [_myStockTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(60 * kScale));
    }];
    
    _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadNewData];
    });
}

#pragma mark 下拉刷新数据

- (void)loadNewData {
    [self getIndexData];
    
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    [_myStockArray removeAllObjects];
    [_myStockArray addObjectsFromArray:array];
    [_myStockInfoAPI setMyStockArray:array];
    [_myStockInfoAPI start];
}

- (void)getIndexData {
    [self.indexInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray * array = [MTLJSONAdapter modelsOfClass:[IndexInfoModel class] fromJSONArray:_indexInfoAPI.responseJSONObject error:nil];
        for (int i = 0; i < [array count]; i++)  {
            IndexInfoModel *model = [array objectAtIndex:i];
            if([model.symbol isEqualToString:@"000001"]) {
                [self.myStockTopView setCode:model.consecutivePresentPrice zx:model.stockUD zdf:model.tradeIncrease];
                _indexInfoModel = model;
            }
        }
    } failure:nil];
}

- (void)loadData {
    if (self.isSelectedRow) {
        self.isSelectedRow = NO;
        return;
    }
    
    if (_isRefreshing) {
        return;
    }
    
    [self loadNewData];
    _isRefreshing = YES;
    self.bottomView.hidden = [SystemUtil isSignIn] ? YES : NO;
    
    NSMutableArray *array = [StockHistoryUtil getMyStock];
    if ([array count] > 0) {
        _noMyStockView.hidden = YES;
    }else {
        _noMyStockView.hidden = NO;
    }
}

- (void)requestFinished:(APIBaseRequest *)request {
    [_tableView.mj_header endRefreshing];
    
    [_resultListArray removeAllObjects];
    
    _array = [MTLJSONAdapter modelsOfClass:[StockListModel class] fromJSONArray:_myStockInfoAPI.responseJSONObject error:nil];
    
    [_resultListArray addObjectsFromArray:_array];
    
    [self sortStock:nil];
    
    [_tableView reloadData];
    _isRefreshing = NO;
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
    [_tableView.mj_header endRefreshing];
    _isRefreshing = NO;
}

#pragma mark action

- (void)tap:(UITapGestureRecognizer *)tap {
    self.isSelectedRow = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:[LoginViewController new] animated:YES];
}

- (void)noMyStockView:(NoMyStockView *)noMyStockView {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma mark myStockView delegate

- (void)myStockTopViewPushToNative:(NSString *)url {
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
}

- (void)myStockTopViewPushToStock:(NSString *)t s:(NSString *)s n:(NSString *)n m:(NSString *)m {
    IndexChartViewController *vc = [IndexChartViewController new];
    vc.indexModel = _indexInfoModel;
    if (_indexInfoModel == nil) {
        return;
    }
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.navigationController pushViewController:vc animated:YES];
}

#pragma mark - search

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)navBar:(NavBar *)navBar leftButtonTapped:(UIButton *)sender {
    EditMyStockViewController *viewController = [[EditMyStockViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MARKET_CELL_HEIGHT;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(!_headerView) {
        _headerView = [[MyStockTitle alloc] initWithFrame:CGRectZero];
        [_headerView setName:@"     编辑" value:@"最新价" changeRate:@"涨跌幅"];
        [_headerView setEditBtn:[UIImage imageNamed:@"ic_myStock_edit_nor"]];
        _headerView.delegate = self;
        _headerView.tag = 0;
    }
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"stockTableViewCell";
    StockTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[StockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    NSInteger row = [indexPath row];
    
    if([_resultListArray count] <= row) {
        [cell setCode:@"--" name:@"--" value:@"--" changeRate:@"--" marketCd:@"--"];
        return cell;
    }
    
    StockListModel *model = [_resultListArray objectAtIndex:row];
    
    NSString *code;
    NSString *increase;
    
    code = model.symbol;
    
    if(_tableView.editing) {
        increase = @"";
    } else {
        increase = [SystemUtil getPercentage:[model.tradeIncrease doubleValue]];
    }
    
    [cell setCode:code name:model.symbolName value:[SystemUtil get2decimal:[model.consecutivePresentPrice doubleValue]] changeRate:increase marketCd:model.marketCd];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.isSelectedRow = YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([_resultListArray count] <= indexPath.row)return;
    
    StockListModel *item = [_resultListArray objectAtIndex:indexPath.row];
    
    if (!(item.symbolTyp && item.symbol && item.marketCd && item.symbolName)) {
        return;
    }
    
    if (([item.symbolTyp intValue] == 1) || ([item.symbolTyp intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = item.marketCd;
        model.symbol = item.symbol;
        model.symbolName = item.symbolName;
        model.symbolTyp = item.symbolTyp;
        
        viewController.indexModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = item.marketCd;
        model.symbol = item.symbol;
        model.symbolName = item.symbolName;
        model.symbolTyp = item.symbolTyp;
        
        viewController.stockListModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)myStockTitle:(MyStockTitle *)cell selectedIndex:(NSUInteger)index {
    EditMyStockViewController *vc = [EditMyStockViewController new];
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.navigationController pushViewController:vc animated:YES];
}

- (void)myStockTitle:(MyStockTitle *)cell sortType:(STOCK_SORT_STATE)type {
    _sortState = type;
    
    [self sortStock:_array];
    
    [_tableView reloadData];
}

- (void)sortStock:(NSArray *)array {
    if (_sortState == STOCK_SORT_DOWN)
    {
        [_resultListArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
            NSString *increase1 = ((StockListModel *)obj1).tradeIncrease;
            NSString *increase2 = ((StockListModel *)obj2).tradeIncrease;
            if([SystemUtil isPureFloat:increase1]&&[SystemUtil isPureFloat:increase2])
            {
                if ([increase1 doubleValue] > [increase2 doubleValue])
                {
                    return NSOrderedAscending;
                }
                else if ([increase1 doubleValue] < [increase2 doubleValue])
                {
                    return NSOrderedDescending;
                }
                else
                {
                    return NSOrderedSame;
                }
            }
            else if([SystemUtil isPureFloat:increase1])
            {
                return NSOrderedAscending;
            }
            else if([SystemUtil isPureFloat:increase2])
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedSame;
            }
        }];
    }
    else if (_sortState == STOCK_SORT_UP)
    {
        [_resultListArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
            NSString *increase1 = ((StockListModel *)obj1).tradeIncrease;
            NSString *increase2 = ((StockListModel *)obj2).tradeIncrease;
            NSLog(@"%i",[SystemUtil isPureFloat:increase1]);
            if([SystemUtil isPureFloat:increase1]&&[SystemUtil isPureFloat:increase2])
            {
                if ([increase1 doubleValue] > [increase2 doubleValue])
                {
                    return NSOrderedDescending;
                }
                else if ([increase1 doubleValue] < [increase2 doubleValue])
                {
                    return NSOrderedAscending;
                }
                else
                {
                    return NSOrderedSame;
                }
            }
            else if([SystemUtil isPureFloat:increase1])
            {
                return NSOrderedDescending;
            }
            else if([SystemUtil isPureFloat:increase2])
            {
                return NSOrderedAscending;
            }
            else
            {
                return NSOrderedSame;
            }
            
        }];
    }
    else
    {
        if (_array)
        {
            [_resultListArray removeAllObjects];
            [_resultListArray addObjectsFromArray:_array];
        }
    }
}

#pragma mark lazyloading

- (UILabel *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UILabel alloc] init];
        _bottomView.backgroundColor = kUIColorFromRGB(0xe9e9e9);
        _bottomView.text = @"同步自选股";
        _bottomView.textColor = kUIColorFromRGB(0x666666);
        _bottomView.font = [UIFont systemFontOfSize:14 * kScale];
        _bottomView.hidden = YES;
        _bottomView.textAlignment = NSTextAlignmentCenter;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _bottomView.userInteractionEnabled = YES;
        [_bottomView addGestureRecognizer:tap];
    }
    return _bottomView;
}

- (IndexInfoAPI *)indexInfoAPI {
    if (_indexInfoAPI == nil) {
        _indexInfoAPI = [[IndexInfoAPI alloc] initWithSymbolTyp:@"" symbol:@"" marketCd:@""];
    }
    return _indexInfoAPI;
}

- (MyStockTopView *)myStockTopView {
    if (_myStockTopView == nil) {
        _myStockTopView = [[MyStockTopView alloc] init];
        _myStockTopView.delegate = self;
    }
    return _myStockTopView;
}

@end
