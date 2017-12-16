//
//  PlateBlock.m
//  NewStock
//
//  Created by Willey on 16/7/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PlateBlock.h"
#import "MarketConfig.h"
#import "Masonry.h"
#import "Defination.h"

@implementation PlateBlock
@synthesize delegate;

- (id)initWithDelegate:(id)theDelegate tag:(int)tag {
    self = [super init];
    if (self) {
        self.delegate = theDelegate;
        self.tag = tag;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"--";
        _lbTitle.backgroundColor = [UIColor clearColor];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.textColor = kUIColorFromRGB(0x333333);
        _lbTitle.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbTitle.superview).offset(3);
            make.left.equalTo(_lbTitle.superview).offset(0);
            make.right.equalTo(_lbTitle.superview).offset(0);
            make.height.equalTo(self).multipliedBy(0.25);
        }];
        

        _lbValue = [[UILabel alloc] init];
        _lbValue.text = @"--";
        _lbValue.backgroundColor = [UIColor clearColor];
        _lbValue.textAlignment = NSTextAlignmentCenter;
        _lbValue.textColor = PLAN_COLOR;
        _lbValue.font = [UIFont boldSystemFontOfSize:22];
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbTitle.mas_bottom).offset(0);
            make.left.equalTo(_lbValue.superview).offset(0);
            make.right.equalTo(_lbValue.superview).offset(0);
            make.height.equalTo(self).multipliedBy(0.25);
        }];
        

        
        _nameLb = [[UILabel alloc] init];
        _nameLb.text = @"--";
        _nameLb.backgroundColor = [UIColor clearColor];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.textColor = kUIColorFromRGB(0x666666);
        _nameLb.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbValue.mas_bottom).offset(5);
            make.left.equalTo(_nameLb.superview).offset(0);
            make.right.equalTo(_nameLb.superview).offset(0);
            make.height.equalTo(self).multipliedBy(0.2);
        }];
        
        
        _lbChange = [[UILabel alloc] init];
        _lbChange.text = @"--";
        _lbChange.backgroundColor = [UIColor clearColor];
        _lbChange.textAlignment = NSTextAlignmentCenter;
        _lbChange.textColor = PLAN_COLOR;
        _lbChange.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_lbChange];
        [_lbChange mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLb.mas_bottom).offset(-2);
            make.left.equalTo(_lbChange.superview).offset(0);
            make.width.equalTo(self).multipliedBy(0.5);
            make.height.equalTo(self).multipliedBy(0.2);
        }];
        
        _lbChangeRate = [[UILabel alloc] init];
        _lbChangeRate.text = @"--";
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        _lbChangeRate.textAlignment = NSTextAlignmentCenter;
        _lbChangeRate.textColor = PLAN_COLOR;
        _lbChangeRate.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_lbChangeRate];
        [_lbChangeRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLb.mas_bottom).offset(-2);
            make.right.equalTo(_lbChangeRate.superview).offset(0);
            make.width.equalTo(self).multipliedBy(0.5);
            make.height.equalTo(self).multipliedBy(0.2);
        }];
        
        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        gensture.delegate = self;
        [self addGestureRecognizer:gensture];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
}

- (void)setCode:(NSString *)code title:(NSString *)title value:(NSString *)value name:(NSString *)name change:(NSString *)change changeRate:(NSString *)changeRate
{
    _strCode = code;
    UIColor *textColor;
    
    _lbTitle.text = title;

    _nameLb.text = name;

    if ([value floatValue]>0.000001)
    {
        _lbValue.text = [NSString stringWithFormat:@"+%@",value];
        [_lbValue setTextColor:RISE_COLOR];
    }
    else if ([value floatValue]<-0.000001)
    {
        _lbValue.text = value;
        [_lbValue setTextColor:FALL_COLOR];
    }
    else
    {
        _lbValue.text = value;
        [_lbValue setTextColor:PLAN_COLOR];
    }
    
    
    //
    if ([changeRate floatValue]>0.000001)
    {
        textColor = RISE_COLOR;
        
        
        _lbChange.text = change;//[NSString stringWithFormat:@"+%@",change];
        _lbChangeRate.text = [NSString stringWithFormat:@"+%@",changeRate];
    }
    else if ([changeRate floatValue]<-0.000001)
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
    [_lbChange setTextColor:textColor];
    [_lbChangeRate setTextColor:textColor];
    
   
}


#pragma mark - PlateBlockDelegate
- (void)tapAction
{
    if([delegate respondsToSelector:@selector(plateBlock:code:)])
    {
        [delegate plateBlock:self code:_strCode];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
