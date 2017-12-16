//
//  TKDirectionPanGestureRecognizer.h
//  TKApp
//
//  Created by liupm on 15-4-20.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

/**
 手势方向
 */
typedef enum
{
    /**
     *  @Author 刘宝, 2015-04-26 23:04:06
     *
     *  垂直方向
     */
    DirectionPangestureRecognizerVertical,
    /**
     *  @Author 刘宝, 2015-04-26 23:04:21
     *
     *  水平方向
     */
    DirectionPanGestureRecognizerHorizontal
} DirectionPangestureRecognizerDirection;

/**
 *  @Author 刘宝, 2015-04-26 23:04:33
 *
 *  手势方向容器,滑动切换
 */
@interface TKDirectionPanGestureRecognizer : UIPanGestureRecognizer

/**
 *  @Author 刘宝, 2015-04-26 23:04:24
 *
 *  手势方向
 */
@property (nonatomic, assign) DirectionPangestureRecognizerDirection direction;

/**
 *  @Author 刘宝, 2015-08-24 20:08:39
 *
 *  滑动方向,YES:向左滑动，向下滑动，NO:向右滑动，向上滑动
 */
@property (nonatomic,assign)BOOL directionFlag;

/**
 *  @Author 刘宝, 2015-08-24 20:08:58
 *
 *  滑动距离
 */
@property (nonatomic,assign)float kDirectionPanThreshold;

/**
 *  @Author 刘宝, 2015-04-26 23:04:55
 *
 *  是否拖动生效
 */
@property (nonatomic,readonly)BOOL draged;

@end
