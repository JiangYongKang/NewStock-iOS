//
//  TaoDeepDeathViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoDeepDeathViewController.h"
#import "TaoStockUniversalCell.h"
#import "TaoDeepListAPI.h"
#import "TaoDeepStockModel.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "NativeUrlRedirectAction.h"

static NSString *cellID = @"TaoDeepStockViewControllerCell";

@interface TaoDeepDeathViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) TaoDeepListAPI *listAPI;

@property (nonatomic, strong) UIButton *buyBtn;

@property (nonatomic, strong) UIButton *zdfBtn;

@property (nonatomic, strong) UIButton *reasonBtn;

@property (nonatomic, strong) UIButton *lastSelectBtn;

@end

@implementation TaoDeepDeathViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    _navBar.hidden = YES;
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0 * kScale);
        make.left.right.bottom.equalTo(self.view);
    }];
    
//    UIView *topView = [UIView new];
//    topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
//    [self.view addSubview:topView];
//    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(self.view);
//        make.height.equalTo(@(40 * kScale));
//    }];
//    
//    [topView addSubview:self.buyBtn];
//    [topView addSubview:self.zdfBtn];
//    //    [topView addSubview:self.reasonBtn];
//    
//    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(topView.mas_centerX).offset(-15 * kScale);
//        make.centerY.equalTo(topView);
//    }];
//    
//    [self.zdfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(topView.mas_centerX).offset(15 * kScale);
//        make.centerY.equalTo(topView);
//    }];
//    //    [self.reasonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//    //        make.centerY.equalTo(topView);
//    //        make.right.equalTo(self.view).offset(-50 * kScale);
//    //    }];
//    
//    self.lastSelectBtn = self.buyBtn;
//    self.buyBtn.selected = YES;
    
}

#pragma mark requset

- (void)loadData {
    self.listAPI.date = self.date;
    if (self.listAPI.date == nil || self.listAPI.code == nil || self.listAPI.option == nil) {
        NSLog(@"lost %@ %@ %@",_listAPI.date,_listAPI.code,_listAPI.option);
        [_tableView.mj_header endRefreshing];
        return;
    }
    [self.listAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [self.tableView.mj_header endRefreshing];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    
    self.dataArray = [MTLJSONAdapter modelsOfClass:[TaoDeepStockModel class] fromJSONArray:request.responseJSONObject[@"list"] error:nil];
    if ([self.delegate respondsToSelector:@selector(taoDeepTigerSendCount:)]) {
        [self.delegate taoDeepTigerSendCount:[NSString stringWithFormat:@"%zd",_dataArray.count]];
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark action

- (void)topBtnClick:(UIButton *)btn {
    self.lastSelectBtn.selected = NO;
    self.lastSelectBtn = btn;
    btn.selected = YES;
    if ([btn.titleLabel.text containsString:@"净买入"]) {
        _listAPI.option = @"jmr";
    } else if ([btn.titleLabel.text containsString:@"涨跌幅"]) {
        _listAPI.option = @"zdf";
    } else if ([btn.titleLabel.text containsString:@"理由"]) {
        _listAPI.option = @"sbly";
    }
    
    [self loadData];
}

- (void)scrollToTop {
    [_tableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32 * kScale;
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
    
    TaoStockUniversalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    TaoDeepStockModel *model = self.dataArray[indexPath.row];
    
    [cell setN:model.n s:model.s t:model.t zx:model.price zdf:model.zdf];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoDeepStockModel *model = self.dataArray[indexPath.row];
    [NativeUrlRedirectAction nativePushToTigetStock:model.n s:model.s t:model.t m:model.m d:self.date];
}

#pragma mark lazy loading

- (TaoDeepListAPI *)listAPI {
    if (_listAPI == nil) {
        _listAPI = [TaoDeepListAPI new];
        _listAPI.code = @"gsd";
        _listAPI.date = @"";
        _listAPI.option = @"";
        _listAPI.delegate = self;
        _listAPI.animatingView = self.view;
    }
    return _listAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[TaoStockUniversalCell class] forCellReuseIdentifier:cellID];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _tableView;
}

- (UIView *)header {
    UIView *view = [UIView new];
    view.backgroundColor = kUIColorFromRGB(0xffffff);
    
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
    
    [view addSubview:lb1];
    [view addSubview:lb2];
    [view addSubview:lb3];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(12 * kScale);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX).offset(0 * kScale);
        make.centerY.equalTo(view);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-12 * kScale);
    }];
    
    UILabel *line1 = [UILabel new];
    line1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    
    UILabel *line2 = [UILabel new];
    line2.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    
    [view addSubview:line1];
    [view addSubview:line2];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view);
        make.height.equalTo(@(0.5));
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(view);
        make.height.equalTo(@(0.5));
    }];
    
    return view;
}

- (UIButton *)buyBtn {
    if (_buyBtn == nil) {
        _buyBtn = [UIButton new];
        [_buyBtn setTitle:@"按净买入" forState:UIControlStateNormal];
        [_buyBtn setImage:[UIImage imageNamed:@"ic_deep_sel"] forState:UIControlStateSelected];
        [_buyBtn setImage:[UIImage imageNamed:@"ic_deep_noSel"] forState:UIControlStateNormal];
        [_buyBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_buyBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _buyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    }
    return _buyBtn;
}

- (UIButton *)zdfBtn {
    if (_zdfBtn == nil) {
        _zdfBtn = [UIButton new];
        [_zdfBtn setTitle:@"按涨跌幅" forState:UIControlStateNormal];
        [_zdfBtn setImage:[UIImage imageNamed:@"ic_deep_sel"] forState:UIControlStateSelected];
        [_zdfBtn setImage:[UIImage imageNamed:@"ic_deep_noSel"] forState:UIControlStateNormal];
        [_zdfBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _zdfBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_zdfBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _zdfBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    }
    return _zdfBtn;
}

- (UIButton *)reasonBtn {
    if (_reasonBtn == nil) {
        _reasonBtn = [UIButton new];
        [_reasonBtn setTitle:@"上榜理由" forState:UIControlStateNormal];
        [_reasonBtn setImage:[UIImage imageNamed:@"ic_deep_sel"] forState:UIControlStateSelected];
        [_reasonBtn setImage:[UIImage imageNamed:@"ic_deep_noSel"] forState:UIControlStateNormal];
        [_reasonBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _reasonBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_reasonBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _reasonBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    }
    return _reasonBtn;
}


@end
