//
//  TKQRCoderZBarScanerViewController.h
//  TKAppBase_V1
//
//  Created by liubao on 15-6-25.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKQRCoderScanerViewController.h"

/**
 *  @Author 刘宝, 2015-06-25 12:06:30
 *
 *  zbar的二维码扫描工具
 */
@interface TKQRCoderZBarScanerViewController : TKBaseViewController

/**
 *  @Author 刘宝, 2015-06-23 20:06:03
 *
 *  处理扫描出来的二维码内容代理对象
 */
@property(nonatomic,weak)id<TKQRCoderScanerDelegate> delegate;

/**
 *  @Author 刘宝, 2015-07-28 13:07:00
 *
 *  状态栏背景颜色
 */
@property(nonatomic,retain)UIColor *statusBarBgColor;

@end
