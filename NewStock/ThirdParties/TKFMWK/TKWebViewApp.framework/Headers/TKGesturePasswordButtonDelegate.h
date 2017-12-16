//
//  GesturePasswordDelegate.h
//  TKComponent_V1
//
//  Created by liubao on 15-4-14.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-04-14 10:04:50
 *
 *  手势密码业务代理
 */
@protocol TKGesturePasswordButtonDelegate <NSObject>

@optional

/**
 *  @Author 刘宝, 2015-04-14 10:04:02
 *
 *  忘记手势密码
 */
- (void)forgetPassword;

/**
 *  @Author 刘宝, 2015-04-14 10:04:12
 *
 *  改变账号登陆
 */
- (void)changeAccount;

/**
 *  @Author 刘宝, 2016-01-26 13:01:02
 *
 *  取消设置
 */
- (void)cancelSet;
@end
