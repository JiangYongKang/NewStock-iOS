//
//  TKTabBarViewController.h
//  TKApp
//
//  Created by liupm on 15/5/7.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

@protocol TKTabBarViewControllerDelegate <NSObject>

/**
 *  @Author 刘宝, 2015-08-28 17:08:03
 *
 *  是否允许跳转
 *
 *  @param fromViewCtrl 来源控制器
 *  @param toViewCtrl  目标控制器
 *
 *  @return
 */
-(BOOL)tabBarController:(UITabBarController *)tabBarViewCtrl shouldChangeTabFrom:(UIViewController *)fromViewCtrl to:(UIViewController *)toViewCtrl;

@end

/**
 *  @Author 刘宝, 2015-05-07 12:05:05
 *
 *  自定义TabBar控制器
 */
@interface TKTabBarViewController : UITabBarController

/**
 *  @Author 刘宝, 2015-08-28 17:08:21
 *
 *  代理
 */
@property(nonatomic,weak)id<TKTabBarViewControllerDelegate> tkTabBarDelegate;

/**
 *  @Author 刘宝, 2015-05-07 12:05:08
 *
 *  按钮组
 */
@property (nonatomic,strong) NSArray *items;

/**
 *  @Author 刘宝, 2015-05-07 12:05:25
 *
 *  tabbar样式
 */
@property(nonatomic,strong) NSString *dockCss;

/**
 *  @Author 刘宝, 2015-10-30 20:10:04
 *
 *  是否隐藏分割线
 */
@property(nonatomic,assign) BOOL isHiddenSegLine;

/**
 *  @Author 刘宝, 2015-11-03 20:11:57
 *
 *  修改分割线的颜色
 */
@property(nonatomic,retain)UIColor *segLineColor;

/**
 *  @Author 刘宝, 2015-09-18 00:09:15
 *
 *  设置指定item的角标
 *
 *  @param badge 值
 *  @param index 索引
 */
- (void) setItemBadge:(NSString *)badge forIndex:(NSInteger )index;

@end
