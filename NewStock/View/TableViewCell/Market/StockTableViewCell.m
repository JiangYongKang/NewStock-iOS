//
//  StockTableViewCell.m
//  NewStock
//
//  Created by Willey on 16/7/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockTableViewCell.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

@implementation StockTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        int Xcenter = MAIN_SCREEN_WIDTH/2;
        
        _stockNameLb = [[UILabel alloc] initWithFrame:CGRectMake(12 * kScale, 5, 100, 25)];
        _stockNameLb.backgroundColor = [UIColor clearColor];
        _stockNameLb.textColor = kUIColorFromRGB(0x333333);
        _stockNameLb.font = [UIFont boldSystemFontOfSize:16.0f];
        _stockNameLb.text = @"--";
        _stockNameLb.textAlignment = NSTextAlignmentLeft;//NSTextAlignmentCenter;
        [self.contentView addSubview:_stockNameLb];
        
        _stockCodeLb = [[UILabel alloc] initWithFrame:CGRectMake(12 * kScale, 30, 100, 12)];
        _stockCodeLb.backgroundColor = [UIColor clearColor];
        _stockCodeLb.textColor = kUIColorFromRGB(0x666666);
        _stockCodeLb.font = [UIFont systemFontOfSize:11.0f];
        _stockCodeLb.text = @"--";
        _stockCodeLb.textAlignment = NSTextAlignmentLeft;//NSTextAlignmentCenter;
        [self.contentView addSubview:_stockCodeLb];
        
        _valueLb = [[UILabel alloc] initWithFrame:CGRectMake(Xcenter - 70, 9, 100, 30)];
        _valueLb.backgroundColor = [UIColor clearColor];
        _valueLb.textColor = PLAN_COLOR;
        _valueLb.font = [UIFont boldSystemFontOfSize:17.0f];
        _valueLb.text = @"--";
        _valueLb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_valueLb];
        
        _lbChangeRate = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH - 95, 9, 80, 30)];
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        _lbChangeRate.textColor = PLAN_COLOR;
        _lbChangeRate.font = [UIFont boldSystemFontOfSize:15.0f];
        _lbChangeRate.text = @"--";
        _lbChangeRate.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lbChangeRate];
        
        //下方分割线 
    }
    return self;
}

- (void)setCode:(NSString *)code name:(NSString *)name value:(NSString *)value changeRate:(NSString *)changeRate marketCd:(NSString *)marketCd {
    NSString *marketCode;
    if ([marketCd intValue]==1)
    {
        marketCode = [NSString stringWithFormat:@"SH%@",code];
    }
    else if ([marketCd intValue]==2)
    {
        marketCode = [NSString stringWithFormat:@"SZ%@",code];
    }
    else
    {
        marketCode = code;
    }
    
    _stockNameLb.text = name;
    _stockCodeLb.text = marketCode;
    //_valueLb.text = value;
    _lbChangeRate.text = changeRate;
    
    
    if (fabs([value floatValue])<0.000001)
    {
        //_stockNameLb.text = name;
        _valueLb.text = @"--";
        if([changeRate isEqualToString:@""])
        {
            _lbChangeRate.text = @"";
        }
        else
        {
            _lbChangeRate.text = @"--";
        }
        return;
    }
    
    _valueLb.text = [SystemUtil get2decimal:[value floatValue]];//value;

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

- (void)setVoluem:(NSString *)voluem {
    _lbChangeRate.text = [SystemUtil FormatValue:voluem dig:2];

    [_lbChangeRate setTextColor:PLAN_COLOR];

}

- (void)setTurnover:(NSString *)turnover {
    _lbChangeRate.text = [SystemUtil getPercentage:[turnover floatValue]];

    [_lbChangeRate setTextColor:PLAN_COLOR];

}

- (void)setMin5UpDown:(NSString *)min5UpDown {
    _lbChangeRate.text = min5UpDown;
    
    if (min5UpDown.floatValue>0.000001)
    {
        [_lbChangeRate setTextColor:RISE_COLOR];
    }
    else if(min5UpDown.floatValue<-0.000001)
    {
        [_lbChangeRate setTextColor:FALL_COLOR];
    }
    else
    {
        [_lbChangeRate setTextColor:PLAN_COLOR];
    }
}

- (void)setCode:(NSString *)code name:(NSString *)name marketCd:(NSString *)marketCd {
    NSString *marketCode;
    if ([marketCd intValue]==1)
    {
        marketCode = [NSString stringWithFormat:@"SH%@",code];
    }
    else if ([marketCd intValue]==2)
    {
        marketCode = [NSString stringWithFormat:@"SZ%@",code];
    }
    else
    {
        marketCode = code;
    }
    
    _stockNameLb.text = name;
    _stockCodeLb.text = marketCode;
    
    _valueLb.text = @"";
    _lbChangeRate.text = @"";

   
}

@end
