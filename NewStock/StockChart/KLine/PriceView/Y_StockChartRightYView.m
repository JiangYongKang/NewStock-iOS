//
//  Y_StockChartRightYView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_StockChartRightYView.h"
#import "UIColor+Y_StockChart.h"
#import "Masonry.h"
#import "SystemUtil.h"
#import "MarketConfig.h"
#import "Defination.h"

@interface Y_StockChartRightYView ()

@property(nonatomic,strong) UILabel *maxValueLabel;

@property(nonatomic,strong) UILabel *middleValueLabel;

@property(nonatomic,strong) UILabel *minValueLabel;

@end


@implementation Y_StockChartRightYView

-(void)setMaxValue:(CGFloat)maxValue
{
    _maxValue = maxValue;
    if (self.type == 0)
    {
        self.maxValueLabel.text = [SystemUtil getPrecisionPrice:maxValue precision:2];
    }
    else
    {
        self.maxValueLabel.text = [SystemUtil FormatFloatValue:maxValue dig:2];//[NSString stringWithFormat:@"%.2f",maxValue];
    }
}

-(void)setMiddleValue:(CGFloat)middleValue
{
    _middleValue = middleValue;
    if (self.type == 0)
    {
        self.middleValueLabel.text = [SystemUtil getPrecisionPrice:middleValue precision:2];
    }
    else
    {
        self.middleValueLabel.text = [SystemUtil FormatFloatValue:middleValue dig:2];//[NSString stringWithFormat:@"%.2f",middleValue];
    }
}


-(void)setMinValue:(CGFloat)minValue
{
    _minValue = minValue;
    if (self.type == 0)
    {
        self.minValueLabel.text = [SystemUtil getPrecisionPrice:minValue precision:2];
    }
    else
    {
        self.minValueLabel.text = [SystemUtil FormatFloatValue:minValue dig:2];//[NSString stringWithFormat:@"%.2f",minValue];
    }
}

-(void)setUp:(NSString *)up
{
    self.maxValueLabel.text = up;
    self.maxValueLabel.textColor= RISE_COLOR;
}
-(void)setDown:(NSString *)down
{
    self.minValueLabel.text = down;
    self.minValueLabel.textColor = FALL_COLOR;
}
-(void)setPlan:(NSString *)plan
{
    self.middleValueLabel.text = plan;
    self.middleValueLabel.textColor = kUIColorFromRGB(0x333333);//PLAN_COLOR;
}
-(void)setMinLabelText:(NSString *)minLabelText
{
    _minLabelText = minLabelText;
    self.minValueLabel.text = minLabelText;
}

-(void)setAlignment:(NSTextAlignment)textAlignment
{
    self.maxValueLabel.textAlignment = textAlignment;
    self.middleValueLabel.textAlignment = textAlignment;
    self.minValueLabel.textAlignment = textAlignment;
}

#pragma mark - get方法
#pragma mark maxPriceLabel的get方法
-(UILabel *)maxValueLabel
{
    if (!_maxValueLabel) {
        _maxValueLabel = [self private_createLabel];
        [self addSubview:_maxValueLabel];
        [_maxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.width.equalTo(self);
            make.height.equalTo(@20);
        }];
    }
    return _maxValueLabel;
}

#pragma mark middlePriceLabel的get方法
-(UILabel *)middleValueLabel
{
    if (!_middleValueLabel) {
        _middleValueLabel = [self private_createLabel];
        [self addSubview:_middleValueLabel];
        [_middleValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    return _middleValueLabel;
}

#pragma mark minPriceLabel的get方法
-(UILabel *)minValueLabel
{
    if (!_minValueLabel) {
        _minValueLabel = [self private_createLabel];
        [self addSubview:_minValueLabel];
        [_minValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    return _minValueLabel;
}

#pragma mark - 私有方法
#pragma mark 创建Label
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = kUIColorFromRGB(0x333333);//[UIColor assistTextColor];
    label.textAlignment = NSTextAlignmentRight;
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
    return label;
}
@end
