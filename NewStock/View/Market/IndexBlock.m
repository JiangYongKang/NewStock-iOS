//
//  IndexBlock.m
//  NewStock
//
//  Created by Willey on 16/7/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "IndexBlock.h"
#import "MarketConfig.h"
#import "Masonry.h"
#import "Defination.h"

@implementation IndexBlock
@synthesize delegate;

- (id)initWithDelegate:(id)theDelegate tag:(int)tag type:(IndexBlockType)type {
    if (self = [super init]) {
        self.type = type;
        self = [self initWithDelegate:theDelegate tag:tag];
    }
    return self;
}

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
        _lbTitle.font = [UIFont systemFontOfSize:14 * kScale];
        [self addSubview:_lbTitle];

        
        _lbValue = [[UILabel alloc] init];
        _lbValue.text = @"--";
        _lbValue.backgroundColor = [UIColor clearColor];
        _lbValue.textAlignment = NSTextAlignmentCenter;
        _lbValue.textColor = PLAN_COLOR;
        _lbValue.font = [UIFont boldSystemFontOfSize:20 * kScale];
        [self addSubview:_lbValue];

        
        _lbChange = [[UILabel alloc] init];
        _lbChange.text = @"--";
        _lbChange.backgroundColor = [UIColor clearColor];
        _lbChange.textAlignment = NSTextAlignmentCenter;
        _lbChange.textColor = PLAN_COLOR;
        _lbChange.font = [UIFont systemFontOfSize:12 * kScale];
        [self addSubview:_lbChange];

        
        _lbChangeRate = [[UILabel alloc] init];
        _lbChangeRate.text = @"--";
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        _lbChangeRate.textAlignment = NSTextAlignmentCenter;
        _lbChangeRate.textColor = PLAN_COLOR;
        _lbChangeRate.font = [UIFont systemFontOfSize:12 * kScale];
        [self addSubview:_lbChangeRate];
        
        if (self.type == IndexBlockTypeMainPage) {
            _lbValue.font = [UIFont boldSystemFontOfSize:16 * kScale];
            _lbChange.font = [UIFont systemFontOfSize:10 * kScale];
            _lbChangeRate.font = [UIFont systemFontOfSize:10 * kScale];
        }

        [self dealWithCons];
        
        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        gensture.delegate = self;
        [self addGestureRecognizer:gensture];
    }
    return self;
}

- (void)dealWithCons {
    [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbTitle.superview).offset(12 * kScale);
        make.left.equalTo(_lbTitle.superview).offset(0);
        make.right.equalTo(_lbTitle.superview).offset(0);
    }];
    
    [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lbValue.superview).offset(0);
        make.right.equalTo(_lbValue.superview).offset(0);
        make.centerY.equalTo(_lbValue.superview).offset(2 * kScale);
    }];
    
    [_lbChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-12 * kScale);
        make.left.equalTo(_lbChange.superview);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [_lbChangeRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_lbChange);
        make.right.equalTo(_lbChangeRate.superview);
        make.width.equalTo(_lbChange);
    }];
    if (_type == IndexBlockTypeMainPage) {
        [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbTitle.superview).offset(6 * kScale);
        }];
        
        [_lbValue mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_lbValue.superview).offset(2 * kScale);
        }];
        
        [_lbChange mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-6 * kScale);
            make.left.equalTo(_lbChange.superview).offset(5 * kScale);
        }];
        
        [_lbChangeRate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_lbChangeRate.superview).offset(-5 * kScale);
        }];
    }
}

- (void)setTitle:(NSString *)title
{
}

- (void)setCode:(NSString *)code title:(NSString *)title value:(NSString *)value change:(NSString *)change changeRate:(NSString *)changeRate
{
    _strCode = code;
    UIColor *textColor;
    
    if (fabs([value floatValue])<0.000001)
    {
        _lbTitle.text = title;
        _lbValue.text = @"--";
        _lbChange.text = @"--";
        _lbChangeRate.text = @"--";
        
        return;
    }
    
    
    if ([change floatValue]>0.000001)
    {
        textColor = RISE_COLOR;
        
        _lbTitle.text = title;
        _lbValue.text = value;
        _lbChange.text = [NSString stringWithFormat:@"+%@",change];
        _lbChangeRate.text = [NSString stringWithFormat:@"+%@",changeRate];
    }
    else if ([change floatValue]<-0.000001)
    {
        textColor = FALL_COLOR;
        
        _lbTitle.text = title;
        _lbValue.text = value;
        _lbChange.text = change;
        _lbChangeRate.text = changeRate;
    }
    else
    {
        textColor = PLAN_COLOR;
        
        _lbTitle.text = title;
        _lbValue.text = value;
        _lbChange.text = change;
        _lbChangeRate.text = changeRate;
    }
    //[_lbTitle setTextColor:textColor];
    [_lbValue setTextColor:textColor];
    [_lbChange setTextColor:textColor];
    [_lbChangeRate setTextColor:textColor];
    
   
}


#pragma mark - IndexBlockDelegate
- (void)tapAction
{
    if([delegate respondsToSelector:@selector(indexBlock:code:)])
    {
        [delegate indexBlock:self code:_strCode];
    }
}


@end
