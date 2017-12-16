//
//  TKUIView.h
//  TKComponent_V1
//
//  Created by liubao on 15-8-24.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-08-24 18:08:53
 *
 *  自定义view
 */
@interface TKUIView : UIView

/**
 *  @Author 刘宝, 2015-08-24 18:08:41
 *
 *  背景色
 */
@property (nonatomic,retain)UIImage *backgroundImage;

/**
 *  @Author 刘宝, 2015-04-22 18:04:11
 *
 *  导航栏的背景颜色
 */
@property (nonatomic,strong)UIColor *backgroundColor;

@end
