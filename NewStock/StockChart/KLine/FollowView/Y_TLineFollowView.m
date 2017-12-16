//
//  Y_KLineMAView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_TLineFollowView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
#import "Y_KLineModel.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

@interface Y_TLineFollowView ()

@property (strong, nonatomic) UILabel *dateDescLabel;



@property (strong, nonatomic) UILabel *priceDescLabel;

@property (strong, nonatomic) UILabel *amplitudeDescLabel;

@property (strong, nonatomic) UILabel *volumeDescLabel;



@property (strong, nonatomic) UILabel *priceLabel;

@property (strong, nonatomic) UILabel *amplitudeLabel;

@property (strong, nonatomic) UILabel *volumeLabel;


@end

@implementation Y_TLineFollowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dateDescLabel = [self private_createLabel];
        
        
        _priceDescLabel = [self private_createLabel];
        _priceDescLabel.text = @"价:";//开

        _amplitudeDescLabel = [self private_createLabel];
        _amplitudeDescLabel.text = @"幅:";//收

        _volumeDescLabel = [self private_createLabel];
        _volumeDescLabel.text = @"量:";//高

       

        _priceLabel = [self private_createLabel];
        _amplitudeLabel = [self private_createLabel];
        _volumeLabel = [self private_createLabel];
        
        
        _priceLabel.textColor = [UIColor assistTextColor];
        _volumeLabel.textColor = [UIColor assistTextColor];
        _amplitudeLabel.textColor = [UIColor assistTextColor];
        
//        NSNumber *labelWidth = [NSNumber numberWithInt:30];
        
        [_dateDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self);
            make.height.equalTo(self.mas_height);
            make.width.equalTo(self.mas_width).multipliedBy(0.2);

        }];
        
        [_priceDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_dateDescLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
        }];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_priceDescLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
            make.width.equalTo(self.mas_width).multipliedBy(0.2);
 
        }];
        
        [_volumeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_priceLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
        }];
        
        [_volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumeDescLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
            make.width.equalTo(self.mas_width).multipliedBy(0.23);

        }];
        
        
        [_amplitudeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumeLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
        }];
        
        [_amplitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_amplitudeDescLabel.mas_right);
            make.top.equalTo(_dateDescLabel.mas_top);
            make.bottom.equalTo(_dateDescLabel.mas_bottom);
            make.width.equalTo(self.mas_width).multipliedBy(0.2);

        }];
        
        
    }
    return self;
}

+(instancetype)view
{
    Y_TLineFollowView *MAView = [[Y_TLineFollowView alloc]init];

    return MAView;
}
-(void)maProfileWithModel:(Y_KLineModel *)model
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.Date.doubleValue/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm";//@"yyyy-MM-dd";// HH:mm
    NSString *dateStr = [formatter stringFromDate:date];
    _dateDescLabel.text = [@" " stringByAppendingString: dateStr];
    
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",model.Close.floatValue];
    _volumeLabel.text = [SystemUtil FormatFloatValue:model.Volume dig:2];
    
    
    if (model.PreClose.floatValue>0)
    {
        float amp = 100*(model.Close.floatValue-model.PreClose.floatValue)/model.PreClose.floatValue;
        if (amp>0.000001) {
            amp+=0.005;
        }
        else if(amp<-0.000001)
        {
            amp-=0.005;
        }
            
        _amplitudeLabel.text = [SystemUtil getPercentage:amp];
    }
    else
    {
        _amplitudeLabel.text = @"--";
    }
 
    
    if([model.Close compare:model.PreClose] == NSOrderedAscending)
    {
        _priceLabel.textColor = FALL_COLOR;
        _amplitudeLabel.textColor = FALL_COLOR;

    }
    else if([model.Close compare:model.PreClose] == NSOrderedDescending)
    {
        _priceLabel.textColor = RISE_COLOR;
        _amplitudeLabel.textColor = RISE_COLOR;

    }
    else
    {
        _priceLabel.textColor = PLAN_COLOR;
        _amplitudeLabel.textColor = PLAN_COLOR;

    }
    //_amplitudeLabel.textColor = PLAN_COLOR;

}
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor assistTextColor];
    [self addSubview:label];
    return label;
}

-(void)showPriceLabel:(BOOL)b
{
    _dateDescLabel.hidden = !b;
    
    _priceDescLabel.hidden = !b;
    _amplitudeDescLabel.hidden = !b;
    _volumeDescLabel.hidden = !b;
    
    _priceLabel.hidden = !b;
    _volumeLabel.hidden = !b;
    _amplitudeLabel.hidden = !b;
}

@end
