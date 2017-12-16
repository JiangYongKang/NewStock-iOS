//
//  TKPlugin50100.h
//  TKAppBase_V1
//
//  Created by liubao on 15-4-20.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKBasePlugin.h"

/**
 *  @Author 刘宝, 2015-06-05 12:06:02
 *
 *  H5模块加载完成通知
 */
#define NOTE_H5LOAD_FINISH @"h5LoadFinish"

/**
 *  @Author 刘宝, 2015-06-05 12:06:20
 *
 *  H5模板加载完成的内存标志
 *
 */
#define MEM_H5LOAD_FINISH @"h5LoadFinish"

/**
 *  @Author 刘宝, 2015-04-20 20:04:18
 *
 *  通知原生H5加载完毕
 */
@interface TKPlugin50100 : TKBasePlugin

@end
