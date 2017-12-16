//
//  TKMesageDelagate.h
//  TKApp
//
//  Created by liubao on 14-12-1.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2014-12-01 11:12:18
 *
 *  消息协议
 */
@protocol TKMesageDelegate <NSObject>

/**
 *  监听的消息名称列表
 *
 *  @return 消息名称列表
 */
-(NSArray *)listNotificationInter;

/**
 *  发送消息
 *
 *  @param name        消息名称
 *  @param body        消息主体
 *  @param userInfo    其他属性信息
 */
-(void)sendNotificationName:(NSString *)name object:(id)body userInfo:(NSDictionary *)userInfo;

/**
 *  接受处理消息
 *
 *  @param notification 消息对象
 */
-(void)handleNotification:(NSNotification *)notification;

/**
 *  删除消息监听
 *
 *  @param notificationName 消息名称
 */
-(void)removeNotificationInter:(NSString *)notificationName;

/**
 *  批量删除消息监听
 *
 *  @param notificationNames 消息名称数组
 */
-(void)removeNotificationInters:(NSArray *)notificationNames;

@end
