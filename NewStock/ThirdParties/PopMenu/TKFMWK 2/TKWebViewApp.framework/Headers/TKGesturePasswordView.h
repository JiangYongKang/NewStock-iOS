//
//  GesturePasswordView.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKGesturePasswordTouchDelegate.h"
#import "TKGesturePasswordButtonDelegate.h"
#import "TKTentacleView.h"

/**
 *  @Author 刘宝, 2015-04-14 10:04:55
 *
 *  手势的界面
 */
@interface TKGesturePasswordView : UIView<TKGesturePasswordTouchDelegate,TKGesturePasswordButtonDelegate>

/**
 *  @Author 刘宝, 2015-04-14 09:04:52
 *
 *  初始化
 *
 *  @param frame 大小区域
 *  @param type 手势密码风格
 *  @param innerCircle 是否初始显示中心小圆
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame style:(TKGesturePasswordType)type innerCircle:(BOOL)innerCircle;

/**
 *  @Author 刘宝, 2015-04-14 11:04:57
 *
 *  按钮事件处理代理
 */
@property (nonatomic,weak) id<TKGesturePasswordButtonDelegate> buttonDelegate;

/**
 *  @Author 刘宝, 2015-04-14 11:04:57
 *
 *  触摸滑动事件处理代理
 */
@property (nonatomic,weak) id<TKGesturePasswordTouchDelegate> touchDelegate;

/**
 *  @Author 刘宝, 2015-04-14 11:04:40
 *
 *  显示的用户图片
 */
@property (nonatomic,retain) UIImage *userImage;

/**
 *  @Author 刘宝, 2015-04-14 11:04:26
 *
 *  显示用户的账号信息
 */
@property (nonatomic,copy) NSString *userAccount;

/**
 *  @Author 刘宝, 2016-03-10 14:03:43
 *
 *  是否返回按钮
 */
@property (nonatomic,assign) BOOL isCanBack;

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
 *  @Author 刘宝, 2015-01-30 14:01:22
 *
 *  清理初始化原始手势界面
 */
- (void)resetGesturePassword;

/**
 *  @Author 刘宝, 2015-04-15 19:04:20
 *
 *  设置用户状态
 *
 *  @param state
 */
- (void)setUserState:(NSString *)state errorFlag:(BOOL)errorFlag;

/**
 *  @Author 刘宝, 2015-04-16 09:04:18
 *
 *  设置头部手势密码小图
 *
 *  @param password 密码
 */
- (void)setTitleGesturePassword:(NSString *)password;

@end
