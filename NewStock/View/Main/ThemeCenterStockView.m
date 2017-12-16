//
//  ThemeCenterStockView.m
//  NewStock
//
//  Created by 王迪 on 2017/5/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ThemeCenterStockView.h"
#import "IdleFundStockCellTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

static NSString *cellID = @"ThemeCenterStockViewCell";

@interface ThemeCenterStockView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ThemeCenterStockView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 44 * kScale)];
    topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);

    UILabel *topLb = [[UILabel alloc] init];
    topLb.textColor = kUIColorFromRGB(0x333333);
    topLb.font = [UIFont boldSystemFontOfSize:14 * kScale];
    topLb.text = @"关联个股";
    topLb.textAlignment = NSTextAlignmentLeft;
    
    [topView addSubview:topLb];
    
    UILabel *redB = [UILabel new];
    redB.backgroundColor = kUIColorFromRGB(0xff1919);
    [topView addSubview:redB];
    [redB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(12 * kScale);
        make.centerY.equalTo(topView);
        make.width.equalTo(@(2 * kScale));
        make.height.equalTo(@(12 * kScale));
    }];
    
    [topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(redB.mas_right).offset(10 * kScale);
    }];
    

    
    UIView *bottomView = [UIView new];
    UILabel *lb1 = [UILabel new];
    lb1.text = @"名称/代码";
    lb1.textColor = kUIColorFromRGB(0x666666);
    lb1.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb2 = [UILabel new];
    lb2.text = @"最新";
    lb2.textColor = kUIColorFromRGB(0x666666);
    lb2.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *lb3 = [UILabel new];
    lb3.text = @"涨跌幅";
    lb3.textColor = kUIColorFromRGB(0x666666);
    lb3.font = [UIFont systemFontOfSize:12 * kScale];
    
    [bottomView addSubview:lb1];
    [bottomView addSubview:lb2];
    [bottomView addSubview:lb3];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(12 * kScale);
        make.centerY.equalTo(bottomView);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomView);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(bottomView).offset(-12 * kScale);
    }];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bottomView);
        make.height.equalTo(@(0.5));
    }];
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 76 * kScale)];
    [coverView addSubview:topView];
    [coverView addSubview:bottomView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(coverView);
        make.height.equalTo(@(44 * kScale));
    }];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(coverView);
        make.top.equalTo(topView.mas_bottom);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.tableView.tableHeaderView = coverView;
}

#pragma mark action

- (void)setDataArray:(NSArray <ThemeDetailStockModel *> *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}


#pragma mark tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IdleFundStockCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    IdleFundStockListModel *model = [IdleFundStockListModel new];
    ThemeDetailStockModel *item = self.dataArray[indexPath.row];
    model.t = item.t;
    model.s = item.s;
    model.n = item.n;
    model.m = item.m;
    model.zdf = item.zdf;
    model.zx = item.zx;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ThemeDetailStockModel *model = self.dataArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(ThemeCenterStockViewStockClick:)]) {
        [self.delegate ThemeCenterStockViewStockClick:model];
    }
}

#pragma mark lazy loading

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[IdleFundStockCellTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12 * kScale, 0, 12 * kScale);
    }
    return _tableView;
}

@end
