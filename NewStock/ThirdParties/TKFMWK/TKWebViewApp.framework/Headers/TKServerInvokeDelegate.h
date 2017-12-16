//
//  TKServerInvokeDelegate.h
//  TKApp
//
//  Created by liubao on 14-11-27.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultVo.h"

/**
 *  @Author 刘宝, 2014-11-27 12:11:34
 *
 *  服务器处理协议
 */
@protocol TKServerInvokeDelegate <NSObject>

@required
/**
 *  @Author 刘宝, 2014-11-27 12:11:58
 *
 *  服务器处理协议
 *
 *  @param param 参数
 *
 *  @return 数据
 */
-(ResultVo *)serverInvoke:(id)param;

@end
