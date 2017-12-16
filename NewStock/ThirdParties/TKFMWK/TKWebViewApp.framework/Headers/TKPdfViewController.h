//
//  TKPdfViewController.h
//  TKAppBase_V1
//
//  Created by liubao on 15-4-21.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKBaseViewController.h"

/**
 *  @Author 刘宝, 2015-04-21 09:04:55
 *
 *  查看Pdf文件
 */
@interface TKPdfViewController : TKBaseViewController

/**
 *  @Author 刘宝, 2015-04-21 09:04:47
 *
 *  pdf地址
 */
@property(nonatomic,copy)NSString *url;

/**
 *  @Author 刘宝, 2015-07-28 13:07:00
 *
 *  状态栏背景颜色
 */
@property(nonatomic,retain)UIColor *statusBarBgColor;

/**
 *  @author 刘宝, 2016-09-12 17:09:10
 *
 *  前缀
 */
@property(nonatomic,copy)NSString *suffix;

@end
