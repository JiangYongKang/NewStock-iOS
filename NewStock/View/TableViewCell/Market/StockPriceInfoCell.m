//
//  StockPriceInfoCell.m
//  NewStock
//
//  Created by Willey on 16/8/13.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockPriceInfoCell.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "Masonry.h"

@implementation StockPriceInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _valueLb = [[UILabel alloc] init];
        _valueLb.backgroundColor = [UIColor clearColor];
        _valueLb.textColor = [UIColor darkGrayColor];
        _valueLb.font = [UIFont systemFontOfSize:26.0f];
        _valueLb.text = @"--";
        _valueLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_valueLb];
        
        _increaceValue = [[UILabel alloc] init];
        _increaceValue.backgroundColor = [UIColor clearColor];
        _increaceValue.textColor = [UIColor darkGrayColor];
        _increaceValue.font = [UIFont systemFontOfSize:15.0f];
        _increaceValue.text = @"--";
        _increaceValue.textAlignment = NSTextAlignmentCenter;
        _increaceValue.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_increaceValue];
        
        _increace = [[UILabel alloc] init];
        _increace.backgroundColor = [UIColor clearColor];
        _increace.textColor = [UIColor darkGrayColor];
        _increace.font = [UIFont systemFontOfSize:15.0f];
        _increace.text = @"--";
        _increace.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_increace];
        
        _upDownLb = [[UILabel alloc] init];
        _upDownLb.backgroundColor = [UIColor clearColor];
        _upDownLb.textColor = [UIColor darkGrayColor];
        _upDownLb.font = [UIFont systemFontOfSize:12.0f];
        _upDownLb.text = @"";
        _upDownLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_upDownLb];
        //self.contentView.backgroundColor = TITLE_BAR_BG_COLOR;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_valueLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self).multipliedBy(0.5);
    }];
    
    [_increaceValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0).offset(6);
        make.height.mas_equalTo(24);
        make.left.equalTo(_valueLb.mas_right);
        make.width.mas_equalTo(self).multipliedBy(0.25);
    }];
    
    [_increace mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0).offset(6);
        make.height.mas_equalTo(24);
        make.left.equalTo(_increaceValue.mas_right);
        make.width.mas_equalTo(self).multipliedBy(0.25);
    }];
    
    
    [_upDownLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_valueLb.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
        make.left.equalTo(self);
        make.width.mas_equalTo(self);
    }];
  
}

- (void)setValue:(NSString *)value increaceValue:(NSString *)increaceValue increace:(NSString *)increace {
    _valueLb.text = value;
    _increaceValue.text = increaceValue;
    _increace.text = increace;
    
        UIColor *textColor;
        if ([increaceValue floatValue]>0.000001)
        {
            textColor = RISE_COLOR;
            _increaceValue.text = [NSString stringWithFormat:@"+%@",increaceValue];
            _increace.text = [NSString stringWithFormat:@"+%@",increace];
        }
        else if ([increaceValue floatValue]<-0.000001)
        {
            textColor = FALL_COLOR;
        }
        else
        {
            textColor = PLAN_COLOR;
        }
    [_valueLb setTextColor:textColor];
    [_increaceValue setTextColor:textColor];
    [_increace setTextColor:textColor];
}


- (void)setUp:(NSString *)upStr plan:(NSString *)planStr down:(NSString *)downStr {
    if([upStr isEqualToString:@""])upStr= @"0";
    if([planStr isEqualToString:@""])planStr= @"0";
    if([downStr isEqualToString:@""])downStr= @"0";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"上涨 %@ 家  平盘 %@ 家  下跌 %@ 家",upStr,planStr,downStr]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:RISE_COLOR range:NSMakeRange(3,upStr.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(3+upStr.length,7)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(3+upStr.length+7,planStr.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(3+upStr.length+7+planStr.length,7)];
    [str addAttribute:NSForegroundColorAttributeName value:FALL_COLOR range:NSMakeRange(3+upStr.length+7+planStr.length+7,downStr.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(3+upStr.length+7+planStr.length+7+downStr.length,2)];
    _upDownLb.attributedText = str;
}

@end
