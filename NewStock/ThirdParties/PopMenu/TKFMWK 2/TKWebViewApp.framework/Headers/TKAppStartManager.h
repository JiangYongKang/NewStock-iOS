//
//  TKAppStartManager.h
//  TKAppBase_V1
//
//  Created by liubao on 15-6-5.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-06-05 19:06:44
 *
 *  加载完成回调
 */
typedef void(^FinishAppLaunch)();

/**
 *  @Author 刘宝, 2015-06-05 19:06:40
 *
 *  启动界面管理器，用来实现启动展示图，启动广告图，启动导航页等
 */
@interface TKAppStartManager : NSObject

/**
 *  @Author 刘宝, 2015-06-05 19:06:59
 *
 *  加载完成回调
 */
@property (nonatomic,strong)FinishAppLaunch finishLaunch;

/**
 *  @Author 刘宝, 2015-06-05 20:06:43
 *
 *  内容界面
 */
@property (nonatomic,readonly) UIView *contentView;

/**
 *  @Author 刘宝, 2015-05-04 13:05:39
 *
 *  单例模式
 *
 *  @return
 */
+(TKAppStartManager *)shareInstance;

/**
 *  @Author 刘鹏民, 15-05-13 13:05:13
 *
 *  加载App启动插画,保持与启动时效果的一致,自动匹配iPhone 5尺寸的启动图片,
 *  请在首个Controller的viewWillAppear里面执行
 */
- (void)launch;

/**
 *  @Author 刘鹏民, 15-05-13 13:05:15
 *
 *  加载广告闪屏等组件
 *
 *  @param view
 */
- (void)launch:(UIView *)view;

/**
 *  @Author 刘鹏民, 15-05-13 13:05:33
 *
 *  加载广告闪屏等组件，并设定自动消失的时间
 *
 *  @param view
 *  @param delay
 */
- (void)launch:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

/**
 *  @Author 刘宝, 2015-06-08 10:06:20
 *
 *  加载启动导航页
 *
 *  @param views               导航页组件
 */
- (void)launchStartPage:(NSArray *)views;

/**
 *  @Author 刘宝, 2015-06-08 10:06:20
 *
 *  加载启动导航页
 *
 *  @param views               导航页组件
 *  @param showPageIndicator 是否显示翻页标签
 */
- (void)launchStartPage:(NSArray *)views showPageIndicator:(BOOL)showPageIndicator;

/**
 *  @Author 刘宝, 2015-06-08 10:06:20
 *
 *  加载启动导航页
 *
 *  @param views               导航页组件
 *  @param showPageIndicator  是否显示翻页标签
 *  @param invTime            间隔时间
 */
- (void)launchStartPage:(NSArray *)views showPageIndicator:(BOOL)showPageIndicator invTime:(float)invTime;

/**
 *  @Author 刘宝, 2015-06-08 10:06:20
 *
 *  加载启动导航页
 *
 *  @param views               导航页组件
 *  @param showPageIndicator   是否显示翻页标签
 *  @param invTime             间隔时间
  * @param scrollEnable        是否支持手动滚动
 */
- (void)launchStartPage:(NSArray *)views showPageIndicator:(BOOL)showPageIndicator invTime:(float)invTime scrollEnable:(BOOL)scrollEnable;

/**
 *  @Author 刘鹏民, 15-05-13 13:05:09
 *
 *  以默认动画效果隐藏启动界面
 *
 *  @param animated
 */
- (void)hide:(BOOL)animated;

/**
 *  @Author 刘鹏民, 15-05-13 13:05:35
 *
 *  以默认动画效果隐藏启动界面，延迟执行
 *
 *  @param animated
 *  @param delay
 */
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
