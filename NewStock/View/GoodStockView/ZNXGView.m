//
//  ZNXGView.m
//  NewStock
//
//  Created by 王迪 on 2017/3/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ZNXGView.h"
#import "Defination.h"
#import <Masonry.h>
#import "IdleFundStockCellTableViewCell.h"

static NSString *cellID = @"idleFundCell";

@interface ZNXGView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *topNameLb;
@property (nonatomic, strong) UILabel *topTimeLb;
@property (nonatomic, strong) UIButton *topMoreBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <TaoIndexModelListClild *> *dataArray;

@end

@implementation ZNXGView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    [self addSubview:self.topView];
    [self.topView addSubview:self.topNameLb];
    [self.topView addSubview:self.topTimeLb];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(58 * kScale));
    }];
    
    [self.topNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(25 * kScale);
        make.top.equalTo(self.topView).offset(12 * kScale);
    }];
    
    [self.topTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topNameLb);
        make.top.equalTo(self.topNameLb.mas_bottom).offset(3 * kScale);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
}

- (void)setModel:(TaoIndexModelList *)model {
    _model = model;
    
    self.dataArray = model.child;
    
    self.topNameLb.text = model.n;
    self.topTimeLb.text = [NSString stringWithFormat:@"%@  %@",model.tm,model.slg];
    
    [self.tableView reloadData];
}

- (void)moreBtnClick:(UIButton *)btn {
    TaoIndexModelListClild *model = self.dataArray[btn.tag];
    if (self.urlBlock) {
        self.urlBlock(model.url);
    }
}

#pragma mark tableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 42 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 42 * kScale)];
    //设置左边文字
    UILabel *lb = [UILabel new];
    lb.textColor = kTitleColor;
    lb.font = [UIFont systemFontOfSize:14 * kScale];
    [view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15 * kScale);
        make.centerY.equalTo(view);
    }];
    TaoIndexModelListClild *model = self.dataArray[section];
    lb.text = model.n;
    //设置右侧按钮
    UIButton *moreBtn = [[UIButton alloc] init];
    moreBtn.tag = section;
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"tao_more_nor"] forState:UIControlStateNormal];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, -30)];
    [moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [moreBtn setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15 * kScale);
        make.centerY.equalTo(view);
        make.height.equalTo(@(42 * kScale));
        make.width.equalTo(@(42 * kScale));
    }];
    
    UILabel *topLine = [UILabel new];
    topLine.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [view addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view);
        make.height.equalTo(@(0.5 * kScale));
    }];
    
    UILabel *bottomLine = [UILabel new];
    bottomLine.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view);
        make.left.equalTo(view).offset(15 * kScale);
        make.right.equalTo(view).offset(-15 * kScale);
        make.height.equalTo(@(0.5 * kScale));
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49 * kScale;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TaoIndexModelListClild *model = self.dataArray[section];
    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IdleFundStockCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    TaoIndexModelListClild *model = self.dataArray[indexPath.section];
    cell.model = model.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoIndexModelListClild *model = self.dataArray[indexPath.section];
    
    TaoIndexModelClildStock *item = model.list[indexPath.row];
    
    if (self.pushBlcok) {
        self.pushBlcok(item);
    }

}

#pragma mark lazy loading

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = kUIColorFromRGB(0xffffff);
        
        UILabel *l = [UILabel new];
        l.backgroundColor = kButtonBGColor;
        [_topView addSubview:l];
        [l mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(15 * kScale));
            make.width.equalTo(@(3 * kScale));
            make.top.equalTo(_topView).offset(14 * kScale);
            make.left.equalTo(_topView).offset(15 * kScale);
        }];
    }
    return _topView;
}

- (UILabel *)topNameLb {
    if (_topNameLb == nil) {
        _topNameLb = [UILabel new];
        _topNameLb.textColor = kUIColorFromRGB(0x333333);
        _topNameLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _topNameLb;
}

- (UILabel *)topTimeLb {
    if (_topTimeLb == nil) {
        _topTimeLb = [UILabel new];
        _topTimeLb.textColor = kUIColorFromRGB(0x808080);
        _topTimeLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _topTimeLb;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[IdleFundStockCellTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}


@end
