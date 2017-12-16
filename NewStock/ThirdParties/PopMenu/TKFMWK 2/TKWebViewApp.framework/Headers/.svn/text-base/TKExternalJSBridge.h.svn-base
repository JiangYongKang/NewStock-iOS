//
//  TKExternalJSBridge.h
//  TKApp
//
//  Created by liubao on 14-11-27.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKServerInvokeDelegate.h"

/**
 *  @Author 刘宝, 2014-11-27 15:11:59
 *
 *  处理JS的消息中心
 */
@interface TKExternalJSBridge : NSObject<TKServerInvokeDelegate>

/**
 *  @Author 刘宝, 2014-11-27 15:11:44
 *
 *  单例对象
 *
 *  @return
 */
+(TKExternalJSBridge *)shareInstance;

/**
 * 销毁交互通道
 */
-(void)destroyExternal;

/**
 *  @Author 刘宝, 2014-11-27 15:11:23
 *
 *  建立交互通道
 */
-(void)buildExternal;

@end
