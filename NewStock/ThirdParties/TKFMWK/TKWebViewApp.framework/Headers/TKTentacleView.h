//
//  TentacleView.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TKGesturePasswordTouchDelegate.h"
#import "UIView+TKBaseView.h"

/**
 手势密码类型
 */
typedef enum
{
    /**
     *  @Author 刘宝, 2015-04-14 14:04:19
     *
     *  设置
     */
    TKGesturePasswordType_Set,
    
    /**
     *  @Author 刘宝, 2015-04-14 14:04:26
     *
     *  验证
     */
    TKGesturePasswordType_Vertify,
    
    /**
     *  @Author 刘宝, 2015-06-09 21:06:13
     *
     *  取消
     */
    TKGesturePasswordType_Cancel,
    
    /**
     *  @Author 刘宝, 2015-10-30 00:10:34
     *
     *  修改
     */
    TKGesturePasswordType_Reset,
    
    /**
     *  @Author 刘宝, 2016-03-10 16:03:48
     *
     *  返回
     */
    TKGesturePasswordType_Back
    
} TKGesturePasswordType;

/**
 *  @Author 刘宝, 2015-01-30 14:01:24
 *
 *  手势内容组件
 */
@interface TKTentacleView : UIView

/**
 *  @Author 刘宝, 2015-04-14 09:04:52
 *
 *  手势密码触摸动作代理
 */
@property (nonatomic,weak) id<TKGesturePasswordTouchDelegate> delegate;

/**
 *  @Author 刘宝, 2016-03-17 00:03:13
 *
 *  连接线的样式，0：不带箭头，1：带箭头
 */
@property (nonatomic,copy)NSString *lineStyle;

/**
 *  @Author 刘宝, 2015-04-14 09:04:52
 *
 *  初始化
 *
 *  @param frame 大小区域
 *  @param type 手势密码风格
 *  @param innerCircle 是否初始化显示中心小圆
 *
 *  @return 
 */
-(id)initWithFrame:(CGRect)frame style:(TKGesturePasswordType)type innerCircle:(BOOL)innerCircle;

/**
 *  @Author 刘宝, 2015-01-30 14:01:22
 *
 *  清理初始化原始手势界面
 */
- (void)resetGesturePassword;

@end
