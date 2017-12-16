//
//  BlockTableViewCell.m
//  NewStock
//
//  Created by Willey on 16/7/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BlockTableViewCell.h"
#import "Defination.h"
#import "MarketConfig.h"

@implementation BlockTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _blockNameLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, 200, 30)];
        _blockNameLb.backgroundColor = [UIColor clearColor];
        _blockNameLb.textColor = kUIColorFromRGB(0x333333);
        _blockNameLb.font = [UIFont boldSystemFontOfSize:16.0f];
        _blockNameLb.text = @"--";
        _blockNameLb.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_blockNameLb];
        
        _lbChangeRate = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH/2-70, 9, 100, 30)];
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        _lbChangeRate.textColor = PLAN_COLOR;
        _lbChangeRate.font = [UIFont boldSystemFontOfSize:17.0f];
        _lbChangeRate.text = @"--";
        _lbChangeRate.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lbChangeRate];
        
        
        _lbLeadingStockName = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-120, 8, 105, 20)];
        _lbLeadingStockName.backgroundColor = [UIColor clearColor];
        _lbLeadingStockName.textColor = kUIColorFromRGB(0x333333);
        _lbLeadingStockName.font = [UIFont boldSystemFontOfSize:16.0f];
        _lbLeadingStockName.text = @"";
        _lbLeadingStockName.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lbLeadingStockName];
        
        _lbLeadingStockCode = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-120, 28, 105, 15)];
        _lbLeadingStockCode.backgroundColor = [UIColor clearColor];
        _lbLeadingStockCode.textColor = kUIColorFromRGB(0x666666);
        _lbLeadingStockCode.font = [UIFont systemFontOfSize:11.0f];
        _lbLeadingStockCode.text = @"";
        _lbLeadingStockCode.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lbLeadingStockCode];

    }
    return self;
}



- (void)setName:(NSString *)name changeRate:(NSString *)changeRate
{
    _blockNameLb.text = name;
    _lbChangeRate.text = changeRate;
    
    if ([changeRate isEqualToString:@"--"])
    {
        [_lbChangeRate setTextColor:PLAN_COLOR];
        return;
    }
    
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
    [_lbChangeRate setTextColor:textColor];
}

- (void)setLeadingStockName:(NSString *)name LeadingStockCode:(NSString *)code
{
    _lbLeadingStockName.text = name;

    _lbLeadingStockCode.text = code;
}

@end
