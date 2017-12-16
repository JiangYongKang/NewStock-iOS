//
//  GesturePasswordButton.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @Author 刘宝, 2015-04-13 18:04:10
 *
 *  圆圈按钮
 */
@interface TKGesturePasswordButton : UIView

/**
 *  @Author 刘宝, 2015-04-13 18:04:36
 *
 *  是否选择
 */
@property (nonatomic,assign) BOOL selected;

/**
 *  @Author 刘宝, 2015-04-13 18:04:50
 *
 *  是否正确
 */
@property (nonatomic,assign) BOOL success;

/**
 *  @Author 刘宝, 2015-04-19 23:04:39
 *
 *  是否开始显示中心小圆
 */
@property (nonatomic,assign) BOOL innerCircle;

/**
 *  @Author 刘宝, 2015-04-16 23:04:22
 *
 *  设置箭头的点
 *
 *  @param point
 */
-(void)setArrowPoint:(CGPoint)point;

@end
