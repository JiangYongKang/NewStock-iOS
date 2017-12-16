//
//  ForeignTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2016/12/8.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ForeignTableViewCell.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

@implementation ForeignTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        int Xcenter = MAIN_SCREEN_WIDTH/2;
        
        _stockNameLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 120, 25)];
        _stockNameLb.backgroundColor = [UIColor clearColor];
        _stockNameLb.textColor = kUIColorFromRGB(0x333333);
        _stockNameLb.font = [UIFont boldSystemFontOfSize:16.0f];
        _stockNameLb.text = @"--";
        _stockNameLb.textAlignment = NSTextAlignmentLeft;//NSTextAlignmentCenter;
        [self.contentView addSubview:_stockNameLb];
        
        _valueLb = [[UILabel alloc] initWithFrame:CGRectMake(Xcenter-60, 9, 100, 30)];
        _valueLb.backgroundColor = [UIColor clearColor];
        _valueLb.textColor = PLAN_COLOR;
        _valueLb.font = [UIFont boldSystemFontOfSize:17.0f];
        _valueLb.text = @"--";
        _valueLb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_valueLb];
        
        _lbChangeRate = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-95, 9, 80, 30)];
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        _lbChangeRate.textColor = PLAN_COLOR;
        _lbChangeRate.font = [UIFont boldSystemFontOfSize:15.0f];
        _lbChangeRate.text = @"--";
        _lbChangeRate.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lbChangeRate];
        
    }
    return self;
}

- (void)setName:(NSString *)name value:(NSString *)value changeRate:(NSString *)changeRate {

    _stockNameLb.text = name;
    _valueLb.text = value;
    _lbChangeRate.text = changeRate;
    
    UIColor *textColor;
    if ([changeRate floatValue]>0.000001)
    {
        textColor = RISE_COLOR;
    }
    else if ([changeRate floatValue]<-0.000001)
    {
        textColor = FALL_COLOR;
    }
    else
    {
        textColor = PLAN_COLOR;
    }
    
    [_valueLb setTextColor:textColor];
    [_lbChangeRate setTextColor:textColor];
    
    
}





@end
