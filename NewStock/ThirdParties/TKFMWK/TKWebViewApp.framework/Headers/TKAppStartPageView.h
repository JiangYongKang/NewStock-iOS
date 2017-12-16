//
//  TKAPPStartPageView.h
//  TKAppBase_V1
//
//  Created by liubao on 15-6-8.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-06-08 09:06:17
 *
 *  引导页控件
 */
@interface TKAppStartPageView : UIView<UIScrollViewDelegate>

/**
 *  @Author 刘宝, 2015-06-08 10:06:48
 *
 *  引导页内容
 */
@property (nonatomic,strong)NSArray *pageViews;

/**
 *  @Author 刘宝, 2015-06-08 10:06:43
 *
 *  是否显示翻页标签
 */
@property (nonatomic,assign)BOOL showPageIndicator;

/**
 *  @author 刘宝, 2016-05-03 20:05:01
 *
 *  间隔时间
 */
@property(nonatomic,assign)float invTime;

/**
 *  @author 刘宝, 2016-05-19 18:05:40
 *
 *  是否支持手工滚动翻页，默认是支持，可以禁止设置为NO
 */
@property(nonatomic,assign)BOOL scrollEnabled;

@end
