//
//  UIColor+Y_StockChart.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "UIColor+Y_StockChart.h"
#import "Defination.h"

@implementation UIColor (Y_StockChart)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

#pragma mark 所有图表的背景颜色
+(UIColor *)backgroundColor
{
    //return [UIColor colorWithRGBHex:0x181c20];
    return [UIColor whiteColor];
}

#pragma mark 辅助背景色
+(UIColor *)assistBackgroundColor
{
    //return [UIColor colorWithRGBHex:0x1d2227];
    return [UIColor whiteColor];

}
#pragma mark 边框颜色
+(UIColor *)boarderColor
{
    return [UIColor lightGrayColor];
}

+(UIColor *)dividingColor
{
    return [UIColor colorWithRGBHex:0xd3d3d3];
}

#pragma mark 涨的颜色
+(UIColor *)increaseColor
{
    return [UIColor colorWithRGBHex:0xff1919];//[UIColor colorWithRGBHex:0xff5353];
}

#pragma mark 跌的颜色
+(UIColor *)decreaseColor
{
    return [UIColor colorWithRGBHex:0x009d00];//[UIColor colorWithRGBHex:0x00b07c];
}

#pragma mark 主文字颜色
+(UIColor *)mainTextColor
{
    //return [UIColor colorWithRGBHex:0xe1e2e6];
    return [UIColor colorWithRGBHex:0x333333];//[UIColor darkGrayColor];
}

#pragma mark 辅助文字颜色
+(UIColor *)assistTextColor
{
    return [UIColor colorWithRGBHex:0x565a64];
}

#pragma mark 分时线下面的成交量线的颜色
+(UIColor *)timeLineVolumeLineColor
{
    return [UIColor colorWithRGBHex:0x2d333a];
}

#pragma mark 分时线界面线的颜色
+(UIColor *)timeLineLineColor
{
    return [UIColor colorWithRGBHex:0x49a5ff];
}

#pragma mark 长按时线的颜色
+(UIColor *)longPressLineColor
{
//    return [UIColor colorWithRGBHex:0xff5353];
//    return [UIColor colorWithRGBHex:0xe1e2e6];
    return [UIColor colorWithRGBHex:0x333333];
}

#pragma mark 分时的颜色
+(UIColor *)miniColor
{
    return [UIColor colorWithRGBHex:0x1b69c4];
}

#pragma mark 均线的颜色
+(UIColor *)averColor
{
    return [UIColor colorWithRGBHex:0xf4a738];
}


#pragma mark ma5的颜色
+(UIColor *)ma7Color
{
    return [UIColor colorWithRGBHex:0x808080];
}

#pragma mark ma10的颜色
+(UIColor *)ma12Color
{
    return [UIColor colorWithRGBHex:0xca3fe7];
    //return [UIColor colorWithRGBHex:0xffac4e];
}

#pragma mark ma20的颜色
+(UIColor *)ma26Color
{
    return [UIColor colorWithRGBHex:0xffac4e];
    //return [UIColor colorWithRGBHex:0xca3fe7];
}

#pragma mark ma30颜色
+(UIColor *)ma30Color
{
    return [UIColor colorWithRGBHex:0x0071e1];
    //return [UIColor colorWithRGBHex:0x00e500];
}

#pragma mark btn选中颜色
+(UIColor *)btnSelectedColor
{
    return [UIColor colorWithRGBHex:0x358ee7];//[UIColor whiteColor];
}
@end
