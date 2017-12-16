//
//  TKMessage.h
//  TKApp
//
//  Created by liubao on 14-12-1.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKUtil.h"

/**
 *  @author 刘宝, 2017-01-13 08:01:42
 *
 *  模块交互行为
 */
typedef enum{
    /**
     *  @author 刘宝, 2017-01-13 08:01:23
     *
     *  弹层打开
     */
    TKModuleMessage_Action_Pop,
    /**
     *  @author 刘宝, 2017-01-13 08:01:32
     *
     *  Push打开
     */
    TKModuleMessage_Action_Push,
    /**
     *  @author 刘宝, 2017-01-13 08:01:44
     *
     *  关闭模块
     */
    TKModuleMessage_Action_Close,
    /**
     *  @author 刘宝, 2017-01-13 08:01:53
     *
     *  切换模块
     */
    TKModuleMessage_Action_Change,
    /**
     *  @author 刘宝, 2017-01-13 08:01:20
     *
     *  模块通知
     */
    TKModuleMessage_Action_NSNotify
}TKModuleMessage_Action;

/**
 *  @Author 刘宝, 2014-12-09 16:12:05
 *
 *  模块消息
 */
@interface TKModuleMessage : DynModel

/**
 *  @Author 刘宝, 2014-12-01 10:12:22
 *
 *  消息功能号
 */
@property(nonatomic,copy)NSString *funcNo;

/**
 *  @Author 刘宝, 2014-12-09 16:12:54
 *
 *  消息来源的模块名称
 */
@property(nonatomic,retain)NSString *sourceMoudle;

/**
 *  @Author 刘宝, 2014-12-09 16:12:54
 *
 *  接收消息的模块名称
 */
@property(nonatomic,retain)NSString *targetMoudle;

/**
 *  @author 刘宝, 2017-01-13 08:01:48
 *
 *  操作动作
 */
@property(nonatomic,assign)TKModuleMessage_Action action;

/**
 *  @Author 刘宝, 2014-12-01 10:12:48
 *
 *  业务参数
 */
@property(nonatomic,retain)NSMutableDictionary *param;

@end
