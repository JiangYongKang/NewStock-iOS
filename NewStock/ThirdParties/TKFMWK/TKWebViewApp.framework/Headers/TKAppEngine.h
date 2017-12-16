//
//  TKAppEngine.h
//  TKApp
//
//  Created by liubao on 14-11-28.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKMesageDelegate.h"
#import "TKAppInvokeDelegate.h"
#import "TKRootViewController.h"
#import "TKExternalJSBridge.h"
#import "TKPluginInvokeCenter.h"

/**
 *  @Author 刘宝, 2015-06-19 09:06:39
 *
 *  网络改变通知
 *
 */
#define NOTE_NETWORK_CHANGE @"note_newwork_change"

/**
 *  @Author 刘宝, 2014-12-01 11:12:51
 *
 *  消息中心
 */
@interface TKAppEngine : NSObject<TKMesageDelegate,TKAppInvokeDelegate>

/**
 *  @Author 刘宝, 2014-12-01 14:12:09
 *
 *  单例
 *
 *  @return 
 */
+(TKAppEngine *)shareInstance;

/**
 *  @Author 刘宝, 2014-12-01 18:12:49
 *
 *  根控制器
 */
@property (nonatomic,readonly,strong)TKRootViewController *rootViewCtr;

/**
 *  @Author 刘宝, 2014-12-12 22:12:27
 *
 *  js连接桥
 */
@property (nonatomic,readonly,strong)TKExternalJSBridge *jsBridge;

/**
 *  @Author 刘宝, 2014-12-12 23:12:17
 *
 *  插件中心
 */
@property (nonatomic,readonly,strong)TKPluginInvokeCenter *pluginCenter;

/**
 *  @Author 刘宝, 2014-12-15 15:12:14
 *
 *  网络监测
 */
@property (nonatomic,readonly,strong)TKReachability *reachability;

/**
 *  @author 刘宝, 2017-01-10 13:01:35
 *
 *  是否使用H5的缓存拦截防篡改机制
 */
@property (nonatomic,assign) BOOL isUserH5CacheFilter;

/**
 *  @Author 刘宝, 2014-12-12 22:12:08
 *
 *  启动引擎
 */
-(void)start;

/**
 *  @Author 刘宝, 2014-12-12 22:12:16
 *
 *  关闭引擎
 */
-(void)stop;

/**
 *  @Author 刘宝, 2014-12-12 22:12:36
 *
 *  是否在运行
 *
 *  @return 运行状态
 */
-(BOOL)isRuning;

@end
