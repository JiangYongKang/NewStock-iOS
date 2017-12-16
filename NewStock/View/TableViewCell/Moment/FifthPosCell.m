//
//  FifthPosCell.m
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FifthPosCell.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "Masonry.h"
#import "SystemUtil.h"

@implementation FifthPosCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLb = [[UILabel alloc] init];
        _nameLb.backgroundColor = [UIColor clearColor];
        _nameLb.textColor = [UIColor darkGrayColor];
        _nameLb.font = [UIFont systemFontOfSize:11.0f * kScale];
        _nameLb.text = @"";
        _nameLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLb];
        
        _handsLb = [[UILabel alloc] init];
        _handsLb.backgroundColor = [UIColor clearColor];
        _handsLb.textColor = [UIColor darkGrayColor];
        _handsLb.font = [UIFont systemFontOfSize:11.0f * kScale];
        _handsLb.text = @"";
        _handsLb.textAlignment = NSTextAlignmentRight;
        _handsLb.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_handsLb];
        
        _valueLb = [[UILabel alloc] init];
        _valueLb.backgroundColor = [UIColor clearColor];
        _valueLb.textColor = [UIColor darkGrayColor];
        _valueLb.font = [UIFont systemFontOfSize:11.0f * kScale];
        _valueLb.text = @"";
        _valueLb.textAlignment = NSTextAlignmentCenter;
        _valueLb.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_valueLb];
        
        //self.contentView.backgroundColor = TITLE_BAR_BG_COLOR;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLb.superview).offset(0);
        make.left.equalTo(_nameLb.superview).offset(0 * kScale);
        make.bottom.equalTo(_nameLb.superview).offset(0);
        make.width.mas_equalTo(35 * kScale);
    }];
    
    [_handsLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_handsLb.superview).offset(0);
        make.right.equalTo(_handsLb.superview).offset(-3);
        make.bottom.equalTo(_handsLb.superview).offset(0);
        make.width.mas_equalTo(40 * kScale);
    }];

    [_valueLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_valueLb.superview).offset(0);
        make.bottom.equalTo(_valueLb.superview).offset(0);
        make.left.equalTo(_nameLb.mas_right);
        make.right.equalTo(_handsLb.mas_left);
    }];
}

- (void)setName:(NSString *)name value:(NSString *)value hands:(NSString *)hands {
    _nameLb.text = name;
    _valueLb.text = [SystemUtil FormatValue:value dig:2];//value
    if (hands.floatValue > 10000) {
        _handsLb.text = [NSString stringWithFormat:@"%.2lf万",hands.floatValue / 10000];
    } else {
        _handsLb.text = hands;
    }
    
    if (_prevClose > 0.000001) {
        UIColor *textColor;

        if ([value floatValue] > _prevClose) {
            textColor = RISE_COLOR;
        } else if ([value floatValue] < _prevClose) {
            textColor = FALL_COLOR;
        } else {
            textColor = PLAN_COLOR;
        }
        
        [_valueLb setTextColor:textColor];
    }
    
}

- (void)setPrevClose:(float)f {
    _prevClose = f;
}

- (void)setValueColor:(UIColor *)color {
    [_valueLb setTextColor:color];
}

- (void)setHandsColor:(UIColor *)color {
    [_handsLb setTextColor:color];
}

@end
