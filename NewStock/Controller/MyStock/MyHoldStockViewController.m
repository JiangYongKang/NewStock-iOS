//
//  MyHoldStockViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/1/5.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyHoldStockViewController.h"
#import "LoginViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"

#import "SystemUtil.h"
#import "MarketConfig.h"
#import "Defination.h"
#import "AppDelegate.h"

#import "GetMyAssetAPI.h"
#import "MyAssetModel.h"

#import "MyStockHeaderView.h"
#import "MyHoldStockCell.h"

#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"

static NSString *cellID = @"myHoldCell";

@interface MyHoldStockViewController () <APIRequestDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MyStockHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray <MyAssetListModel *>*dataArray;

@property (nonatomic, strong) GetMyAssetAPI *getMyAssetAPI;

@property (nonatomic, strong) UIView *noStockView;

@property (nonatomic, assign) BOOL isPosting;

@end

@implementation MyHoldStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.view addSubview:self.noStockView];
    [self.noStockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(168 * kScale);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)loadData {
    
    if (self.isPosting == YES) {
        return;
    }
 
    if ([SystemUtil isSignIn]) {
        [self.getMyAssetAPI start];
        self.isPosting = YES;
        self.tableView.scrollEnabled = YES;
        self.noStockView.hidden = YES;
    }else {
        self.tableView.scrollEnabled = NO;
        self.noStockView.hidden = NO;
        [self.headerView setInitValue];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
    [self.tableView.mj_header endRefreshing];
    self.isPosting = NO;
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
    self.isPosting = NO;
    MyAssetModel *model = [MTLJSONAdapter modelOfClass:[MyAssetModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    
    if (model.bookValue.floatValue == 0) {
        self.tableView.scrollEnabled = NO;
        self.noStockView.hidden = NO;
        [self.headerView setInitValue];
    }else {
        [self.headerView setTotalMarketValue:model.bookValue buy:model.cost today:model.currEarnings totalEarn:model.allEarnings];
    }
    NSArray *arr = model.posList;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:arr];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    if ([SystemUtil isSignIn]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:HOLDING_SHEET_MSG object:nil];
    }else {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:loginViewController animated:YES];
    }

}

#pragma mark tableView ---------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyAssetListModel *model = self.dataArray[indexPath.row];
    
    MyHoldStockCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    MyAssetListModel *item = self.dataArray[indexPath.row];

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

#pragma mark -----------------------------------

- (MyStockHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[MyStockHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 164 * kScale)];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = REFRESH_BG_COLOR;
        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[MyHoldStockCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (GetMyAssetAPI *)getMyAssetAPI {
    if (_getMyAssetAPI == nil) {
        _getMyAssetAPI = [[GetMyAssetAPI alloc] init];
        _getMyAssetAPI.delegate = self;
    }
    return _getMyAssetAPI;
}

- (UIView *)noStockView {
    if (_noStockView == nil) {
        _noStockView = [[UIView alloc] init];
        _noStockView.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_noStock_nor"]];
        [_noStockView addSubview:img];
        img.userInteractionEnabled = YES;
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_noStockView);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [img addGestureRecognizer:tap];
        
        UILabel *lb = [UILabel new];
        lb.text = @"暂无持仓记录,请手动添加";
        lb.textColor = kUIColorFromRGB(0x999999);
        lb.font = [UIFont systemFontOfSize:12];
        [_noStockView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noStockView);
            make.top.equalTo(img.mas_bottom).offset(10);
        }];
        _noStockView.hidden = YES;
    }
    return _noStockView;
}

@end
