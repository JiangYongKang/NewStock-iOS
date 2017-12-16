//
//  StockApplyDetailViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/29.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockApplyDetailViewController.h"
#import "NewStockApplyDetailTableViewCell.h"
#import "StockApplyDetailAPI.h"
#import "StockApplyDetailModel.h"

#import "Defination.h"
#import <Masonry.h>
#import "NativeUrlRedirectAction.h"
#import "AppDelegate.h"

static NSString *cellID = @"StockApplyDetailViewControllerCell";

@interface StockApplyDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) StockApplyDetailAPI *stockApplyAPI;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIButton *bottomBtn;

@property (nonatomic) NSArray *dataArray1;
@property (nonatomic) NSArray *dataArray2;

@property (nonatomic) NSArray *nameArray1;
@property (nonatomic) NSArray *nameArray2;

@property (nonatomic) StockApplyDetailModel *model;

@end

@implementation StockApplyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    self.title = self.n;
    
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                 NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    _navBar.backgroundColor = kTitleColor;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64 * kScale);
    }];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(49 * kScale));
    }];
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self loadData];
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
    [self.stockApplyAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
    _model = [MTLJSONAdapter modelOfClass:[StockApplyDetailModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    
    for (int i = 0 ; i < self.dataArray1.count; i ++) {
        StockApplyDetailValueModel *model = self.dataArray1[i];
        switch (i) {
            case 0:
                model.value = _model.n;
                break;
            case 1:
                model.value = _model.s;
                break;
            case 2:
                model.value = _model.sd;
                break;
            case 3:
                model.value = _model.pd;
                break;
            case 4:
                model.value = [NSString stringWithFormat:@"%.6lf%%",_model.lr.floatValue];
                break;
            case 5:
                model.value = _model.tm;
                break;
        }
    }
    
    for (int i = 0 ; i < self.dataArray2.count; i ++) {
        StockApplyDetailValueModel *model = self.dataArray2[i];
        switch (i) {
            case 0:
                model.value = [NSString stringWithFormat:@"%.2lf",_model.pr.floatValue];
                break;
            case 1:
                model.value = [NSString stringWithFormat:@"%.2lf",_model.pe.floatValue];
                break;
            case 2:
                model.value = [self getStockCount:_model.iv];
                break;
            case 3:
                model.value = [self getStockCount:_model.iiv];
                break;
            case 4:
                model.value = [self getStockCount:_model.mx];
                break;
            case 5:
                model.value = [self getStockCount:_model.tl];
                break;
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark action

- (NSString *)getStockCount:(NSString *)count {
    NSInteger c = count.integerValue;
    NSString *str = @"";
    if (c > 100000000) {
        str = [NSString stringWithFormat:@"%.2lf亿股",c / 100000000.00];
    } else if (c > 10000) {
        str = [NSString stringWithFormat:@"%.2lf万股",c / 10000.00];
    } else {
        str = [NSString stringWithFormat:@"%zd股",c];
    }
    return str;
}

- (void)bottomBtnClick:(UIButton *)btn {
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:@"./jiabei/TR0001"];
}

#pragma mark delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        CGFloat height = [_model.desc boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH - 24 * kScale, MAXFLOAT) options:1 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13 * kScale]} context:nil].size.height + 24 * kScale;
        return height;
    }
    return 36 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *str = @"";
    
    if (section == 0) {
        str = @"申购详情";
    } else if (section == 1) {
        str = @"发行资料";
    } else if (section == 2) {
        str = @"公司简介";
    }
    
    return [self getHeaderView:str];;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    } else if (section == 1) {
        return 6;
    } else if (section == 2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewStockApplyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (indexPath.section == 0) {
        StockApplyDetailValueModel *model = self.dataArray1[indexPath.row];
        [cell setName:model.name value:model.value];
    } else if (indexPath.section == 1) {
        StockApplyDetailValueModel *model = self.dataArray2[indexPath.row];
        [cell setName:model.name value:model.value];
    } else if (indexPath.section == 2) {
        [cell setName:_model.desc value:@""];
    }
    
    return cell;
}

#pragma mark lazyloading

- (StockApplyDetailAPI *)stockApplyAPI {
    if (_stockApplyAPI == nil) {
        _stockApplyAPI = [StockApplyDetailAPI new];
        _stockApplyAPI.s = self.s;
        _stockApplyAPI.delegate = self;
        _stockApplyAPI.animatingView = self.view;
    }
    return _stockApplyAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        [_tableView registerClass:[NewStockApplyDetailTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 70 * kScale)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIView *)getHeaderView:(NSString *)str {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 30 * kScale)];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    UILabel *lb = [UILabel new];
    lb.text = str;
    lb.font = [UIFont boldSystemFontOfSize:13 * kScale];
    lb.textColor = kUIColorFromRGB(0x333333);
    
    [view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(12 * kScale);
    }];
    
    return view;
}

- (UIButton *)bottomBtn {
    if (_bottomBtn == nil) {
        _bottomBtn = [UIButton new];
        _bottomBtn.backgroundColor = kUIColorFromRGB(0xf34851);
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16 * kScale];
        [_bottomBtn setTitle:@"立即申购" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (NSArray *)dataArray1 {
    if (_dataArray1 == nil) {
        NSMutableArray *nmA = [NSMutableArray array];
        for (int i = 0; i < 6; i ++) {
            StockApplyDetailValueModel *model = [StockApplyDetailValueModel new];
            model.name = self.nameArray1[i];
            model.value = @"";
            [nmA addObject:model];
        }
        _dataArray1 = nmA.copy;
    }
    return _dataArray1;
}

- (NSArray *)dataArray2 {
    if (_dataArray2 == nil) {
        NSMutableArray *nmA = [NSMutableArray array];
        for (int i = 0; i < 6; i ++) {
            StockApplyDetailValueModel *model = [StockApplyDetailValueModel new];
            model.name = self.nameArray2[i];
            model.value = @"";
            [nmA addObject:model];
        }
        _dataArray2 = nmA.copy;
    }
    return _dataArray2;
}

- (NSArray *)nameArray1 {
    if (_nameArray1 == nil) {
        _nameArray1 = @[@"股票名称",@"申购代码",@"申购日期",@"中签缴纳日期",@"中签率",@"上市日期"];
    }
    return _nameArray1;
}

- (NSArray *)nameArray2 {
    if (_nameArray2 == nil) {
        _nameArray2 = @[@"发行价格",@"发行市盈率",@"发行数量",@"网上发行数量",@"申购上限",@"申购资金上限"];
    }
    return _nameArray2;
}

@end
