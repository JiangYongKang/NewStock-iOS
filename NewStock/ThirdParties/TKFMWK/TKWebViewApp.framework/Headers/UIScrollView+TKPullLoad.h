//
//  UIScrollView+PullLoad.h
//  UIScrollViewCatergory
//
//  Created by 徐 传勇 on 13-2-18.
//  Copyright (c) 2013年 徐 传勇. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  上下拉枚举
 */
typedef enum
{
    TKPullNone,
    TKPullDown,
    TKPullUp
} TKPullUpOrDown;

/**
 *  上下拉刷新委托协议
 */
@protocol TKPullUpDownDelegate <NSObject>

/**
 *  @Author 刘宝, 2015-01-30 11:01:35
 *
 *  下拉刷新数据
 *
 *  @param isDESCOrder 排序
 */
-(void)pullDownRefreshIsDESCOrder:(BOOL)isDESCOrder;

/**
 *  @Author 刘宝, 2015-01-30 13:01:38
 *
 *  上拉加载更多
 *
 *  @param rowofPage   总共要显示的数据条数
 *  @param isDESCOrder 排序方向
 */
-(void)pullUpGetData:(NSInteger)rowofPage isDESCOrder:(BOOL)isDESCOrder;

/**
 *  @Author 刘宝, 2015-01-30 13:01:23
 *
 *  跳转页面
 *
 *  @param data
 */
-(void)doJump:(id)data;

@end

/**
 下拉上拉加载状态
 */
typedef enum
{
    /**
     *  @Author 刘宝, 2015-01-30 13:01:14
     *
     *  上拉加载状态
     */
    TKPullUpLoadState,
    /**
     *  @Author 刘宝, 2015-01-30 13:01:25
     *
     *  下拉加载状态
     */
    TKPullDownLoadState,
}TKLoadState;

/**
 *  @Author 刘宝, 2015-01-30 13:01:54
 *
 *  拖拽刷新代理
 */
@protocol TKPullDelegate <NSObject>
@optional

/**
 *  @Author 刘宝, 2015-01-30 13:01:47
 *
 *  拖拽触发函数
 *
 *  @param scrollView 滚动组件
 *  @param state      状态
 */
- (void)scrollView:(UIScrollView*)scrollView loadWithState:(TKLoadState)state;

@end

/**
 *  @Author 刘宝, 2015-01-30 13:01:19
 *
 *  带有拖拽刷新的UIScrollView扩展
 */
@interface UIScrollView (TKPullLoad)

/**
 *  @Author 刘宝, 2015-01-30 14:01:48
 *
 *  是否可以上拉
 */
@property (assign,nonatomic) BOOL canPullUp;

/**
 *  @Author 刘宝, 2015-01-30 14:01:01
 *
 *  是否可以下拉
 */
@property (assign,nonatomic) BOOL canPullDown;

/**
 *  @Author 刘宝, 2015-01-30 13:01:39
 *
 *  可不设置代理，但如需要设置代理，需要在设置是否上下拉之前设置，否则无效
 *  拖拽完成需要更新时会调用代理回调函数
 */
@property (weak,nonatomic) id <TKPullDelegate> pullDelegate;

/**
 *  @Author 刘宝, 2015-01-30 14:01:49
 *
 *  加载完成后外部调用停止加载状态
 *
 *  @param state 状态
 */
- (void)stopLoadWithState:(TKLoadState)state;

/**
 *  @Author 刘宝, 2015-01-30 14:01:08
 *
 *  设置加载视图背景颜色
 *
 *  @param color 颜色
 */
- (void)setRefreshViewColor:(UIColor*)color;

/**
 *  @Author 刘宝, 2015-01-30 14:01:37
 *
 *  设置加载视图文字颜色
 *
 *  @param color 颜色
 */
- (void)setRefreshViewTextColor:(UIColor *)color;

/**
 *  @Author 刘宝, 2015-01-30 14:01:59
 *
 *  设置转圈风格
 *
 *  @param style 加载的样式
 */
- (void)setActivityStyle:(UIActivityIndicatorViewStyle)style;

/**
 *  @Author 刘宝, 2015-10-10 10:10:40
 *
 *  自动下拉
 */
- (void)autoPullDown;

@end
