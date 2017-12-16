//
//  TaoCXZYTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/21.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoCXZYTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"

@interface TaoCXZYTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;

@property (nonatomic, strong) UILabel *lb_code;

@property (nonatomic, strong) UILabel *lb_new;

@property (nonatomic, strong) UILabel *lb_rate;

@property (nonatomic, strong) UILabel *lb_continueCount;

@property (nonatomic, strong) UILabel *lb_openConut;

@end

@implementation TaoCXZYTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.lb_rate];
    [self.contentView addSubview:self.lb_new];
    [self.contentView addSubview:self.lb_code];
    [self.contentView addSubview:self.lb_name];
    [self.contentView addSubview:self.lb_continueCount];
    [self.contentView addSubview:self.lb_openConut];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.contentView).offset(10 * kScale);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.lb_name.mas_bottom).offset(3 * kScale);
    }];
    
    [self.lb_new mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(-22 * kScale);
        make.top.equalTo(self.lb_name);
    }];
    
    [self.lb_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lb_new);
        make.top.equalTo(self.lb_code);
    }];
    
    [self.lb_continueCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(35 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lb_openConut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-40 * kScale);
    }];
    
}

- (void)setN:(NSString *)n s:(NSString *)s t:(NSString *)t zx:(NSString *)zx zdf:(NSString *)zdf continueCount:(NSString *)continueCount openCount:(NSString *)openCount {
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
    
    self.lb_openConut.text = [NSString stringWithFormat:@"%zd",openCount.integerValue];
    self.lb_continueCount.text = [NSString stringWithFormat:@"%zd天",continueCount.integerValue];
}

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

- (UILabel *)lb_new {
    if (_lb_new == nil) {
        _lb_new = [UILabel new];
        _lb_new.font = [UIFont systemFontOfSize:16 * kScale];
        _lb_new.textColor = kUIColorFromRGB(0x333333);
    }
    return _lb_new;
}

- (UILabel *)lb_rate {
    if (_lb_rate == nil) {
        _lb_rate = [UILabel new];
        _lb_rate.textAlignment = NSTextAlignmentCenter;
        _lb_rate.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _lb_rate;
}

- (UILabel *)lb_openConut {
    if (_lb_openConut == nil) {
        _lb_openConut = [UILabel new];
        _lb_openConut.textColor = kUIColorFromRGB(0x333333);
        _lb_openConut.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_openConut;
}

- (UILabel *)lb_continueCount {
    if (_lb_continueCount == nil) {
        _lb_continueCount = [UILabel new];
        _lb_continueCount.textColor = kUIColorFromRGB(0x333333);
        _lb_continueCount.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_continueCount;
}

@end
