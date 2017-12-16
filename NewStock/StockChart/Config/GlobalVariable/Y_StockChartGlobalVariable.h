//
//  Y_StockChartGlobalVariable.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_StockChartConstant.h"
@interface Y_StockChartGlobalVariable : NSObject

/**
 *  K线图的宽度，默认20
 */
+(CGFloat)kLineWidth;

+(void)setkLineWith:(CGFloat)kLineWidth;

/**
 *  K线图的间隔，默认1
 */
+(CGFloat)kLineGap;

+(void)setkLineGap:(CGFloat)kLineGap;


/**
 *  T线图的宽度，默认20
 */
+(CGFloat)tLineWidth;

+(void)settLineWith:(CGFloat)tLineWidth;

/**
 *  T线图的间隔，默认1
 */
+(CGFloat)tLineGap;

+(void)settLineGap:(CGFloat)tLineGap;


/**
 *  MainView的高度占比,默认为0.5
 */
+ (CGFloat)kLineMainViewRadio;
+ (void)setkLineMainViewRadio:(CGFloat)radio;

/**
 *  VolumeView的高度占比,默认为0.2
 */
+ (CGFloat)kLineVolumeViewRadio;
+ (void)setkLineVolumeViewRadio:(CGFloat)radio;


/**
 *  5档的宽度占比,默认为0.33
 */
+ (CGFloat)fifthPosViewRadio;
+ (void)setFifthPosViewRadio:(CGFloat)radio;

/**
 *  5档的宽度,默认为
 */
+ (CGFloat)fifthPosViewWidth;
+ (void)setFifthPosViewWidth:(CGFloat)width;

/**
 *  isEMA线
 */
+ (CGFloat)isEMALine;
+ (void)setisEMALine:(Y_StockChartTargetLineStatus)type;
@end
