//
//  HorStockInfoView.m
//  NewStock
//
//  Created by Willey on 16/11/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "HorStockInfoView.h"

#import "Defination.h"
#import "MarketConfig.h"
#import "Masonry.h"

@implementation HorStockInfoView
@synthesize delegate;

- (id)initWithDelegate:(id)theDelegate;
{
    self = [super init];
    if (self)
    {
        self.delegate = theDelegate;
        
        self.backgroundColor = [UIColor whiteColor];
        
        int nameWidth;
        if (MAIN_SCREEN_HEIGHT>480) {
            nameWidth = 150;
            _bShowCode = YES;
        }
        else{
            nameWidth = 85;
            _bShowCode = NO;
        }
        
        _lbName = [[UILabel alloc] init];
        _lbName.text = @"";
        _lbName.backgroundColor = [UIColor clearColor];
        //_lbValue.textAlignment = NSTextAlignmentCenter;
        _lbName.textColor = kUIColorFromRGB(0x333333);//[UIColor whiteColor];
        _lbName.font = [UIFont systemFontOfSize:18];
        [self addSubview:_lbName];
        [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.width.mas_equalTo(nameWidth);
            make.height.equalTo(self);
        }];
        
        //
        _lbValue = [[UILabel alloc] init];
        _lbValue.text = @"--";
        _lbValue.backgroundColor = [UIColor clearColor];
        //_lbValue.textAlignment = NSTextAlignmentCenter;
        _lbValue.textColor = kUIColorFromRGB(0xc3c3c3);// PLAN_COLOR;
        _lbValue.font = [UIFont systemFontOfSize:14];
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(_lbName.mas_right).offset(5);
            make.width.mas_equalTo(120);
            make.height.equalTo(self);
        }];
        
        /*
        _lbChange = [[UILabel alloc] init];
        _lbChange.text = @"--";
        _lbChange.backgroundColor = [UIColor clearColor];
        //_lbChange.textAlignment = NSTextAlignmentCenter;
        _lbChange.textColor = PLAN_COLOR;
        _lbChange.font = [UIFont systemFontOfSize:12];
        [self addSubview:_lbChange];
        [_lbChange mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(_lbValue.mas_right).offset(10);
            make.width.mas_equalTo(60);
            make.height.equalTo(self);
        }];
        
        _lbChangeRate = [[UILabel alloc] init];
        _lbChangeRate.text = @"--";
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        //_lbChangeRate.textAlignment = NSTextAlignmentCenter;
        _lbChangeRate.textColor = PLAN_COLOR;
        _lbChangeRate.font = [UIFont systemFontOfSize:12];
        [self addSubview:_lbChangeRate];
        [_lbChangeRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(_lbChange.mas_right).offset(10);
            make.width.mas_equalTo(60);
            make.height.equalTo(self);
        }];
        */
        
        
        //
        /*UIFont *valueFont = [UIFont systemFontOfSize:13];
        UILabel *lbTitle1 = [[UILabel alloc] init];
        lbTitle1.text = @"最高:";
        lbTitle1.backgroundColor = [UIColor clearColor];
        lbTitle1.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
        lbTitle1.font = [UIFont systemFontOfSize:12];
        [self addSubview:lbTitle1];
        [lbTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(7);
            make.left.equalTo(self).offset(Xcenter);
            make.width.mas_equalTo(Lcenter);
            make.height.equalTo(self).multipliedBy(0.25);
        }];
        
        _lbHeighest = [[UILabel alloc] init];
        _lbHeighest.text = @"--";
        _lbHeighest.backgroundColor = [UIColor clearColor];
        _lbHeighest.textColor = kUIColorFromRGB(0x333333);
        _lbHeighest.font = valueFont;
        [self addSubview:_lbHeighest];
        [_lbHeighest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle1.mas_bottom).offset(-5);
            make.left.equalTo(self).offset(Xcenter);
            make.width.mas_equalTo(Lcenter);
            make.height.equalTo(self).multipliedBy(0.25);
        }];
        
        
        //
        UILabel *lbTitle2 = [[UILabel alloc] init];
        lbTitle2.text = @"成交额:";
        lbTitle2.backgroundColor = [UIColor clearColor];
        lbTitle2.textColor = kUIColorFromRGB(0x666666);
        lbTitle2.font = [UIFont systemFontOfSize:12];
        [self addSubview:lbTitle2];
        [lbTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(7);
            make.left.equalTo(self).offset(Xcenter+Lcenter-20);
            make.width.mas_equalTo(Lcenter);
            make.height.equalTo(self).multipliedBy(0.25);
        }];
        
        _lbAmount = [[UILabel alloc] init];
        _lbAmount.text = @"--";
        _lbAmount.backgroundColor = [UIColor clearColor];
        _lbAmount.textColor = kUIColorFromRGB(0x333333);
        _lbAmount.font = valueFont;
        [self addSubview:_lbAmount];
        [_lbAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle2.mas_bottom).offset(-5);
            make.left.equalTo(self).offset(Xcenter+Lcenter-20);
            make.width.mas_equalTo(Lcenter);
            make.height.equalTo(self).multipliedBy(0.25);
        }];
        
        //
        UILabel *lbTitle3 = [[UILabel alloc] init];
        lbTitle3.text = @"最低:";
        lbTitle3.backgroundColor = [UIColor clearColor];
        lbTitle3.textColor = kUIColorFromRGB(0x666666);
        lbTitle3.font = [UIFont systemFontOfSize:12];
        [self addSubview:lbTitle3];
        [lbTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbAmount.mas_bottom).offset(0);
            make.left.equalTo(self).offset(Xcenter);
            make.width.mas_equalTo(Lcenter);
            make.height.equalTo(self).multipliedBy(0.25);
        }];
        
        _lbLowest = [[UILabel alloc] init];
        _lbLowest.text = @"--";
        _lbLowest.backgroundColor = [UIColor clearColor];
        _lbLowest.textColor = kUIColorFromRGB(0x333333);
        _lbLowest.font = valueFont;
        [self addSubview:_lbLowest];
        [_lbLowest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle3.mas_bottom).offset(-5);
            make.left.equalTo(self).offset(Xcenter);
            make.width.mas_equalTo(Lcenter);
            make.height.equalTo(self).multipliedBy(0.25);
        }];
        */
        //
        
        
        UILabel *lbTitle4 = [[UILabel alloc] init];
        lbTitle4.text = @"成交量(股):";
        lbTitle4.backgroundColor = [UIColor clearColor];
        lbTitle4.textColor = kUIColorFromRGB(0x666666);//[UIColor whiteColor];//kUIColorFromRGB(0x666666);
        lbTitle4.font = [UIFont systemFontOfSize:12];
        [self addSubview:lbTitle4];
        [lbTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(_lbValue.mas_right).offset(5);
            make.width.mas_equalTo(65);
            make.height.equalTo(self);
        }];
        
        _lbVolume = [[UILabel alloc] init];
        _lbVolume.text = @"--";
        _lbVolume.backgroundColor = [UIColor clearColor];
        _lbVolume.textColor = kUIColorFromRGB(0x666666);//[UIColor whiteColor];//kUIColorFromRGB(0x333333);
        _lbVolume.font = [UIFont systemFontOfSize:12];
        [self addSubview:_lbVolume];
        [_lbVolume mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(lbTitle4.mas_right);
            make.width.mas_equalTo(70);
            make.height.equalTo(self);
        }];
        
        UILabel *lbTitle5 = [[UILabel alloc] init];
        lbTitle5.text = @"时间:";
        lbTitle5.backgroundColor = [UIColor clearColor];
        lbTitle5.textColor = kUIColorFromRGB(0x666666);//[UIColor whiteColor];//kUIColorFromRGB(0x666666);
        lbTitle5.font = [UIFont systemFontOfSize:12];
        [self addSubview:lbTitle5];
        [lbTitle5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(_lbVolume.mas_right).offset(5);
            make.width.mas_equalTo(30);
            make.height.equalTo(self);
        }];
        
        _lbTime = [[UILabel alloc] init];
        _lbTime.text = @"";
        _lbTime.backgroundColor = [UIColor clearColor];
        _lbTime.textColor = kUIColorFromRGB(0x666666);//[UIColor whiteColor];//kUIColorFromRGB(0x333333);
        _lbTime.font = [UIFont systemFontOfSize:12];
        [self addSubview:_lbTime];
        [_lbTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(lbTitle5.mas_right);
            make.width.mas_equalTo(80);
            make.height.equalTo(self);
        }];
        
        
        
        
        
        
        //right btn
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [UIImage imageNamed:@"dismiss_icon_blue"];
        [closeBtn setImage:icon forState:UIControlStateNormal];
        //[closeBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 12, 7, 12)];
        [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self).offset(-10);
            make.width.mas_equalTo(34);
        }];
        
        
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
}

