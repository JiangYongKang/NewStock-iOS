//
//  StockInfoView.m
//  NewStock
//
//  Created by Willey on 16/7/29.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockInfoView.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "Masonry.h"

@implementation StockInfoView
@synthesize delegate;

- (id)initWithDelegate:(id)theDelegate :(STOCKINFOVIEWTYPE)type {
    if (self = [super init]) {
        self.delegate = theDelegate;

        self.backgroundColor = [UIColor whiteColor];
        
        //
        _lbValue = [[UILabel alloc] init];
        _lbValue.text = @"--";
        _lbValue.backgroundColor = [UIColor clearColor];
        //_lbValue.textAlignment = NSTextAlignmentCenter;
        _lbValue.textColor = PLAN_COLOR;
        _lbValue.font = [UIFont boldSystemFontOfSize:26 * kScale];
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13 * kScale);
            make.left.equalTo(self).offset(12 * kScale);
            make.height.equalTo(@(30 * kScale));
        }];
        
        _lbChange = [[UILabel alloc] init];
        _lbChange.text = @"--";
        _lbChange.textColor = PLAN_COLOR;
        _lbChange.font = [UIFont systemFontOfSize:13 * kScale];
        [self addSubview:_lbChange];
        [_lbChange mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-13 * kScale);
            make.left.equalTo(_lbValue);
        }];
        
        _lbChangeRate = [[UILabel alloc] init];
        _lbChangeRate.text = @"--";
        _lbChangeRate.textColor = PLAN_COLOR;
        _lbChangeRate.font = [UIFont systemFontOfSize:13 * kScale];
        [self addSubview:_lbChangeRate];
        [_lbChangeRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_lbChange);
            make.left.equalTo(_lbChange.mas_right).offset(12 * kScale);
        }];
        
        
        //
        UIFont *valueFont = [UIFont systemFontOfSize:12];
        UIFont *leftFont = [UIFont systemFontOfSize:11 * kScale];
        UIColor *leftColor = kUIColorFromRGB(0xb2b2b2);
        
        //今开 label
        
        UILabel *lbTitle6 = [UILabel new];
        lbTitle6.text = @"今  开";
        lbTitle6.backgroundColor = [UIColor clearColor];
        lbTitle6.textColor = leftColor;
        lbTitle6.font = leftFont;
        [self addSubview:lbTitle6];
        [lbTitle6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(9 * kScale);
            make.leading.equalTo(self).offset(143 * kScale);
        }];
        
        _lbOpen = [UILabel new];
        _lbOpen.text = @"--";
        _lbOpen.backgroundColor = [UIColor clearColor];
        _lbOpen.textColor = kUIColorFromRGB(0x333333);
        _lbOpen.font = valueFont;
        [self addSubview:_lbOpen];
        [_lbOpen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle6.mas_bottom).offset(1 * kScale);
            make.left.equalTo(lbTitle6);
        }];
        
        //
        UILabel *lbTitle1 = [[UILabel alloc] init];
        lbTitle1.text = @"最 高";
        lbTitle1.textColor = leftColor;
        lbTitle1.font = leftFont;
        [self addSubview:lbTitle1];
        [lbTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle6);
            make.left.equalTo(lbTitle6.mas_right).offset(50 * kScale);
        }];
        
        _lbHeighest = [[UILabel alloc] init];
        _lbHeighest.text = @"--";
        _lbHeighest.textColor = kUIColorFromRGB(0x333333);
        _lbHeighest.font = valueFont;
        [self addSubview:_lbHeighest];
        [_lbHeighest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbOpen);
            make.left.equalTo(lbTitle1);
        }];
        
        //

        UILabel *lbTitle3 = [[UILabel alloc] init];
        lbTitle3.text = @"最 低";
        lbTitle3.textColor = leftColor;
        lbTitle3.font = leftFont;
        [self addSubview:lbTitle3];
        [lbTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle6);
            make.left.equalTo(lbTitle1.mas_right).offset(50 * kScale);
        }];
        
        _lbLowest = [[UILabel alloc] init];
        _lbLowest.text = @"--";
        _lbLowest.textColor = kUIColorFromRGB(0x333333);
        _lbLowest.font = valueFont;
        [self addSubview:_lbLowest];
        [_lbLowest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbOpen);
            make.left.equalTo(lbTitle3);
        }];
        
        // 成交额 label
        
        UILabel *lbTitle2 = [[UILabel alloc] init];
        lbTitle2.text = @"成交额";
        lbTitle2.textColor = leftColor;
        lbTitle2.font = leftFont;
        [self addSubview:lbTitle2];
        [lbTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-22 * kScale);
            make.left.equalTo(lbTitle6);
        }];
        
        _lbAmount = [[UILabel alloc] init];
        _lbAmount.text = @"--";
        _lbAmount.textColor = kUIColorFromRGB(0x333333);
        _lbAmount.font = valueFont;
        [self addSubview:_lbAmount];
        [_lbAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle2.mas_bottom).offset(1 * kScale);
            make.left.equalTo(lbTitle2);
        }];
        
        //换手率 label
        
        UILabel *lbTitle5 = [UILabel new];
        lbTitle5.text = @"换手率";
        lbTitle5.textColor = leftColor;
        lbTitle5.font = leftFont;
        [self addSubview:lbTitle5];
        [lbTitle5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle2);
            make.left.equalTo(lbTitle1);
        }];
        
        _lbTurnoverRate = [UILabel new];
        _lbTurnoverRate.text = @"--";
        _lbTurnoverRate.textColor = kUIColorFromRGB(0x333333);
        _lbTurnoverRate.font = valueFont;
        [self addSubview:_lbTurnoverRate];
        [_lbTurnoverRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbAmount);
            make.left.equalTo(lbTitle5);
        }];
        
        //振幅 label
        
        UILabel *lbTitle4 = [[UILabel alloc] init];
        lbTitle4.text = @"振幅";
        lbTitle4.textColor = leftColor;
        lbTitle4.font = leftFont;
        [self addSubview:lbTitle4];
        [lbTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle2);
            make.left.equalTo(lbTitle3);
        }];
        
        _lbSwing = [[UILabel alloc] init];
        _lbSwing.text = @"--";
        _lbSwing.textColor = kUIColorFromRGB(0x333333);
        _lbSwing.font = valueFont;
        [self addSubview:_lbSwing];
        [_lbSwing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle4.mas_bottom).offset(1 * kScale);
            make.left.equalTo(lbTitle4);
        }];
        
        //成交量 label
        
        UILabel *lbTitle7 = [[UILabel alloc] init];
        lbTitle7.text = @"成交量(手)";
        lbTitle7.textColor = leftColor;
        lbTitle7.font = leftFont;
        [self addSubview:lbTitle7];
        [lbTitle7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle2);
            make.left.equalTo(lbTitle3);
        }];
        
        _lbVolume = [[UILabel alloc] init];
        _lbVolume.text = @"--";
        _lbVolume.textColor = kUIColorFromRGB(0x333333);
        _lbVolume.font = valueFont;
        [self addSubview:_lbVolume];
        [_lbVolume mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle4.mas_bottom).offset(1 * kScale);
            make.left.equalTo(lbTitle4);
        }];
        
        
        if (type == STOCKINFOVIEWTYPE_INDEX) {
            _lbVolume.hidden = YES;
            lbTitle7.hidden = YES;
        } else if (type == STOCKINFOVIEWTYPE_STOCK) {
            _lbSwing.hidden = YES;
            lbTitle4.hidden = YES;
        }
        
        
        // arrwor
        UIImage *img = [UIImage imageNamed:@"theme_arror_ico"];
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:img];
        arrowImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        [self addSubview:arrowImageView];
        
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-12 * kScale);
        }];
        
        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        gensture.delegate = self;
        [self addGestureRecognizer:gensture];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
}

