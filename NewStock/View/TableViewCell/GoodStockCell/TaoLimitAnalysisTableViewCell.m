//
//  TaoLimitAnalysisTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/21.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoLimitAnalysisTableViewCell.h"

#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"

@interface TaoLimitAnalysisTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;

@property (nonatomic, strong) UILabel *lb_code;

@property (nonatomic, strong) UILabel *lb_new;

@property (nonatomic, strong) UILabel *lb_rate;

@property (nonatomic, strong) UILabel *lb_reason;

@property (nonatomic, strong) UILabel *lb_openConut;

@property (nonatomic, strong) UILabel *lb_lastTime;


@end

@implementation TaoLimitAnalysisTableViewCell

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
    [self.contentView addSubview:self.lb_reason];
    [self.contentView addSubview:self.lb_lastTime];
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
    
    [self.lb_lastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(25 * kScale);
        make.centerY.equalTo(self.lb_name);
    }];
    
    [self.lb_openConut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lb_name);
        make.right.equalTo(self.contentView).offset(-30 * kScale);
    }];
    
    [self.lb_reason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lb_code.mas_bottom).offset(8 * kScale);
        make.left.equalTo(_lb_code);
    }];
    
}

- (void)setN:(NSString *)n s:(NSString *)s t:(NSString *)t zx:(NSString *)zx zdf:(NSString *)zdf r:(NSString *)r tm:(NSString *)tm openCount:(NSString *)openCount {
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
    self.lb_lastTime.text = tm;
    
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 4;
    
    self.lb_reason.attributedText = [[NSAttributedString alloc] initWithString:r attributes:@{NSParagraphStyleAttributeName : para}];;
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

- (UILabel *)lb_lastTime {
    if (_lb_lastTime == nil) {
        _lb_lastTime = [UILabel new];
        _lb_lastTime.textColor = kUIColorFromRGB(0x333333);
        _lb_lastTime.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_lastTime;
}

- (UILabel *)lb_reason {
    if (_lb_reason == nil) {
        _lb_reason = [UILabel new];
        _lb_reason.textColor = kUIColorFromRGB(0x666666);
        _lb_reason.numberOfLines = 2;
        _lb_reason.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
        _lb_reason.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _lb_reason;
}



@end
