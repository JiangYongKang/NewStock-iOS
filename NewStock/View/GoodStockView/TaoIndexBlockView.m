//
//  TaoIndexBlockView.m
//  NewStock
//
//  Created by 王迪 on 2017/3/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Masonry.h>
#import "TaoIndexBlockView.h"
#import "TaoIndexBlockTableViewCell.h"
#import "Defination.h"
#import "TaoIndexLeftBtn.h"

static NSString *cellID = @"TaoIndexBlockTableViewCell";

@interface TaoIndexBlockView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TaoIndexLeftBtn *leftBtn;

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) UILabel *tempLb;

@end

@implementation TaoIndexBlockView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = kUIColorFromRGB(0xffffff);
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.line];
    [self addSubview:self.tableView];
    [self addSubview:self.leftView];
    [self addSubview:self.tempLb];
    
    [self.leftView addSubview:self.leftBtn];
    [self.leftView addSubview:self.moreBtn];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo(@(86 * kScale));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.5 * kScale));
        make.left.equalTo(self).offset(86 * kScale);
        make.centerY.equalTo(self);
        make.height.equalTo(@(66 * kScale));
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(0 * kScale);
        make.centerX.equalTo(self.line).offset(-43 * kScale);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftBtn);
        make.top.equalTo(self.leftBtn.mas_bottom).offset(5 * kScale);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.line.mas_right).offset(0 * kScale);
        make.right.equalTo(self);
        make.height.equalTo(@(49 * 3 * kScale));
    }];
    
    [self.tempLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.line.mas_right).offset(10 * kScale);
        make.right.equalTo(self).offset(-10 * kScale);
        make.height.equalTo(@(98 * kScale));
    }];
    
}

#pragma mark actiton

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.moreBlock) {
        self.moreBlock();
    }
}

- (void)setBtnImg:(NSString *)btnImg {
    _btnImg = btnImg;
    _leftBtn.imgStr = self.btnImg;
}

- (void)setBtnTitle:(NSString *)btnTitle {
    _btnTitle = btnTitle;
    _leftBtn.title = self.btnTitle;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    NSInteger count = dataArray.count;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(49 * kScale * count));
    }];
    [self.tableView reloadData];
    
    self.tempLb.hidden = count == 0 ? NO : YES;
    self.tableView.hidden = count == 0 ? YES : NO;
}

- (void)setDsc:(NSString *)dsc {
    _dsc = dsc;
    if (dsc.length == 0) {
        return;
    }
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 4;
    NSAttributedString *nsAttrStr = [[NSAttributedString alloc] initWithString:dsc attributes:@{
                            NSParagraphStyleAttributeName : para,
                            NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],
                                                                                                }];
    
    self.tempLb.attributedText = nsAttrStr;
}

#pragma mark tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoIndexBlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TaoIndexModelClildStock *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoIndexModelClildStock *model = self.dataArray[indexPath.row];
    if (self.pushBlock) {
        self.pushBlock(model);
    }
}

#pragma mark --------

- (UILabel *)line {
    if (_line == nil) {
        _line = [UILabel new];
        _line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line;
}

- (TaoIndexLeftBtn *)leftBtn {
    if (_leftBtn == nil) {
        _leftBtn = [TaoIndexLeftBtn new];
        _leftBtn.userInteractionEnabled = NO;
    }
    return _leftBtn;
}

- (UIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [UIButton new];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        _moreBtn.userInteractionEnabled = NO;
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_moreBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    }
    return _moreBtn;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TaoIndexBlockTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [UIView new];
        _leftView.backgroundColor = kUIColorFromRGB(0xffffff);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_leftView addGestureRecognizer:tap];
    }
    return _leftView;
}

- (UILabel *)tempLb {
    if (_tempLb == nil) {
        _tempLb = [UILabel new];
        _tempLb.textColor = kUIColorFromRGB(0x333333);
        _tempLb.font = [UIFont systemFontOfSize:14 * kScale];
        _tempLb.numberOfLines = 3;
        _tempLb.hidden = YES;
    }
    return _tempLb;
}

@end
