//
//  TaoQLNGCommentViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGCommentViewController.h"
#import "TaoQLNGCommentListAPI.h"
#import "TaoQLNGCommentModel.h"
#import "TaoQLNGCell.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "NativeUrlRedirectAction.h"

static NSString *cellID = @"TaoQLNGCommentViewControllerCell";

@interface TaoQLNGCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) TaoQLNGCommentListAPI *listAPI;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation TaoQLNGCommentViewController

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
        make.top.equalTo(_navBar.mas_bottom).offset(0);
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
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[TaoQLNGCommentModel class] fromJSONArray:request.responseJSONObject[@"list"] error:nil];
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

#pragma mark tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoQLNGCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    TaoQLNGCommentModel *model = self.dataArray[indexPath.row];
    
    CGFloat rowH = [cell setUserIcon:model.icon n:model.name c:model.c tm:model.tm];
    
    return rowH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoQLNGCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    TaoQLNGCommentModel *model = self.dataArray[indexPath.row];
    
    [cell setUserIcon:model.icon n:model.name c:model.c tm:model.tm];
    
    return cell;
}

#pragma mark lazy loading

- (TaoQLNGCommentListAPI *)listAPI {
    if (_listAPI == nil) {
        _listAPI = [TaoQLNGCommentListAPI new];
        _listAPI.page = @"1";
        _listAPI.count = @"20";
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
        [_tableView registerClass:[TaoQLNGCell class] forCellReuseIdentifier:cellID];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _tableView;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 35 * kScale)];
        _headerView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        UILabel *lb = [UILabel new];
        lb.text = @"全部评价";
        lb.font = [UIFont systemFontOfSize:14 * kScale];
        lb.textColor = kUIColorFromRGB(0x999999);
        [_headerView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerView).offset(12 * kScale);
            make.centerY.equalTo(_headerView);
        }];
    }
    return _headerView;
}

@end
