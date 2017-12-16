//
//  Y_KLineFollowView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineFollowView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
#import "Y_KLineModel.h"
#import "MarketConfig.h"
#import "SystemUtil.h"
#import "AppDelegate.h"

@interface Y_KLineFollowView ()

@property (strong, nonatomic) UILabel *dateDescLabel;



@property (strong, nonatomic) UILabel *openDescLabel;

@property (strong, nonatomic) UILabel *closeDescLabel;

@property (strong, nonatomic) UILabel *highDescLabel;

@property (strong, nonatomic) UILabel *lowDescLabel;

@property (strong, nonatomic) UILabel *openLabel;

@property (strong, nonatomic) UILabel *closeLabel;

@property (strong, nonatomic) UILabel *highLabel;

@property (strong, nonatomic) UILabel *lowLabel;


@property (strong, nonatomic) UILabel *changeDescLabel;
@property (strong, nonatomic) UILabel *changeLabel;

@property (strong, nonatomic) UILabel *volumeDescLabel;
@property (strong, nonatomic) UILabel *volumeLabel;

@end

@implementation Y_KLineFollowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dateDescLabel = [self private_createLabel];
        
        
        _openDescLabel = [self private_createLabel];
        _openDescLabel.text = @" 开:";
        
        _closeDescLabel = [self private_createLabel];
        _closeDescLabel.text = @" 收:";
        
        _highDescLabel = [self private_createLabel];
        _highDescLabel.text = @" 高:";
        
        _lowDescLabel = [self private_createLabel];
        _lowDescLabel.text = @" 低:";
        
        _changeDescLabel = [self private_createLabel];
        _changeDescLabel.text = @" 幅:";
        
        _volumeDescLabel = [self private_createLabel];
        _volumeDescLabel.text = @" 量:";

        _openLabel = [self private_createLabel];
        _closeLabel = [self private_createLabel];
        _highLabel = [self private_createLabel];
        _lowLabel = [self private_createLabel];
        _changeLabel = [self private_createLabel];
        _volumeLabel = [self private_createLabel];

        _openLabel.textColor = [UIColor assistTextColor];
        _highLabel.textColor = [UIColor assistTextColor];
        _lowLabel.textColor = [UIColor assistTextColor];
        _closeLabel.textColor = [UIColor assistTextColor];
        _changeLabel.textColor = [UIColor assistTextColor];
        _volumeLabel.textColor = [UIColor assistTextColor];
        
        NSNumber *labelWidth = [NSNumber numberWithInt:(MAIN_SCREEN_WIDTH-80)/3-20];//70
        NSNumber *dateWidth = [NSNumber numberWithInt:80];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.isEable == YES)
        {
            labelWidth = [NSNumber numberWithInt:100];
            dateWidth = [NSNumber numberWithInt:125];
        }
                
        [_dateDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self);
            make.height.equalTo(self.mas_height).multipliedBy(0.5);
            make.width.equalTo(dateWidth);
            //make.width.equalTo(self.mas_width).multipliedBy(0.2);

        }];
        
        //开 收
        [_openDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_dateDescLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
        }];
        
        [_openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_openDescLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
            make.width.equalTo(labelWidth);
            
        }];
        
        [_closeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_openDescLabel.mas_left);
            make.top.equalTo(_openDescLabel.mas_bottom);
            make.bottom.equalTo(self);
        }];
        
        [_closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_closeDescLabel.mas_right);
            make.top.equalTo(_closeDescLabel.mas_top);
            make.bottom.equalTo(_closeDescLabel.mas_bottom);
            make.width.equalTo(labelWidth);
            
        }];
        
        //高 低
        [_highDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_openLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
        }];
        
        [_highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_highDescLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
            make.width.equalTo(labelWidth);
            
        }];
        
        [_lowDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_highDescLabel.mas_left);
            make.top.equalTo(_highDescLabel.mas_bottom);
            make.bottom.equalTo(self);
        }];
        
        [_lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lowDescLabel.mas_right);
            make.top.equalTo(_lowDescLabel.mas_top);
            make.bottom.equalTo(_lowDescLabel.mas_bottom);
            make.width.equalTo(labelWidth);
            
        }];
        
        //幅 量
        [_changeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_highLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
        }];
        
        [_changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_changeDescLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
            make.width.equalTo(labelWidth);
            
        }];
        
        [_volumeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_changeDescLabel.mas_left);
            make.top.equalTo(_changeDescLabel.mas_bottom);
            make.bottom.equalTo(self);
        }];
        
        [_volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumeDescLabel.mas_right);
            make.top.equalTo(_volumeDescLabel.mas_top);
            make.bottom.equalTo(_volumeDescLabel.mas_bottom);
            make.width.equalTo(labelWidth);
            
        }];


    }
    return self;
}

