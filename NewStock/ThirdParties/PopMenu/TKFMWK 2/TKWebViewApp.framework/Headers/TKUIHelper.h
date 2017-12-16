//
//  TKUIHelper.h
//  ios4
//
//  Created by liubao on 14-10-30.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IOS6_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 6.0f)
#define IOS7_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define IOS8_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define IOS9_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define IOS10_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define IOS11_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

/**
 *  基础UI操作帮助类
 */
@interface TKUIHelper : NSObject

/**
 * 在父窗口中移动子窗口，限制在父窗口区域内。
 *
 *  @param view      窗口
 *  @param srcPoint  起点
 *  @param destPoint 终点
 */
+(void) moveView:(UIView *)view inSuperViewFromPoint:(CGPoint)srcPoint toPoint:(CGPoint)destPoint;

/**
 *  缩放矩形
 *
 *  @param source 原矩形
 *  @param dest   目标矩形
 *
 *  @return 实际缩放后的矩形
 */
+(CGSize) fitSouceSize:(CGSize)source toSize:(CGSize) dest;

/**
 *  颜色转换 IOS中十六进制的颜色转换为UIColor
 *
 *  @param color 16进制字符串
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithHexString:(NSString *)color;

/**
 *  生成颜色
 *
 *  @param r 红色
 *  @param g 绿色
 *  @param b 蓝色
 *
 *  @return 颜色
 */
+ (UIColor *) colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;

/**
 *  设置导航栏的文字，颜色
 *
 *  @param color 颜色
 *  @param size  文字大小
 */
+(void)setUINavigationBarAppearance:(UIColor *)color fontSize:(float)size;

/**
 *  设置所有分割栏的颜色以及文字的颜色
 *
 *  @param selectedColor     选中的颜色
 *  @param normalColor       正常的颜色
 *  @param selectedTextColor 文字选中的颜色
 *  @param normalTextColor   文字正常的颜色
 */
+(void)setAllUISegmentControlAppearance:(UIColor *)selectedColor normalColor:(UIColor *)normalColor selectedTextColor:(UIColor *)selectedTextColor normalColor:(UIColor *)normalTextColor;

/**
 *  设置单个分割栏的颜色以及文字的颜色
 *
 *  @param seg               分割栏组件控制器
 *  @param selectedColor     选中的颜色
 *  @param normalColor       正常的颜色
 *  @param selectedTextColor 文字选中的颜色
 *  @param normalTextColor   文字正常的颜色
 */
+(void)setUISegmentControlAppearance:(UISegmentedControl *)seg selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor selectedTextColor:(UIColor *)selectedTextColor normalColor:(UIColor *)normalTextColor;

/**
 *  清空所有分割栏样式 颜色
 */
+(void)resetAllUISegmentControlAppearance;

@end
