//
//  GesturePasswordController.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKGesturePasswordButtonDelegate.h"
#import "TKGesturePasswordTouchDelegate.h"
#import "TKTentacleView.h"

/**
 *  @Author 刘宝, 2015-04-14 11:04:45
 *
 *  手势密码控制器
 */
@interface TKGesturePasswordController : UIViewController

/**
 *  @Author 刘宝, 2014-12-22 10:12:03
 *
 *  账号
 */
@property (nonatomic,copy)NSString *account;

/**
 *  @Author 刘宝, 2015-04-21 11:04:56
 *
 *  用户图片
 */
@property (nonatomic,retain)UIImage *userImage;

/**
 *  @Author 刘宝, 2014-12-22 11:12:17
 *
 *  密码
 */
@property (nonatomic,copy,readonly)NSString * password;

/**
 *  @Author 刘宝, 2014-12-22 15:12:05
 *
 *  错误次数
 */
@property (nonatomic,assign)int maxErrorNum;

/**
 *  @Author 刘宝, 2015-04-21 16:04:03
 *
 *  锁屏的秒数
 */
@property (nonatomic,assign)int lockSenconds;

/**
 *  @Author 刘宝, 2014-12-25 14:12:43
 *
 *  密码最小长度
 */
@property (nonatomic,assign)int minPasswordLength;

/**
 *  @Author 刘宝, 2016-03-10 13:03:19
 *
 *  是否有返回按钮
 */
@property (nonatomic,assign)BOOL isCanBack;

/**
 *  @Author 刘宝, 2016-03-16 14:03:39
 *
 *  返回键的位置
 */
@property (nonatomic,copy)NSString *position;

/**
 *  @Author 刘宝, 2016-03-17 00:03:13
 *
 *  连接线的样式，0：不带箭头，1：带箭头
 */
@property (nonatomic,copy)NSString *lineStyle;

/**
 *  @Author 刘宝, 2015-04-21 11:04:48
 *
 *  按钮代理
 */
@property (nonatomic,weak)id<TKGesturePasswordButtonDelegate> buttonDelegate;

/**
 *  @Author 刘宝, 2015-10-30 00:10:56
 *
 *  绘图完成代理函数
 */
@property (nonatomic,weak)id<TKGesturePasswordTouchDelegate> touchDelegate;

/**
 *  @Author 刘宝, 2015-04-14 14:04:24
 *
 *  加载手势密码界面
 *
 *  @param type 手势类型
 *  @param innerCircle  是否初始显示中心圆
 */
- (void)loadPasswordView:(TKGesturePasswordType)type innerCircle:(BOOL)innerCircle;

/**
 *  @Author 刘宝, 2014-12-22 10:12:22
 *
 *  清除数据
 */
- (void)clearPassword;

/**
 *  @Author 刘宝, 2014-12-22 14:12:48
 *
 *  显示
 */
- (void)showPassword;

/**
 *  @Author 刘宝, 2014-12-22 14:12:59
 *
 *  隐藏
 */
- (void)hidePassword;

@end