+(instancetype)view
{
    Y_KLineFollowView *MAView = [[Y_KLineFollowView alloc]init];

    return MAView;
}
-(void)maProfileWithModel:(Y_KLineModel *)model
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.Date.doubleValue/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd";// HH:mm

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.isEable == YES)
    {
        if (self.kLineType == Y_StockKLineType_1Min ||
            self.kLineType == Y_StockKLineType_5Min ||
            self.kLineType == Y_StockKLineType_15Min ||
            self.kLineType == Y_StockKLineType_30Min ||
            self.kLineType == Y_StockKLineType_60Min)
        {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
    }
    
    NSString *dateStr = [formatter stringFromDate:date];
    _dateDescLabel.text = [@" " stringByAppendingString: dateStr];
    
    
    _openLabel.textColor = PLAN_COLOR;
    _highLabel.textColor = PLAN_COLOR;
    _lowLabel.textColor = PLAN_COLOR;
    _closeLabel.textColor = PLAN_COLOR;
    _changeLabel.textColor = PLAN_COLOR;
    _volumeLabel.textColor = PLAN_COLOR;
    
    _openLabel.text = [NSString stringWithFormat:@"%.2f",model.Open.floatValue];
    _highLabel.text = [NSString stringWithFormat:@"%.2f",model.High.floatValue];
    _lowLabel.text = [NSString stringWithFormat:@"%.2f",model.Low.floatValue];
    _closeLabel.text = [NSString stringWithFormat:@"%.2f",model.Close.floatValue];
    
    _volumeLabel.text = [SystemUtil FormatFloatValue:model.Volume dig:2];
    
    float change = 0.0;
    if ([SystemUtil isNotNSnull:model.PreClose] && [SystemUtil isNotNSnull:model.Close])
    {
        change = 100*(model.Close.floatValue - model.PreClose.floatValue)/model.PreClose.floatValue;
    }
    _changeLabel.text =[SystemUtil getPercentage:change];

    
    
    
    if ([SystemUtil isNotNSnull:model.PreClose])
    {
        UIColor *openColor = [SystemUtil getStockUpDownColor:model.Open.floatValue preClose:model.PreClose.floatValue];
        UIColor *highColor = [SystemUtil getStockUpDownColor:model.High.floatValue preClose:model.PreClose.floatValue];
        UIColor *lowColor = [SystemUtil getStockUpDownColor:model.Low.floatValue preClose:model.PreClose.floatValue];
        UIColor *closeColor = [SystemUtil getStockUpDownColor:model.Close.floatValue preClose:model.PreClose.floatValue];
        
        _openLabel.textColor = openColor;
        _highLabel.textColor = highColor;
        _lowLabel.textColor = lowColor;
        _closeLabel.textColor = closeColor;
        
        _changeLabel.textColor = closeColor;
    }
    
//    if([model.Close compare:model.PreClose] == NSOrderedAscending)
//    {
//        _priceLabel.textColor = FALL_COLOR;
//        _amplitudeLabel.textColor = FALL_COLOR;
//
//    }
//    else if([model.Close compare:model.PreClose] == NSOrderedDescending)
//    {
//        _priceLabel.textColor = RISE_COLOR;
//        _amplitudeLabel.textColor = RISE_COLOR;
//
//    }
//    else
//    {
//        _priceLabel.textColor = PLAN_COLOR;
//        _amplitudeLabel.textColor = PLAN_COLOR;
//
//    }

}
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.isEable == YES)
    {
        label.font = [UIFont systemFontOfSize:13];
    }
    else
    {
        label.font = [UIFont systemFontOfSize:12];
    }
    label.textColor = [UIColor assistTextColor];
    [self addSubview:label];
    return label;
}

-(void)showPriceLabel:(BOOL)b
{
//    _dateDescLabel.hidden = !b;
//    
//    _priceDescLabel.hidden = !b;
//    _amplitudeDescLabel.hidden = !b;
//    _volumeDescLabel.hidden = !b;
//    
//    _priceLabel.hidden = !b;
//    _volumeLabel.hidden = !b;
//    _amplitudeLabel.hidden = !b;
}

@end
