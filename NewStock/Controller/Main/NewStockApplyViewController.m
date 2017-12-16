//
//  NewStockApplyViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "NewStockApplyViewController.h"
#import "StockApplyDetailViewController.h"

#import "NativeUrlRedirectAction.h"
#import "StockApplyAPI.h"
#import "Defination.h"
#import "StockApplyModel.h"
#import "StockApplyTableHeaderView.h"
#import "StockApplyTableViewCell.h"
#import <Masonry.h>
#import "AppDelegate.h"

static NSString *cellID = @"NewStockApplyViewControllerCell";

@interface NewStockApplyViewController () <UITableViewDelegate,UITableViewDataSource,StockApplyTableHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) StockApplyAPI *stockApplyAPI;

@property (nonatomic, strong) NSArray <StockApplyModel *> *dataArray;

@end

@implementation NewStockApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    [_navBar removeFromSuperview];
    self.title = @"新股申购";
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark loaddata

- (void)loadData {
    [self.stockApplyAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
    self.dataArray = [MTLJSONAdapter modelsOfClass:[StockApplyModel class] fromJSONArray:request.responseJSONObject error:nil];
    
    [self.tableView reloadData];
}

#pragma mark action 

- (void)stockApplyTableHeaderViewClick {
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:@"./jiabei/TR0001"];
}

#pragma mark delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    StockApplyTableHeaderView *view = [[StockApplyTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 81 * kScale)];
    view.model = self.dataArray[section];
    view.delegate = self;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 81 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    StockApplyModel *model = self.dataArray[section];
    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StockApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    StockApplyModel *model = self.dataArray[indexPath.section];
    cell.model = model.list[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StockApplyModel *model = self.dataArray[indexPath.section];

    StockApplyModelList *item = model.list[indexPath.row];
    
    StockApplyDetailViewController *vc = [StockApplyDetailViewController new];
    vc.n = item.n;
    vc.s = item.s;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.navigationController pushViewController:vc animated:YES];
}

#pragma mark lazyloading

- (StockApplyAPI *)stockApplyAPI {
    if (_stockApplyAPI == nil) {
        _stockApplyAPI = [StockApplyAPI new];
        _stockApplyAPI.st = @"0";
        _stockApplyAPI.delegate = self;
        _stockApplyAPI.animatingView = self.view;
    }
    return _stockApplyAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[StockApplyTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
