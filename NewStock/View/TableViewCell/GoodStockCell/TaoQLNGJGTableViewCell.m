//
//  TaoQLNGJGTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGJGTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"

@interface TaoQLNGJGTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;

@property (nonatomic, strong) UILabel *lb_code;

@property (nonatomic, strong) UILabel *lb_buy;

@property (nonatomic, strong) UILabel *lb_rate;

@property (nonatomic, strong) UILabel *lb_cys;

@end

@implementation TaoQLNGJGTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.clipsToBounds = YES;
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.lb_rate];
    [self.contentView addSubview:self.lb_buy];
    [self.contentView addSubview:self.lb_code];
    [self.contentView addSubview:self.lb_name];
    [self.contentView addSubview:self.lb_cys];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.contentView).offset(10 * kScale);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.lb_name.mas_bottom).offset(3 * kScale);
    }];
    
    [self.lb_cys mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(135 * kScale);
        make.centerY.equalTo(self.contentView);
    }];

    [self.lb_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-125 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lb_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    
}

- (void)setN:(NSString *)n s:(NSString *)s cys:(NSString *)cys zdf:(NSString *)zdf buy:(NSString *)buy {
    self.lb_name.text = n;
    
    self.lb_code.text = s;
    
    if (buy == nil) {
        self.lb_buy.text = @"--";
        self.lb_buy.textColor = PLAN_COLOR;
    }else {
        self.lb_buy.text = [NSString stringWithFormat:@"%.2lf",buy.floatValue];
    }
    
    if (zdf == nil) {
        self.lb_rate.text = @"--";
        self.lb_rate.textColor = PLAN_COLOR;
        return;
    }else {
        self.lb_rate.text = [NSString stringWithFormat:@"%.2lf%%",zdf.floatValue];
    }
    
    if (zdf.floatValue > 0) {
        self.lb_rate.textColor = RISE_COLOR;
        self.lb_buy.textColor = RISE_COLOR;
    } else if (zdf.floatValue < 0) {
        self.lb_rate.textColor = FALL_COLOR;
        self.lb_buy.textColor = FALL_COLOR;
    } else {
        self.lb_rate.textColor = PLAN_COLOR;
        self.lb_buy.textColor = PLAN_COLOR;
    }
    
    self.lb_cys.text = [NSString stringWithFormat:@"%zd",cys.integerValue];
}

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.textColor = kUIColorFromRGB(0x333333);
        _lb_name.font = [UIFont boldSystemFontOfSize:16 * kScale];
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

- (UILabel *)lb_buy {
    if (_lb_buy == nil) {
        _lb_buy = [UILabel new];
        _lb_buy.font = [UIFont boldSystemFontOfSize:15 * kScale];
        _lb_buy.textColor = kUIColorFromRGB(0x333333);
    }
    return _lb_buy;
}

- (UILabel *)lb_rate {
    if (_lb_rate == nil) {
        _lb_rate = [UILabel new];
        _lb_rate.textAlignment = NSTextAlignmentCenter;
        _lb_rate.font = [UIFont boldSystemFontOfSize:15 * kScale];
    }
    return _lb_rate;
}

- (UILabel *)lb_cys {
    if (_lb_cys == nil) {
        _lb_cys = [UILabel new];
        _lb_cys.textColor = kUIColorFromRGB(0x333333);
        _lb_cys.font = [UIFont boldSystemFontOfSize:15 * kScale];
    }
    return _lb_cys;
}


@end
