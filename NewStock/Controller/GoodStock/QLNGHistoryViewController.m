//
//  QLNGHistoryViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "QLNGHistoryViewController.h"
#import "TaoQLNGHistoryListAPI.h"
#import "TaoQLNGListModel.h"
#import "TaoQLNGTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "NativeUrlRedirectAction.h"

static NSString *cellID = @"QLNGHistoryViewControllerCell";

@interface QLNGHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TaoQLNGHistoryListAPI *listAPI;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *tableFooterView;

@end

@implementation QLNGHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                     NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    _navBar.backgroundColor = kTitleColor;
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBar.mas_bottom).offset(0 * kScale);
        make.bottom.left.right.equalTo(self.view);
    }];
    
    [self.listAPI start];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark request

- (void)loadData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    self.listAPI.page = @"1";
    [self.listAPI start];
}

- (void)loadMoreData {
    self.listAPI.page = [NSString stringWithFormat:@"%zd",self.listAPI.page.integerValue + 1];
    [self.listAPI start];
}

- (void)requestFinished:(APIBaseRequest *)request {
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[TaoQLNGListModel class] fromJSONArray:request.responseJSONObject error:nil];
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
    [self.tableView reloadData];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

#pragma mark action

#pragma mark tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    UILabel *lb = [UILabel new];
    lb.textColor = kUIColorFromRGB(0x999999);
    lb.font = [UIFont systemFontOfSize:12 * kScale];
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(v);
        make.left.equalTo(v).offset(12 * kScale);
    }];
    TaoQLNGListModel *m = self.dataArray[section];
    lb.text = m.tm;
    
    return v;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TaoQLNGListModel *model = self.dataArray[section];

    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoQLNGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    TaoQLNGListModel *m = self.dataArray[indexPath.section];
    TaoQLNGStockListModel *model = m.list[indexPath.row];
    [cell setN:model.n s:model.s zx:model.zx zdf:model.zdf enterPrice:model.inPrice maxZdf:model.highestChg];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoQLNGListModel *m = self.dataArray[indexPath.section];
    TaoQLNGStockListModel *model = m.list[indexPath.row];
    [NativeUrlRedirectAction nativePushToStock:model.n s:model.s t:model.t m:model.m];
}

#pragma mark lazy loading

- (TaoQLNGHistoryListAPI *)listAPI {
    if (_listAPI == nil) {
        _listAPI = [TaoQLNGHistoryListAPI new];
        _listAPI.page = @"1";
        _listAPI.count = @"5";
        _listAPI.ids = self.ids;
        _listAPI.delegate = self;
    }
    return _listAPI;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[TaoQLNGTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _tableView.tableFooterView = self.tableFooterView;
        _tableView.tableHeaderView = [self header];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _tableView;
}

- (UIView *)header {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 35 * kScale)];
    view.backgroundColor = kUIColorFromRGB(0xffffff);
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"名称代码";
    lb1.textColor = kUIColorFromRGB(0x808080);
    lb1.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb2 = [UILabel new];
    lb2.text = @"入选价格";
    lb2.textColor = kUIColorFromRGB(0x808080);
    lb2.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb3 = [UILabel new];
    lb3.text = @"最新";
    lb3.textColor = kUIColorFromRGB(0x808080);
    lb3.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb4 = [UILabel new];
    lb4.text = @"最高涨幅";
    lb4.textColor = kUIColorFromRGB(0x808080);
    lb4.font = [UIFont systemFontOfSize:14 * kScale];
    
    [view addSubview:lb1];
    [view addSubview:lb2];
    [view addSubview:lb3];
    [view addSubview:lb4];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(12 * kScale);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(120 * kScale);
        make.centerY.equalTo(view);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-115 * kScale);
    }];
    
    [lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-12 * kScale);
    }];
    
    return view;
}

- (UIView *)tableFooterView {
    if (_tableFooterView == nil) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 50 * kScale)];
        UILabel *lb = [UILabel new];
        lb.text = @"以上结果仅供参考,不构成投资依据";
        lb.textColor = kUIColorFromRGB(0x999999);
        lb.font = [UIFont systemFontOfSize:11 * kScale];
        [_tableFooterView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableFooterView).offset(20 * kScale);
            make.centerX.equalTo(_tableFooterView);
        }];
    }
    return _tableFooterView;
}

@end
