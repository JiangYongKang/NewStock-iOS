//
//  MyStockHeaderView.m
//  NewStock
//
//  Created by 王迪 on 2017/1/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyStockHeaderView.h"
#import <Masonry.h>
#import "Defination.h"
#import "UIView+Masonry_Arrange.h"

@interface MyStockHeaderView ()

@property (nonatomic, strong) UILabel *lb_total_text;
@property (nonatomic, strong) UILabel *lb_total_num;

@property (nonatomic, strong) UILabel *lb_totalBuy_text;
@property (nonatomic, strong) UILabel *lb_totalBuy_num;

@property (nonatomic, strong) UILabel *lb_today_text;
@property (nonatomic, strong) UILabel *lb_today_num;

@property (nonatomic, strong) UILabel *lb_earn_text;
@property (nonatomic, strong) UILabel *lb_earn_num;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;

@end

@implementation MyStockHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.lb_total_text];
    [self addSubview:self.lb_total_num];
    [self addSubview:self.lb_totalBuy_text];
    [self addSubview:self.lb_totalBuy_num];
    [self addSubview:self.lb_today_text];
    [self addSubview:self.lb_today_num];
    [self addSubview:self.lb_earn_text];
    [self addSubview:self.lb_earn_num];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    [self addSubview:self.line3];
    
    [self.lb_total_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15 * kScale);
        make.top.equalTo(self).offset(30 * kScale);
    }];
    
    [self.lb_total_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lb_total_text).offset(-3 * kScale);
    }];
    
    [self.lb_totalBuy_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1).offset(15 * kScale);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(self).multipliedBy(1.0/3);
    }];
    
    [self.lb_totalBuy_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_top).offset(-15 * kScale);
        make.width.equalTo(self.lb_totalBuy_text);
    }];
    
    [self.lb_today_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_totalBuy_text);
        make.left.equalTo(self).offset(1.0/3 * MAIN_SCREEN_WIDTH);
        make.width.equalTo(self.lb_totalBuy_text);
    }];
    
    [self.lb_today_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_totalBuy_num);
        make.width.equalTo(self.lb_totalBuy_text);
        make.left.equalTo(self.lb_today_text);
    }];
    
    [self.lb_earn_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_totalBuy_text);
        make.width.equalTo(self.lb_totalBuy_text);
        make.left.equalTo(self).offset(2.0/3 * MAIN_SCREEN_WIDTH);
    }];
    
    [self.lb_earn_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_totalBuy_num);
        make.width.equalTo(self.lb_totalBuy_text);
        make.left.equalTo(self.lb_earn_text);
    }];
    
}

- (void)setInitValue {
    self.lb_total_num.text = @"-";
    self.lb_totalBuy_num.text = @"-";
    self.lb_today_num.text = @"-";
    self.lb_earn_num.text = @"-";
    
    self.lb_total_num.textColor = kUIColorFromRGB(0x333333);
    self.lb_earn_num.textColor = kUIColorFromRGB(0x333333);
    self.lb_today_num.textColor = kUIColorFromRGB(0x333333);
}

- (void)setTotalMarketValue:(NSString *)marketValue buy:(NSString *)buy today:(NSString *)today totalEarn:(NSString *)totalEarn {
    
    NSString *marStr = [NSString stringWithFormat:@"%.2lf",marketValue.floatValue];
    NSString *buyStr = [NSString stringWithFormat:@"%.2lf",buy.floatValue];
    NSString *todStr = [NSString stringWithFormat:@"%.2lf",today.floatValue];
    NSString *earStr = [NSString stringWithFormat:@"%.2lf",totalEarn.floatValue];
    
    self.lb_total_num.text = marStr;
    self.lb_totalBuy_num.text = buyStr;
    self.lb_today_num.text = todStr;
    if (earStr.floatValue >= 100000) {
        self.lb_earn_num.text = [NSString stringWithFormat:@"%.2lf万",earStr.floatValue / 10000];
    }else {
        self.lb_earn_num.text = earStr;
    }
    
    if (todStr.floatValue >= 0) {
        self.lb_today_num.textColor = kUIColorFromRGB(0xff1919);
    }else {
        self.lb_today_num.textColor = kUIColorFromRGB(0x009b00);
    }
    
    if (earStr.floatValue >= 0) {
        self.lb_earn_num.textColor = kUIColorFromRGB(0xff1919);
    }else {
        self.lb_earn_num.textColor = kUIColorFromRGB(0x009b00);
    }
    
    self.lb_total_num.textColor = kUIColorFromRGB(0xff1919);
}

- (UILabel *)lb_total_text {
    if (_lb_total_text == nil) {
        _lb_total_text = [UILabel new];
        _lb_total_text.textColor = kUIColorFromRGB(0x808080);
        _lb_total_text.font = [UIFont systemFontOfSize:14 * kScale];
        _lb_total_text.text = @"当前股票总市值";
    }
    return _lb_total_text;
}

- (UILabel *)lb_total_num {
    if (_lb_total_num == nil) {
        _lb_total_num = [UILabel new];
        _lb_total_num.textColor = kUIColorFromRGB(0x333333);
        _lb_total_num.font = [UIFont systemFontOfSize:19 * kScale];
        _lb_total_num.text = @"-";
    }
    return _lb_total_num;
}

