//
//  Y_KLineFollowView.h
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_StockChartConstant.h"

@class Y_KLineModel;
@interface Y_KLineFollowView : UIView


/**
 *  线类型
 */
@property (nonatomic, assign) Y_StockKLineType kLineType;


+(instancetype)view;

-(void)maProfileWithModel:(Y_KLineModel *)model;

-(void)showPriceLabel:(BOOL)b;

@end
