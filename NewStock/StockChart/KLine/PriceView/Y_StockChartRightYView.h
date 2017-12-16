//
//  Y_StockChartRightYView.h
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Y_StockChartRightYView : UIView

@property(nonatomic,assign) int type;

@property(nonatomic,assign) CGFloat maxValue;

@property(nonatomic,assign) CGFloat middleValue;

@property(nonatomic,assign) CGFloat minValue;

@property(nonatomic,copy) NSString *minLabelText;


-(void)setUp:(NSString *)up;
-(void)setDown:(NSString *)down;
-(void)setPlan:(NSString *)plan;

-(void)setAlignment:(NSTextAlignment)textAlignment;
@end
