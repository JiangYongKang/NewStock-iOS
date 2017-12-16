//
//  TKPluginInvokeCenter.h
//  TKApp
//
//  Created by liubao on 14-12-10.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultVo.h"
#import "TKBasePlugin.h"

/**
 *  @Author 刘宝, 2015-06-12 12:06:46
 *
 *  插件回调函数
 *
 *  @param result
 */
typedef void(^PluginCallBackFunc)(NSMutableDictionary *result);

/**
 *  @Author 刘宝, 2014-12-10 01:12:43
 *
 *  插件处理中心
 */
@interface TKPluginInvokeCenter : NSObject

/**
 *  @Author 刘宝, 2014-11-27 15:11:44
 *
 *  单例对象
 *
 *  @return
 */
+(TKPluginInvokeCenter *)shareInstance;

/**
 *  @author 刘宝, 2016-07-08 17:07:46
 *
 *  插件配置
 */
@property(nonatomic,readonly)NSDictionary *pluginMap;

/**
 *  @Author 刘宝, 2014-12-24 13:12:16
 *
 *  调用插件
 *
 *  @param funcNo       功能号
 *  @param param        参数
 *  @param moduleName   模块名称
 *  @param callBackFunc 原生调用插件的回调函数
 *
 *  @return
 */
-(ResultVo *)invokePlugin:(NSString *)funcNo param:(id)param moduleName:(NSString *)moduleName isH5:(BOOL)isH5 callBackFunc:(PluginCallBackFunc)callBackFunc;

/**
 *  @author 刘宝, 2016-10-18 20:10:22
 *
 *  获取缓存的插件对象
 *
 *  @param funcNo 功能号
 *
 *  @return 插件对象
 */
-(TKBasePlugin *)getCachePlugin:(NSString *)funcNo;

@end
