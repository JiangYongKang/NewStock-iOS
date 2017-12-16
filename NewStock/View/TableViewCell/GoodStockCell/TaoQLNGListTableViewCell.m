//
//  TaoQLNGListTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGListTableViewCell.h"

#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"

@interface TaoQLNGListTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;

@property (nonatomic, strong) UILabel *lb_code;

@property (nonatomic, strong) UILabel *lb_new;

@property (nonatomic, strong) UILabel *lb_rate;

@property (nonatomic, strong) UILabel *lb_enterPrice;

@property (nonatomic, strong) UILabel *lb_maxZdf;

@end

@implementation TaoQLNGListTableViewCell

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
    [self.contentView addSubview:self.lb_new];
    [self.contentView addSubview:self.lb_code];
    [self.contentView addSubview:self.lb_name];
    [self.contentView addSubview:self.lb_enterPrice];
    [self.contentView addSubview:self.lb_maxZdf];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.contentView).offset(10 * kScale);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.lb_name.mas_bottom).offset(3 * kScale);
    }];
    
    [self.lb_enterPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(130 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lb_new mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-110 * kScale);
        make.top.equalTo(self.lb_name);
    }];
    
    [self.lb_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lb_new);
        make.top.equalTo(self.lb_code);
    }];
    
    [self.lb_maxZdf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
}

- (void)setN:(NSString *)n s:(NSString *)s zx:(NSString *)zx zdf:(NSString *)zdf enterPrice:(NSString *)enterPrice maxZdf:(NSString *)maxZdf {
    self.lb_name.text = n;
    
    self.lb_code.text = s;
    
    if (zx == nil) {
        self.lb_new.text = @"--";
        self.lb_new.textColor = PLAN_COLOR;
    }else {
        self.lb_new.text = [NSString stringWithFormat:@"%.2lf",zx.floatValue];
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
        self.lb_new.textColor = RISE_COLOR;
    } else if (zdf.floatValue < 0) {
        self.lb_rate.textColor = FALL_COLOR;
        self.lb_new.textColor = FALL_COLOR;
    } else {
        self.lb_rate.textColor = PLAN_COLOR;
        self.lb_new.textColor = PLAN_COLOR;
    }
    
    self.lb_enterPrice.text = [NSString stringWithFormat:@"%.2lf",enterPrice.floatValue];
    self.lb_maxZdf.text = [NSString stringWithFormat:@"%.2lf%%",maxZdf.floatValue];
    if (maxZdf.floatValue > 0) {
        self.lb_maxZdf.textColor = RISE_COLOR;
    } else if (maxZdf.floatValue < 0) {
        self.lb_maxZdf.textColor = FALL_COLOR;
    } else {
        self.lb_maxZdf.textColor = PLAN_COLOR;
    }
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
        _lb_code.textColor = kUIColorFromRGB(0x808080);
        _lb_code.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _lb_code;
}

- (UILabel *)lb_new {
    if (_lb_new == nil) {
        _lb_new = [UILabel new];
        _lb_new.font = [UIFont boldSystemFontOfSize:15 * kScale];
        _lb_new.textColor = kUIColorFromRGB(0x333333);
    }
    return _lb_new;
}

- (UILabel *)lb_rate {
    if (_lb_rate == nil) {
        _lb_rate = [UILabel new];
        _lb_rate.textAlignment = NSTextAlignmentCenter;
        _lb_rate.font = [UIFont boldSystemFontOfSize:12 * kScale];
    }
    return _lb_rate;
}

- (UILabel *)lb_enterPrice {
    if (_lb_enterPrice == nil) {
        _lb_enterPrice = [UILabel new];
        _lb_enterPrice.textColor = kUIColorFromRGB(0x333333);
        _lb_enterPrice.font = [UIFont systemFontOfSize:15 * kScale];
    }
    return _lb_enterPrice;
}

- (UILabel *)lb_maxZdf {
    if (_lb_maxZdf == nil) {
        _lb_maxZdf = [UILabel new];
        _lb_maxZdf.textColor = kUIColorFromRGB(0x333333);
        _lb_maxZdf.font = [UIFont systemFontOfSize:15 * kScale];
    }
    return _lb_maxZdf;
}

@end
