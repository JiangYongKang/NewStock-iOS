//
//  UIView+Theme.h
//  TKAppBase_V1
//
//  Created by liubao on 15-5-4.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @Author 刘宝, 2015-05-04 10:05:08
 *
 *  扩展基础UI元素支持样式
 */
@interface UIView (TKTheme)

/**
 *  @Author 刘宝, 2015-05-04 02:05:35
 *
 *  为界面UI绑定默认全局样式
 *
 */
- (void)addCss;

/**
 *  @Author 刘宝, 2015-05-04 02:05:22
 *
 *  为界面UI绑定样式类
 *
 *  @param cssClass 样式类名称
 */
-(void)addCssClass:(NSString *)cssClass;

/**
 *  @Author 刘宝, 2015-05-04 02:05:07
 *
 *  为界面元素绑定样式ID
 *
 *  @param cssId 样式Id名称
 */
-(void)addCssId:(NSString *)cssId;

/**
 *  @Author 刘宝, 2015-05-04 10:05:38
 *
 *  删除当前的UI元素样式类
 */
- (void)removeCssClass:(NSString*)cssClass;

/**
 *  @Author 刘宝, 2015-05-04 02:05:54
 *
 *  刷新当前UI元素样式
 */
-(void)refreshCss;

/**
 *  @Author 刘宝, 2015-05-04 10:05:25
 *
 *  删除当前UI元素所有的样式
 */
-(void)removeCss;

@end
