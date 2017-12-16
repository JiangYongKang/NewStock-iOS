//
//  GesturePasswordDelegate.h
//  TKComponent_V1
//
//  Created by liubao on 15-4-13.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-04-13 20:04:56
 *
 *  手势触摸滑动代理
 */
@protocol TKGesturePasswordTouchDelegate <NSObject>

@optional

/**
 *  @Author 刘宝, 2015-04-13 20:04:13
 *
 *  设置手势密码
 *
 *  @param result 结果
 *
 *  @return 
 */
- (BOOL)setPasswordGesture:(NSString *)result;

/**
 *  @Author 刘宝, 2015-04-13 20:04:58
 *
 *  校验手势密码
 *
 *  @param result 结果
 *
 *  @return 
 */
- (BOOL)verifiPasswordGesture:(NSString *)result;

/**
 *  @Author 刘宝, 2015-06-09 21:06:38
 *
 *  取消手势密码
 *
 *  @param result 结果
 *
 *  @return 
 */
- (BOOL)cancelPasswordGesture:(NSString *)result;

/**
 *  @Author 刘宝, 2015-10-30 12:10:54
 *
 *  修改手势密码
 *
 *  @param result 结果
 *
 *  @return 
 */
- (BOOL)resetPasswordGesture:(NSString *)result;

/**
 *  @Author 刘宝, 2016-03-10 16:03:35
 *
 *  返回关闭手势密码
 *
 *  @param result
 *
 *  @return 
 */
- (BOOL)backPasswordGesture:(NSString *)result;

/**
 *  @Author 刘宝, 2015-04-14 09:04:19
 *
 *  手势开始动作
 */
- (void)gestureTouchBegin;

@end
