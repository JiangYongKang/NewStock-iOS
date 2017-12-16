//
//  NewStockPerformViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "NewStockPerformViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"

#import "StockPerformAPI.h"
#import "StockPerformTableViewCell.h"
#import "StockPerformModel.h"

#import "Defination.h"
#import <Masonry.h>
#import "AppDelegate.h"

static NSString *cellID = @"NewStockPerformViewControllerCell";

@interface NewStockPerformViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) StockPerformAPI *stockPerformAPI;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray <StockPerformModel *> *dataArray;

@end

@implementation NewStockPerformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    [_navBar removeFromSuperview];
    self.title = @"上市表现";
    
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
    [self.stockPerformAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
    self.dataArray = [MTLJSONAdapter modelsOfClass:[StockPerformModel class] fromJSONArray:request.responseJSONObject error:nil];
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
    lb2.attributedText = [[NSAttributedString alloc] initWithString:@"发行价\n上市日期" attributes:@{NSParagraphStyleAttributeName : para}];
    lb2.numberOfLines = 0;
    lb2.textColor = kUIColorFromRGB(0x838383);
    lb2.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb3 = [[UILabel alloc] init];
    lb3.numberOfLines = 0;
    lb3.attributedText = [[NSAttributedString alloc] initWithString:@"最新价\n总涨幅" attributes:@{NSParagraphStyleAttributeName : para}];
    lb3.textColor = kUIColorFromRGB(0x838383);
    lb3.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb4 = [[UILabel alloc] init];
    lb4.numberOfLines = 0;
    lb4.text = @"每中一签获利";
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
        make.right.equalTo(view).offset(-120 * kScale);
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
    StockPerformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    StockPerformModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StockPerformModel *item = self.dataArray[indexPath.row];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (!(item.t && item.s && item.m && item.n)) {
        return;
    }
    
    if (([item.t intValue] == 1) || ([item.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.indexModel = model;
        [delegate.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.stockListModel = model;
        [delegate.navigationController pushViewController:viewController animated:YES];
    }

}

#pragma mark lazyloading

- (StockPerformAPI *)stockPerformAPI {
    if (_stockPerformAPI == nil) {
        _stockPerformAPI = [StockPerformAPI new];
        _stockPerformAPI.delegate = self;
        _stockPerformAPI.animatingView = self.view;
    }
    return _stockPerformAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        [_tableView registerClass:[StockPerformTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _tableView;
}

@end
