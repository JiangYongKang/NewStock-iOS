//
//  ViewPagerController.h
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKBaseViewController.h"

typedef NS_ENUM(NSUInteger, ViewPagerOption)
{
    ViewPagerOptionTabHeight,
    ViewPagerOptionTabOffset,
    ViewPagerOptionTabWidth,
    ViewPagerOptionTabLocation,
    ViewPagerOptionTabTopLineHeight,
    ViewPagerOptionTabButtomLineHeight,
    ViewPagerOptionStartFromSecondTab,
    ViewPagerOptionCenterCurrentTab,
    ViewPagerOptionIndicatorWidth,
    ViewPagerOptionIndicatorHeight,
    ViewPagerOptionIndicatorPostion
};

typedef NS_ENUM(NSUInteger, ViewPagerComponent)
{
    ViewPagerIndicator,
    ViewPagerIndicatorLine,
    ViewPagerTabsView,
    ViewPagerContent,
    ViewPagerCurrentTab,
    ViewPagerCurrentTabText
};

/**
 *  @Author 刘宝, 2015-04-27 15:04:49
 *
 *  数据源代理类
 */
@protocol TKGesturePagerDataSourceDelegate;

/**
 *  @Author 刘宝, 2015-04-27 15:04:58
 *
 *  滑动翻页动作代理类
 */
@protocol TKGesturePagerDelegate;

/**
 *  @Author 刘宝, 2015-04-27 15:04:25
 *
 *  滑动翻页控制器
 */
@interface TKGesturePagerController : TKBaseViewController

/**
 *  @Author 刘宝, 2015-04-27 15:04:19
 *
 *  数据源的代理
 */
@property(nonatomic,weak) id<TKGesturePagerDataSourceDelegate> dataSourceDelegate;

/**
 *  @Author 刘宝, 2015-04-27 15:04:42
 *
 *  滑动翻页的代理
 */
@property(nonatomic,weak) id<TKGesturePagerDelegate> delegate;

/**
 *  @Author 刘宝, 2015-06-12 19:06:36
 *
 *  是否启动滚动
 */
@property (nonatomic,assign)BOOL scrollEnable;

/**
 *  @Author 刘宝, 2015-12-14 18:12:31
 *
 *  是否可以点击
 */
@property (nonatomic,assign)BOOL isTabClickEnable;

/**
 *  @Author 刘宝, 2015-04-20 21:04:54
 *
 *  设置无效的滑动区域
 */
@property (nonatomic,assign)CGRect disEnabledFrame;

#pragma mark ViewPagerOptions
@property(nonatomic,assign) CGFloat indicatorHeight;

@property(nonatomic,assign) CGFloat indicatorWidth;

@property(nonatomic,assign)TKTabViewIndicatorPosition indicatorPostion;

// Tab bar's height, defaults to 49.0
@property(nonatomic,assign) CGFloat tabHeight;
// Tab bar's offset from left, defaults to 56.0
@property(nonatomic,assign) CGFloat tabOffset;
// Any tab item's width, defaults to 128.0. To-do: make this dynamic
@property(nonatomic,assign) CGFloat tabWidth;

// 1.0: Top, 0.0: Bottom, changes tab bar's location in the screen
// Defaults to Top
@property(nonatomic,assign) CGFloat tabLocation;

@property(nonatomic,assign) CGFloat tabTopLineHieght;

@property(nonatomic,assign) CGFloat tabButtomLineHieght;

// 1.0: YES, 0.0: NO, defines if view should appear with the second or the first tab
// Defaults to NO
@property(nonatomic,assign) CGFloat startFromSecondTab;

// 1.0: YES, 0.0: NO, defines if tabs should be centered, with the given tabWidth,2.0必要时候移动
// Defaults to NO
@property(nonatomic,assign) CGFloat centerCurrentTab;

#pragma mark Colors
// Colors for several parts
@property(nonatomic,retain) UIColor *indicatorColor;
@property(nonatomic,retain) UIColor *indicatorLineColor;
@property(nonatomic,retain) UIColor *tabsViewBackgroundColor;
@property(nonatomic,retain) UIColor *contentViewBackgroundColor;
@property(nonatomic,retain) UIColor *currentTabSelectedColor;
@property(nonatomic,retain) UIColor *currentTabNormalColor;
@property(nonatomic,retain) UIColor *currentTabSelectedTextColor;
@property(nonatomic,retain) UIColor *currentTabNormalTextColor;

/**
 *  @author 刘宝, 2016-10-19 02:10:43
 *
 *  顶部栏的位置
 */
@property(nonatomic,assign)CGRect tabsViewFrame;
@property(nonatomic,retain) NSMutableArray *tabs;

#pragma mark Methods
// Reload all tabs and contents
- (void)reloadData;

/**
 *  @Author 刘宝, 2015-06-12 22:06:37
 *
 *  切换tab
 */
-(void)changeTab:(NSUInteger )index;

/**
 *  @Author 刘宝, 2015-06-13 00:06:03
 *
 *  索引
 *
 *  @param viewController
 *
 *  @return
 */
- (NSUInteger)indexForViewController:(UIViewController *)viewController;
@end

#pragma mark dataSource
@protocol TKGesturePagerDataSourceDelegate<NSObject>

// Asks dataSource how many tabs will be
- (NSUInteger)numberOfTabsForViewPager:(TKGesturePagerController *)viewPager;
// Asks dataSource to give a view to display as a tab item
// It is suggested to return a view with a clearColor background
// So that un/selected states can be clearly seen
- (UIView *)viewPager:(TKGesturePagerController *)viewPager viewForTabAtIndex:(NSUInteger)index;

@optional
// The content for any tab. Return a view controller and ViewPager will use its view to show as content
- (UIViewController *)viewPager:(TKGesturePagerController*)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;

- (UIView *)viewPager:(TKGesturePagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

@end

#pragma mark delegate
@protocol TKGesturePagerDelegate <NSObject>

@optional
// delegate object must implement this method if wants to be informed when a tab changes
- (void)viewPager:(TKGesturePagerController *)viewPager didChangeTabToIndex:(NSUInteger)index;
// Every time - reloadData called, ViewPager will ask its delegate for option values
// So you don't have to set options from ViewPager itself
- (CGFloat)viewPager:(TKGesturePagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value;
/*
 * Use this method to customize the look and feel.
 * viewPager will ask its delegate for colors for its components.
 * And if they are provided, it will use them, otherwise it will use default colors.
 * Also not that, colors for tab and content views will change the tabView's and contentView's background 
 * (you should provide these views with a clearColor to see the colors),
 * and indicator will change its own color.
 */
- (UIColor *)viewPager:(TKGesturePagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color;

/**
 *  @Author 刘宝, 2015-10-16 14:10:30
 *
 *  重新计算各个TabItemWidth
 *
 *  @param viewPager 翻页组件
 *  @param index 索引
 *
 *  @return
 */
- (CGFloat)viewPagerTabItemWidth:(TKGesturePagerController *)viewPager forIndex:(NSInteger)index;

@end
