//
//  StockPerformTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockPerformTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface StockPerformTableViewCell ()

@property (nonatomic) UILabel *lb_name;
@property (nonatomic) UILabel *lb_code;
@property (nonatomic) UILabel *lb_pr;
@property (nonatomic) UILabel *lb_tm;
@property (nonatomic) UILabel *lb_zx;
@property (nonatomic) UILabel *lb_zdf;
@property (nonatomic) UILabel *lb_pf;

@end

@implementation StockPerformTableViewCell

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
    [self.contentView addSubview:self.lb_tm];
    [self.contentView addSubview:self.lb_zx];
    [self.contentView addSubview:self.lb_zdf];
    [self.contentView addSubview:self.lb_pf];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(2);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.contentView.mas_centerY).offset(5);
    }];
    
    [self.lb_pr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(-25 * kScale);
        make.bottom.equalTo(self.lb_name);
    }];
    
    [self.lb_tm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_code);
        make.right.equalTo(self.lb_pr);
    }];
    
    [self.lb_zx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-120 * kScale);
        make.bottom.equalTo(self.lb_name);
    }];
    
    [self.lb_zdf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lb_zx);
        make.bottom.equalTo(self.lb_code);
    }];
    
    [self.lb_pf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
}

- (void)setModel:(StockPerformModel *)model {
    _model = model;
    
    self.lb_name.text = model.n;
    self.lb_code.text = model.s;
    self.lb_pr.text = [NSString stringWithFormat:@"%.2lf",model.pr.floatValue];
    self.lb_tm.text = model.tm;
    self.lb_zx.text = [NSString stringWithFormat:@"%.2lf",model.zx.floatValue];
    self.lb_zdf.text = [NSString stringWithFormat:@"%.2lf%%",model.tzf.floatValue];
    self.lb_pf.text = [NSString stringWithFormat:@"%.2lf元",model.pf.floatValue];
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

- (UILabel *)lb_tm {
    if (_lb_tm == nil) {
        _lb_tm = [UILabel new];
        _lb_tm.font = [UIFont systemFontOfSize:11 * kScale];
        _lb_tm.textColor = kUIColorFromRGB(0xb2b2b2);
    }
    return _lb_tm;
}

- (UILabel *)lb_zx {
    if (_lb_zx == nil) {
        _lb_zx = [UILabel new];
        _lb_zx.textColor = kUIColorFromRGB(0x333333);
        _lb_zx.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_zx;
}

- (UILabel *)lb_zdf {
    if (_lb_zdf == nil) {
        _lb_zdf = [UILabel new];
        _lb_zdf.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_zdf.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _lb_zdf;
}

- (UILabel *)lb_pf {
    if (_lb_pf == nil) {
        _lb_pf = [UILabel new];
        _lb_pf.textColor = kUIColorFromRGB(0xff1919);
        _lb_pf.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_pf;
}

@end
