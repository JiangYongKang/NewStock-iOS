//
//  Y_StockChartGlobalVariable.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//
#import "Y_StockChartGlobalVariable.h"

/**
 *  K线图的宽度，默认20
 */
static CGFloat Y_StockChartKLineWidth = 5;

/**
 *  K线图的间隔，默认1
 */
static CGFloat Y_StockChartKLineGap = 1;

/**
 *  T线图的宽度，默认2
 */
static CGFloat Y_StockChartTLineWidth = 1;

/**
 *  T线图的间隔，默认0
 */
static CGFloat Y_StockChartTLineGap = 0;


/**
 *  MainView的高度占比,默认为0.6
 */
static CGFloat Y_StockChartKLineMainViewRadio = 0.68;

/**
 *  VolumeView的高度占比,默认为0.3
 */
static CGFloat Y_StockChartKLineVolumeViewRadio = 0.30;

/**
 *  5档行情宽度占比
 */
static CGFloat X_FifthPositionViewRadio = 0.33;


/**
 *  5档行情宽度
 */
static CGFloat X_FifthPositionViewWidth = 115;

/**
 *  是否为EMA线
 */
static Y_StockChartTargetLineStatus Y_StockChartKLineIsEMALine = Y_StockChartTargetLineStatusMA;


@implementation Y_StockChartGlobalVariable

/**
 *  K线图的宽度，默认20
 */
+(CGFloat)kLineWidth
{
    return Y_StockChartKLineWidth;
}
+(void)setkLineWith:(CGFloat)kLineWidth
{
    if (kLineWidth > Y_StockChartKLineMaxWidth) {
        kLineWidth = Y_StockChartKLineMaxWidth;
    }else if (kLineWidth < Y_StockChartKLineMinWidth){
        kLineWidth = Y_StockChartKLineMinWidth;
    }
    Y_StockChartKLineWidth = kLineWidth;
}


/**
 *  K线图的间隔，默认1
 */
+(CGFloat)kLineGap
{
    return Y_StockChartKLineGap;
}

+(void)setkLineGap:(CGFloat)kLineGap
{
    Y_StockChartKLineGap = kLineGap;
}


/**
 *  T线图的宽度，默认20
 */
+(CGFloat)tLineWidth
{
    return Y_StockChartTLineWidth;
}
+(void)settLineWith:(CGFloat)tLineWidth
{
    if (tLineWidth > Y_StockChartKLineMaxWidth) {
        tLineWidth = Y_StockChartKLineMaxWidth;
    }else if (tLineWidth < Y_StockChartKLineMinWidth){
        tLineWidth = Y_StockChartKLineMinWidth;
    }
    Y_StockChartTLineWidth = tLineWidth;
}


/**
 *  T线图的间隔，默认1
 */
+(CGFloat)tLineGap
{
    return Y_StockChartTLineGap;
}

+(void)settLineGap:(CGFloat)tLineGap
{
    Y_StockChartTLineGap = tLineGap;
}


/**
 *  MainView的高度占比,默认为0.6
 */
+ (CGFloat)kLineMainViewRadio
{
    return Y_StockChartKLineMainViewRadio;
}
+ (void)setkLineMainViewRadio:(CGFloat)radio
{
    Y_StockChartKLineMainViewRadio = radio;
}

/**
 *  VolumeView的高度占比,默认为0.3
 */
+ (CGFloat)kLineVolumeViewRadio
{
    return Y_StockChartKLineVolumeViewRadio;
}
+ (void)setkLineVolumeViewRadio:(CGFloat)radio
{
    Y_StockChartKLineVolumeViewRadio = radio;
}

/**
 *  5档的宽度占比,默认为0.33
 */
+ (CGFloat)fifthPosViewRadio
{
    return X_FifthPositionViewRadio;
}
+ (void)setFifthPosViewRadio:(CGFloat)radio
{
    X_FifthPositionViewRadio = radio;
}

/**
 *  5档的宽度,默认为
 */
+ (CGFloat)fifthPosViewWidth
{
    return X_FifthPositionViewWidth;
}
+ (void)setFifthPosViewWidth:(CGFloat)width
{
    X_FifthPositionViewWidth = width;
}

/**
 *  isEMA线
 */

+ (CGFloat)isEMALine
{
    return Y_StockChartKLineIsEMALine;
}
+ (void)setisEMALine:(Y_StockChartTargetLineStatus)type
{
    Y_StockChartKLineIsEMALine = type;
}
@end