- (UILabel *)lb_totalBuy_text {
    if (_lb_totalBuy_text == nil) {
        _lb_totalBuy_text = [UILabel new];
        _lb_totalBuy_text.textAlignment = NSTextAlignmentCenter;
        _lb_totalBuy_text.textColor = kUIColorFromRGB(0x808080);
        _lb_totalBuy_text.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_totalBuy_text.text = @"买入总成本";
    }
    return _lb_totalBuy_text;
}

- (UILabel *)lb_totalBuy_num {
    if (_lb_totalBuy_num == nil) {
        _lb_totalBuy_num = [UILabel new];
        _lb_totalBuy_num.textAlignment = NSTextAlignmentCenter;
        _lb_totalBuy_num.textColor = kUIColorFromRGB(0x333333);
        _lb_totalBuy_num.font = [UIFont systemFontOfSize:18 * kScale];
        _lb_totalBuy_num.text = @"-";
    }
    return _lb_totalBuy_num;
}

- (UILabel *)lb_today_text {
    if (_lb_today_text == nil) {
        _lb_today_text = [UILabel new];
        _lb_today_text.textAlignment = NSTextAlignmentCenter;
        _lb_today_text.textColor = kUIColorFromRGB(0x808080);
        _lb_today_text.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_today_text.text = @"当日盈亏";
    }
    return _lb_today_text;
}

- (UILabel *)lb_today_num {
    if (_lb_today_num == nil) {
        _lb_today_num = [UILabel new];
        _lb_today_num.textAlignment = NSTextAlignmentCenter;
        _lb_today_num.textColor = kUIColorFromRGB(0x333333);
        _lb_today_num.font = [UIFont systemFontOfSize:18 * kScale];
        _lb_today_num.text = @"-";
    }
    return _lb_today_num;
}

- (UILabel *)lb_earn_text {
    if (_lb_earn_text == nil) {
        _lb_earn_text = [UILabel new];
        _lb_earn_text.textAlignment = NSTextAlignmentCenter;
        _lb_earn_text.textColor = kUIColorFromRGB(0x808080);
        _lb_earn_text.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_earn_text.text = @"总浮动盈亏";
    }
    return _lb_earn_text;
}

- (UILabel *)lb_earn_num {
    if (_lb_earn_num == nil) {
        _lb_earn_num = [UILabel new];
        _lb_earn_num.textAlignment = NSTextAlignmentCenter;
        _lb_earn_num.textColor = kUIColorFromRGB(0x333333);
        _lb_earn_num.font = [UIFont systemFontOfSize:18 * kScale];
        _lb_earn_num.text = @"-";
    }
    return _lb_earn_num;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 10 * kScale)];
        _topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _topView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 140 * kScale, MAIN_SCREEN_WIDTH, 24 * kScale)];
        _bottomView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        
        UILabel *lb_sz = [UILabel new];
        UILabel *lb_yk = [UILabel new];
        UILabel *lb_cc = [UILabel new];
        UILabel *lb_cb = [UILabel new];
        
        lb_sz.textColor = kUIColorFromRGB(0x666666);
        lb_yk.textColor = kUIColorFromRGB(0x666666);
        lb_cc.textColor = kUIColorFromRGB(0x666666);
        lb_cb.textColor = kUIColorFromRGB(0x666666);
        
        lb_sz.textAlignment = NSTextAlignmentCenter;
        lb_yk.textAlignment = NSTextAlignmentCenter;
        lb_cc.textAlignment = NSTextAlignmentCenter;
        lb_cb.textAlignment = NSTextAlignmentCenter;
        
        lb_sz.font = [UIFont systemFontOfSize:12];
        lb_yk.font = [UIFont systemFontOfSize:12];
        lb_cc.font = [UIFont systemFontOfSize:12];
        lb_cb.font = [UIFont systemFontOfSize:12];
        
        [_bottomView addSubview:lb_sz];
        [_bottomView addSubview:lb_yk];
        [_bottomView addSubview:lb_cc];
        [_bottomView addSubview:lb_cb];
        
        [lb_sz mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_bottomView);
            make.width.equalTo(_bottomView).multipliedBy(0.25);
        }];
        [lb_yk mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_bottomView);
            make.width.equalTo(_bottomView).multipliedBy(0.25);
        }];
        [lb_cc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_bottomView);
            make.width.equalTo(_bottomView).multipliedBy(0.25);
        }];
        [lb_cb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_bottomView);
            make.width.equalTo(_bottomView).multipliedBy(0.25);
        }];
    
        lb_sz.text = @"市值";
        lb_yk.text = @"盈亏";
        lb_cc.text = @"持仓(股)";
        lb_cb.text = @"成本/现价";
        [_bottomView distributeSpacingHorizontallyWith:@[lb_sz,lb_yk,lb_cc,lb_cb]];
    }
    return _bottomView;
}

- (UIView *)line1 {
    if (_line1 == nil) {
        _line1 = [[UIView alloc] initWithFrame:CGRectMake(15 * kScale, 65 * kScale, MAIN_SCREEN_WIDTH - 30 * kScale, 0.5)];
        _line1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line1;
}

- (UIView *)line2 {
    if (_line2 == nil) {
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH / 3, 85 * kScale, 0.5, 35 * kScale)];
        _line2.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line2;
}

- (UIView *)line3 {
    if (_line3 == nil) {
        _line3 = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH / 3 * 2, 85 * kScale, 0.5, 35 * kScale)];
        _line3.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line3;
}



@end
