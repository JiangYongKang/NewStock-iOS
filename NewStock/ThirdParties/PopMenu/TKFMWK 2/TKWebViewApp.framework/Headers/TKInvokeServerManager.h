//
//  TKJavascriptServerManager.h
//  TKApp
//
//  Created by liubao on 14-11-27.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKServerInvokeDelegate.h"

@interface TKInvokeServerManager : NSObject

/**
 *  @Author 刘宝, 2014-11-27 20:11:31
 *
 *  单例模式
 *
 *  @return
 */
+(TKInvokeServerManager *)shareInstance;

/**
 *  @Author 刘宝, 2014-11-27 12:11:15
 *
 *  启动服务
 */
-(void)startServer;

/**
 *  @Author 刘宝, 2014-11-27 12:11:23
 *
 *  关闭服务
 */
-(void)stopServer;

/**
 *  @Author 刘宝, 2014-11-27 15:11:37
 *
 *  是否在运行
 *
 *  @return 运行状态
 */
-(BOOL)isRuning;

/**
 *  @Author 刘宝, 2014-11-27 12:11:33
 *
 *  注册服务
 *
 *  @param serviceName 服务名
 *  @param service     服务插件
 */
-(void) registor : (NSString* )serviceName service: (id<TKServerInvokeDelegate>) service;

/**
 *  @Author 刘宝, 2014-11-27 12:11:55
 *
 *  卸载服务
 *
 *  @param serviceName 服务名
 */
-(void) unregistor : (NSString* )serviceName;

/**
 *  @Author 刘宝, 2014-11-27 12:11:10
 *
 *  服务转发中心
 *
 *  @param serviceName 转发服务名
 *  @param methodName 服务方法
 *  @param argsJSON   入参
 *
 *  @return 结果数据
 */
-(NSData *) invoke:(NSString*) serviceName methodName: (NSString*) methodName arguments: (NSString*) argsJSON;

@end