- (void)setCode:(NSString *)code
           name:(NSString *)name
          value:(NSString *)value
         change:(NSString *)change
     changeRate:(NSString *)changeRate
         volume:(NSString *)volume
           time:(NSString *)time
{
    UIColor *textColor;
    
    if (_bShowCode) {
        _lbName.text = [NSString stringWithFormat:@"%@ %@",name,code];
    }
    else{
        _lbName.text = name;
    }
    
    
    NSString *strChangeRate;
    if ((change == nil)|| [change isEqualToString:@""]||[change isEqualToString:@"--"])
    {
//        _lbChange.text = @"--";
//        _lbChangeRate.text = @"--";
        
        _lbValue.text = [NSString stringWithFormat:@"%@(%@)",@"--",@"--"];//value

    }
    else
    {
        if ([change floatValue]>0.000001)
        {
            textColor = RISE_COLOR;
            
//            _lbChange.text = [NSString stringWithFormat:@"+%@",change];
//            _lbChangeRate.text = [NSString stringWithFormat:@"+%@",changeRate];
            
            strChangeRate = [NSString stringWithFormat:@"+%@",changeRate];
        }
        else if ([change floatValue]<-0.000001)
        {
            textColor = FALL_COLOR;
            
//            _lbChange.text = change;
//            _lbChangeRate.text = changeRate;
            
            strChangeRate = changeRate;
        }
        else
        {
            textColor = kUIColorFromRGB(0xc3c3c3);// PLAN_COLOR;
            
//            _lbChange.text = change;
//            _lbChangeRate.text = changeRate;
            
            strChangeRate = changeRate;

        }
        [_lbValue setTextColor:textColor];
//        [_lbChange setTextColor:textColor];
//        [_lbChangeRate setTextColor:textColor];
        
        _lbValue.text = [NSString stringWithFormat:@"%@(%@)",value,strChangeRate];//value

    }
    
    
    _lbVolume.text = volume;
    
    _lbTime.text = time;

}


#pragma mark - IndexBlockDelegate
- (void)closeBtnAction
{
    if([delegate respondsToSelector:@selector(horStockInfoView:)])
    {
        [delegate horStockInfoView:self ];
    }
}



@end
