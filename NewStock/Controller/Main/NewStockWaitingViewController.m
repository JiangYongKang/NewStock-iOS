//
//  NewStockWaitingViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/29.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "NewStockWaitingViewController.h"
#import "StockApplyDetailViewController.h"

#import "NewStockWaitingTableViewCell.h"
#import "StockApplyAPI.h"
#import "StockApplyModel.h"

#import "Defination.h"
#import <Masonry.h>
#import "NativeUrlRedirectAction.h"
#import "AppDelegate.h"

static NSString *cellID = @"NewStockWaitingViewControllerCell";

@interface NewStockWaitingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) StockApplyAPI *stockApplyAPI;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray <StockApplyModelList *> *dataArray;

@end

@implementation NewStockWaitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    [_navBar removeFromSuperview];
    self.title = @"等待上市";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(5 * kScale);
    }];
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self loadData];
}

#pragma mark loadData

- (void)loadData {
    [self.stockApplyAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[StockApplyModel class] fromJSONArray:request.responseJSONObject error:nil];
    NSMutableArray *nmArr = [NSMutableArray array];
    for (StockApplyModel *model in array) {
        [nmArr addObjectsFromArray:model.list];
    }
    self.dataArray = nmArr.copy;
    [self.tableView reloadData];
}

#pragma mark delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 49 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 50 * kScale)];
    view.backgroundColor = kUIColorFromRGB(0xffffff);
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 4;
    
    UILabel *lb1 = [[UILabel alloc] init];
    lb1.numberOfLines = 0;
    lb1.attributedText = [[NSAttributedString alloc] initWithString:@"名称\n代码" attributes:@{NSParagraphStyleAttributeName : para}];
    lb1.textColor = kUIColorFromRGB(0x838383);
    lb1.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb2 = [[UILabel alloc] init];
    lb2.text = @"发行价";
    lb2.textColor = kUIColorFromRGB(0x838383);
    lb2.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb3 = [[UILabel alloc] init];
    lb3.text = @"申购日期";
    lb3.textColor = kUIColorFromRGB(0x838383);
    lb3.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb4 = [[UILabel alloc] init];
    lb4.text = @"中签率";
    lb4.textColor = kUIColorFromRGB(0x838383);
    lb4.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb5 = [UILabel new];
    lb5.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    
    [view addSubview:lb1];
    [view addSubview:lb2];
    [view addSubview:lb3];
    [view addSubview:lb4];
    [view addSubview:lb5];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(12 * kScale);
        make.centerY.equalTo(view);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lb1.mas_right).offset(75 * kScale);
        make.centerY.equalTo(view);
    }];
    
    [lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-12 * kScale);
        make.centerY.equalTo(view);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-123 * kScale);
    }];
    
    [lb5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.equalTo(@(0.5));
    }];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewStockWaitingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    StockApplyModelList *model = self.dataArray[indexPath.row];
    
    [cell setName:model.n code:model.s price:model.pr tm:model.tm rate:model.lr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StockApplyModelList *item = self.dataArray[indexPath.row];

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
        _stockApplyAPI.st = @"3";
        _stockApplyAPI.delegate = self;
        _stockApplyAPI.animatingView = self.view;
    }
    return _stockApplyAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        [_tableView registerClass:[NewStockWaitingTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _tableView;
}

@end