- (void)setCode:(NSString *)code
          value:(NSString *)value
         change:(NSString *)change
     changeRate:(NSString *)changeRate
        highest:(NSString *)highest
         amount:(NSString *)amount
         lowest:(NSString *)lowest
         volume:(NSString *)volume
   turnoverRate:(NSString *)turnoverRate
           open:(NSString *)open
           swing:(NSString *)swing
      prevClose:(NSString *)prevClose {
    UIColor *textColor;
    
    if ((change == nil)|| [change isEqualToString:@""]||[change isEqualToString:@"--"])
    {
        _lbChange.text = @"--";
        _lbChangeRate.text = @"--";
    }
    else
    {
        if ([change floatValue] > 0.000001)
        {
            textColor = RISE_COLOR;
            
            _lbChange.text = [NSString stringWithFormat:@"+%@",change];
            _lbChangeRate.text = [NSString stringWithFormat:@"+%@",changeRate];
        }
        else if ([change floatValue] < -0.000001)
        {
            textColor = FALL_COLOR;
            
            _lbChange.text = change;
            _lbChangeRate.text = changeRate;
        }
        else
        {
            textColor = PLAN_COLOR;
            
            _lbChange.text = change;
            _lbChangeRate.text = changeRate;
        }
        [_lbValue setTextColor:textColor];
        [_lbChange setTextColor:textColor];
        [_lbChangeRate setTextColor:textColor];
    }
    
    _lbValue.text = value;
    _lbHeighest.text = highest;
    _lbLowest.text = lowest;
    _lbAmount.text = amount;
    _lbVolume.text = volume;
    _lbOpen.text = open;
    
    //新增 换手率 今开
    
    if ((swing == nil) || [swing isEqualToString:@""] || [swing isEqualToString:@"--"] ) {
        _lbSwing.text = @"--";
    } else {
        _lbSwing.text = [NSString stringWithFormat:@"%@%%",swing];
    }
    
    if ((turnoverRate == nil) || [turnoverRate isEqualToString:@""] || [turnoverRate isEqualToString:@"--"]) {
        _lbTurnoverRate.text = @"--";
    } else {
        _lbTurnoverRate.text = [NSString stringWithFormat:@"%.2lf%@",turnoverRate.floatValue,@"%"];
    }
    
    if (highest.floatValue > prevClose.floatValue) {
        _lbHeighest.textColor = RISE_COLOR;
    } else if (highest.floatValue < prevClose.floatValue) {
        _lbHeighest.textColor = FALL_COLOR;
    } else {
        _lbHeighest.textColor = PLAN_COLOR;
    }
    
    if (lowest.floatValue > prevClose.floatValue) {
        _lbLowest.textColor = RISE_COLOR;
    } else if (lowest.floatValue < prevClose.floatValue) {
        _lbLowest.textColor = FALL_COLOR;
    } else {
        _lbLowest.textColor = PLAN_COLOR;
    }
    
    if (open.floatValue > prevClose.floatValue) {
        _lbOpen.textColor = RISE_COLOR;
    } else if (open.floatValue < prevClose.floatValue) {
        _lbOpen.textColor = FALL_COLOR;
    } else {
        _lbOpen.textColor = PLAN_COLOR;
    }
    
    
//    _lbHeighest.textColor = (highest > prevClose) ? RISE_COLOR : FALL_COLOR;
//    _lbLowest.textColor = (lowest > prevClose) ? RISE_COLOR : FALL_COLOR;
}

#pragma mark - IndexBlockDelegate
- (void)tapAction {
    if([delegate respondsToSelector:@selector(stockInfoView:)]) {
        [delegate stockInfoView:self];
    }
}

@end
