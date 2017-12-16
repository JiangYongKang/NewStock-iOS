//
//  TKModuleDelegate.h
//  TKAppBase_V2
//
//  Created by 刘宝 on 17/1/13.
//  Copyright © 2017年 com.thinkive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKModuleMessage.h"
#import "TKPushMessage.h"

/**
 *  @Author 刘宝, 2014-12-01 11:12:18
 *
 *  模块接口定义
 */
@protocol TKModuleDelegate <NSObject>

/**
 *  @author 刘宝, 2017-01-13 08:01:32
 *
 *  处理模块跳转消息
 *
 *  @param message 消息
 */
-(void)onModuleMessage:(TKModuleMessage *)message;

/**
 *  @author 刘宝, 2017-01-13 08:01:58
 *
 *  处理消息推送消息
 *
 *  @param message 消息
 */
-(void)onPushMessage:(TKPushMessage *)message;

@end
