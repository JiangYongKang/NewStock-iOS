//
//  ScreenAdaptation.m
//  YZLoan
//
//  Created by css on 16/3/25.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "ScreenAdaptation.h"

@implementation ScreenAdaptation
static double autoSizeScaleX;
static double autoSizeScaleY;
static double fontSize;
void load()
{
    //获取屏幕大小
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    if (size.height == 480 && size.width == 320) {
        autoSizeScaleX = 1;
        autoSizeScaleY = 1;
    }
    //如果不是iPhone5和5s
    else if(size.height < 568 || size.height > 568){
        autoSizeScaleX = size.width/320;
        autoSizeScaleY = size.height/568;
    }
    else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    if (size.width > 320 && size.width <= 375) {
        fontSize = 2;
    }else if (size.width > 375 ){
        fontSize = 2;
    }else {
        fontSize = 0;
    
    }
       
}

CGRect CGRectMakeEx(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    load();
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}


CGSize CGSizeMakeEx(CGFloat width, CGFloat height)
{
    load();
    CGSize size2;
    size2.width = autoSizeScaleX * width;
    size2.height = autoSizeScaleY * height;
    return size2;
}
CGPoint CGPointMakeEx(CGFloat x, CGFloat y)
{
    load();
    CGPoint point;
    point.x = autoSizeScaleX * x;
    point.y = autoSizeScaleY * y;
    return point;
}
//适配高度
double heightEx(double height)
{
    load();
    return height * autoSizeScaleY;
}
//适配宽度
double widthEx(double width)
{
    load();
    return width * autoSizeScaleX;
}
double FontEx(double size) {
    load();
    return size + fontSize;
}
@end
