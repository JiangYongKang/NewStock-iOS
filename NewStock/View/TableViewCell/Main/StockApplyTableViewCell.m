//
//  StockApplyTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockApplyTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface StockApplyTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_code;
@property (nonatomic, strong) UILabel *lb_pr;
@property (nonatomic, strong) UILabel *lb_pe;
@property (nonatomic, strong) UILabel *lb_mx;

@end

@implementation StockApplyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.lb_name];
    [self.contentView addSubview:self.lb_code];
    [self.contentView addSubview:self.lb_pr];
    [self.contentView addSubview:self.lb_pe];
    [self.contentView addSubview:self.lb_mx];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(2);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.contentView.mas_centerY).offset(5);
    }];
    
    [self.lb_pr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lb_name);
        make.right.equalTo(self.contentView.mas_centerX).offset(10);
    }];
    
    [self.lb_pe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_code);
        make.right.equalTo(self.lb_pr);
    }];
    
    [self.lb_mx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
}

- (void)setModel:(StockApplyModelList *)model {
    _model = model;
    
    self.lb_name.text = model.n;
    self.lb_code.text = model.s;
    self.lb_pr.text = [NSString stringWithFormat:@"%.2lf",model.pr.floatValue];
    self.lb_pe.text = [NSString stringWithFormat:@"%.2lf倍",model.pe.floatValue];
    self.lb_mx.text = model.mx;
    
}

#pragma mark lazy loading

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.textColor = kUIColorFromRGB(0x333333);
        _lb_name.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_name;
}

- (UILabel *)lb_code {
    if (_lb_code == nil) {
        _lb_code = [UILabel new];
        _lb_code.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_code.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _lb_code;
}

- (UILabel *)lb_pr {
    if (_lb_pr == nil) {
        _lb_pr = [UILabel new];
        _lb_pr.textColor = kUIColorFromRGB(0x333333);
        _lb_pr.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_pr;
}

- (UILabel *)lb_pe {
    if (_lb_pe == nil) {
        _lb_pe = [UILabel new];
        _lb_pe.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_pe.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _lb_pe;
}

- (UILabel *)lb_mx {
    if (_lb_mx == nil) {
        _lb_mx = [UILabel new];
        _lb_mx.textColor = kUIColorFromRGB(0x333333);
        _lb_mx.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_mx;
}

@end
