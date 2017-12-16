//
//  TaoZhuLiStockListViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/20.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoZhuLiStockListViewController.h"
#import "TaoSearchStockViewController.h"
#import "ZhuangGuViewController.h"
#import "TaoStockPoolListAPI.h"
#import "TaoStockUniversalCell.h"
#import "TaoPoolListModel.h"
#import "MarketConfig.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"

static NSString *cellID = @"TaoZhuLiStockListViewControllerCell";

@interface TaoZhuLiStockListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TaoStockPoolListAPI *poolListAPI;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <TaoPoolListModel *> *dataArray;

@end

@implementation TaoZhuLiStockListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    self.title = @"主力股票池";
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                     NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    _navBar.backgroundColor = kTitleColor;
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.bottom.left.right.equalTo(self.view);
    }];
    
    [self.poolListAPI start];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark loadData

- (void)loadData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    [self.poolListAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [self.tableView.mj_header endRefreshing];
}

- (void)requestFinished:(APIBaseRequest *)request {
    self.dataArray = [MTLJSONAdapter modelsOfClass:[TaoPoolListModel class] fromJSONArray:request.responseJSONObject error:nil];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark action

- (void)btnClick:(UIButton *)btn {
    TaoPoolListModel *model = self.dataArray[btn.tag];
    
    NSLog(@"%@",model.code);
    
    ZhuangGuViewController *vc = [ZhuangGuViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark tableView dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    TaoPoolListModel *model = self.dataArray[section];
    return [self headerWithTag:section title:model.title];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TaoPoolListModel *model = self.dataArray[section];
    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoStockUniversalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    TaoPoolListModel *model = self.dataArray[indexPath.section];
    TaoPoolListStockModel *m = model.list[indexPath.row];
    
    [cell setN:m.n s:m.s t:m.t zx:m.zx zdf:m.zdf];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoPoolListModel *model = self.dataArray[indexPath.section];
    TaoPoolListStockModel *m = model.list[indexPath.row];
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    vc.t = m.t;
    vc.s = m.s;
    vc.m = m.m;
    vc.n = m.n;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark lazy loading

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        [_tableView registerClass:[TaoStockUniversalCell class] forCellReuseIdentifier:cellID];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _tableView;
}

- (TaoStockPoolListAPI *)poolListAPI {
    if (_poolListAPI == nil) {
        _poolListAPI = [TaoStockPoolListAPI new];
        _poolListAPI.delegate = self;
    }
    return _poolListAPI;
}

- (UIView *)headerWithTag:(NSInteger)tag title:(NSString *)title{
    UIView *view = [UIView new];
    view.backgroundColor = kUIColorFromRGB(0xffffff);
    
    UIView *topV = [UIView new];
    topV.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UIView *botV = [UIView new];
    botV.backgroundColor = kUIColorFromRGB(0xffffff);
    
    UILabel *bottomLb = [UILabel new];
    bottomLb.textColor = kUIColorFromRGB(0x333333);
    bottomLb.text = title;
    bottomLb.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *blockLb = [UILabel new];
    blockLb.backgroundColor = RISE_COLOR;
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
    [btn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"theme_arror_ico"] forState:UIControlStateNormal];
    btn.tag = tag;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, -30);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    
    [view addSubview:topV];
    [view addSubview:botV];
    [view addSubview:bottomLb];
    [view addSubview:blockLb];
    [view addSubview:btn];
    [view addSubview:line];
    
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view);
        make.height.equalTo(@(10 * kScale));
    }];
    [botV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(view);
        make.top.equalTo(topV.mas_bottom);
    }];
    [blockLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(2 * kScale));
        make.height.equalTo(@(12 * kScale));
        make.centerY.equalTo(botV);
        make.left.equalTo(botV).offset(12);
    }];
    [bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(blockLb.mas_right).offset(6 * kScale);
        make.centerY.equalTo(botV);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(botV).offset(-12 * kScale);
        make.top.bottom.equalTo(botV);
    }];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(view);
//        make.height.equalTo(@(0.5 * kScale));
//    }];
    
    return view;
}

@end
