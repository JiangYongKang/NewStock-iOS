//
//  TaoContinueLimitCatchViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/21.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoContinueLimitCatchViewController.h"
#import "TaoDBSQAPI.h"
#import "TaoContinueLimitCatchTableViewCell.h"
#import "TaoCXZYModel.h"

#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "NativeUrlRedirectAction.h"
#import "SharedInstance.h"

static NSString *cellID = @"TaoContinueLimitCatchViewControllerCell";

@interface TaoContinueLimitCatchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) TaoDBSQAPI *listAPI;

@property (nonatomic, strong) UILabel *topLabel;

@end

@implementation TaoContinueLimitCatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share1_nor"]];

    self.title = @"连板捕捉";
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                     NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    _navBar.backgroundColor = kTitleColor;
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self.view addSubview:self.topLabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_navBar.mas_bottom);
        make.height.equalTo(@(30 * kScale));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).offset(0);
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
    
    self.topLabel.text = request.responseJSONObject[@"dsc"];
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[TaoCXZYStockModel class] fromJSONArray:request.responseJSONObject[@"list"] error:nil];
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

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    [self share];
}

- (void)share {
    NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_DB0002];
    
    [SharedInstance sharedSharedInstance].image = [UIImage imageNamed:@"shareLogo"];
    [SharedInstance sharedSharedInstance].tt = self.title;
    [SharedInstance sharedSharedInstance].c = self.topLabel.text;
    [SharedInstance sharedSharedInstance].url = url;
    [SharedInstance sharedSharedInstance].res_code = @"S_DBSQ";
    [SharedInstance sharedSharedInstance].sid = _listAPI.code;
    [[SharedInstance sharedSharedInstance] shareWithImage:NO];
}


#pragma mark tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoCXZYStockModel *model = self.dataArray[indexPath.row];
    CGFloat w = [model.r boundingRectWithSize:CGSizeMake(MAXFLOAT, [UIFont systemFontOfSize:12 * kScale].lineHeight) options:1 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12 * kScale]} context:nil].size.width;
    if (w > (MAIN_SCREEN_WIDTH - 24 * kScale)) {
        return 95 * kScale;
    }
    return 78 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self header];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoContinueLimitCatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    TaoCXZYStockModel *model = self.dataArray[indexPath.row];
    
    [cell setN:model.n s:model.s t:model.t zx:model.zx zdf:model.zdf r:model.r dayCount:model.dn limitCount:model.cln];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoCXZYStockModel *model = self.dataArray[indexPath.row];
    [NativeUrlRedirectAction nativePushToStock:model.n s:model.s t:model.t m:model.m];
}

#pragma mark lazy loading

- (TaoDBSQAPI *)listAPI {
    if (_listAPI == nil) {
        _listAPI = [TaoDBSQAPI new];
        _listAPI.page = @"1";
        _listAPI.count = @"20";
        _listAPI.code = @"lbbz";
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
        [_tableView registerClass:[TaoContinueLimitCatchTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _tableView;
}

- (UIView *)header {
    UIView *view = [UIView new];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"名称代码";
    lb1.textColor = kUIColorFromRGB(0x808080);
    lb1.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb2 = [UILabel new];
    lb2.text = @"最新价";
    lb2.textColor = kUIColorFromRGB(0x808080);
    lb2.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb3 = [UILabel new];
    lb3.text = @"涨跌幅";
    lb3.textColor = kUIColorFromRGB(0x808080);
    lb3.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb4 = [UILabel new];
    lb4.text = @"连板数";
    lb4.textColor = kUIColorFromRGB(0x808080);
    lb4.font = [UIFont systemFontOfSize:14 * kScale];
    
    UILabel *lb5 = [UILabel new];
    lb5.text = @"几天几板";
    lb5.textColor = kUIColorFromRGB(0x808080);
    lb5.font = [UIFont systemFontOfSize:14 * kScale];
    
    [view addSubview:lb1];
    [view addSubview:lb2];
    [view addSubview:lb3];
    [view addSubview:lb4];
    [view addSubview:lb5];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(12 * kScale);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(100 * kScale);
        make.centerY.equalTo(view);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.centerX.equalTo(view).offset(2 * kScale);
    }];
    
    [lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-93 * kScale);
    }];
    
    [lb5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-12 * kScale);
    }];
    
    return view;
}

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [UILabel new];
        _topLabel.backgroundColor = [UIColor whiteColor];
        _topLabel.textColor = kTitleColor;
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _topLabel;
}

@end
