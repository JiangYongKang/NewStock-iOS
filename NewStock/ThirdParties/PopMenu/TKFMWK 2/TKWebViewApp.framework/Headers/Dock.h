//
//  Dock.h
//
//
//  Created by Louis on 14-6-20.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DockItem.h"

@class Dock;

/**
 *  @Author 刘宝, 2015-05-05 22:05:01
 *
 *  代理类
 */
@protocol DockDelegate <NSObject>

@optional
/**
 *  @Author 叶璐, 2014-12-24 00:12:37
 *
 *  代理事件：通知Item选择发生变化
 *
 *  @param dock               Dock控件
 *  @param lastItemIndex      上一个选中的Item索引
 *  @param currentItemIndex   当前选中的Item索引
 *
 *  @return
 */
- ( void )itemSelected:(Dock *)dock fromItemIndex:(NSInteger)lastItemIndex toItemIndex:(NSInteger)currentItemIndex;

@end

/**
 *  @Author 叶璐, 2014-12-24 00:12:37
 *
 *  创建类似UITabBar的控件
 */
@interface Dock : UIScrollView

/**
 *  @Author 刘宝, 2015-05-05 21:05:29
 *
 *  代理对象
 */
@property (weak, nonatomic) id<DockDelegate> dockDelegate;

/**
 *  @Author 刘宝, 2015-05-05 21:05:50
 *
 *  选中的索引
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 *  @Author 刘宝, 2015-05-05 21:05:52
 *
 *  DockItem按钮组
 */
@property (nonatomic,retain) NSArray *items;

/**
 *  @Author 刘宝, 2015-05-05 22:05:39
 *
 *  选中的对象
 */
@property (nonatomic,retain) DockItem *selectedItem;

/**
 *  @Author 刘宝, 2015-05-05 22:05:51
 *
 *  文字颜色
 */
@property (nonatomic,retain) UIColor *textColor;

/**
 *  @Author 刘宝, 2015-05-05 22:05:08
 *
 *  文字选中的颜色
 */
@property (nonatomic,retain) UIColor *selectedTextColor;

/**
 *  @Author 刘宝, 2015-05-05 22:05:43
 *
 *  字体
 */
@property (nonatomic,assign)UIFont *font;

/**
 *  @Author 刘宝, 2015-05-07 10:05:22
 *
 *  最大显示的个数
 */
@property (nonatomic,assign)NSInteger maxShowNum;

/**
 *  @Author 刘宝, 2015-05-05 22:05:40
 *
 *  初始化
 *
 *  @param frame 区域
 *  @param items 按钮组
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame items:(NSArray *)items;

/**
 *  @Author 叶璐, 2014-12-24 00:12:37
 *
 *  添加新的Item，在Dock内部会自动调节Item间距
 *
 *  @param iconName           Item常态图片
 *  @param selectedIconName   Item选中图片
 *  @param lableTitle         Item 文字
 *
 *  @return
 */
- (void )addItemWithIcon:(NSString *)iconName selectedIcon:(NSString *)selectedIconName lableTitle:(NSString *)lableTitle;

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


/**
 *  @author 刘宝, 2016-09-07 22:09:46
 *
 *  扩展tabbar
 */
@interface UITabBar(DockItem)

@end