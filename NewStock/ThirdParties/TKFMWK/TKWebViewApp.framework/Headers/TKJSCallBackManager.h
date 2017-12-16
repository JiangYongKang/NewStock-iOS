//
//  TKJSCallBackManager.h
//  TKApp
//
//  Created by liubao on 14-11-27.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSCallBack.h"

/**
 *  @Author 刘宝, 2014-11-27 20:11:42
 *
 *  浏览器对象的管理中心
 */
@interface TKJSCallBackManager : NSObject

/**
 *  @Author 刘宝, 2014-11-25 15:11:20
 *
 *  单例模式
 *
 *  @return 单例
 */
+(TKJSCallBackManager *)shareInstance;

/**
 *  @Author 刘宝, 2014-11-27 21:11:41
 *
 *  当前的浏览器
 */
@property(nonatomic,copy)NSString *currentModuleName;

/**
 *  @Author 刘宝, 2014-11-27 16:11:31
 *
 *  当前正在运行浏览器对象
 *
 *  @return
 */
-(JSCallBack *)currentJsCallBack;

/**
 *  @Author 刘宝, 2014-11-27 20:11:21
 *
 *  返回注册中心的对象
 *
 *  @param moduleName 模块名称
 *
 *  @return 运行浏览器对象
 */
-(JSCallBack *)getJsCallBack:(NSString *)moduleName;

/**
 *  @Author 刘宝, 2014-11-27 16:11:05
 *
 *  注册浏览器对象
 *  @param jsCallBack js对象
 */
-(void)registor:(JSCallBack *)jsCallBack;

/**
 *  @author 刘宝, 2016-10-27 00:10:40
 *
 *  重新注册浏览器对象，同时删除老的注册对象
 *
 *  @param jsCallBack    新注册的浏览器对象
 *  @param oldModuleName 需要删除注册的老的对象名称
 */
-(void)registor:(JSCallBack *)jsCallBack forOldModuleName:(NSString *)oldModuleName;

/**
 *  @Author 刘宝, 2014-11-27 16:11:38
 *
 *  卸载浏览器对象
 *
 *  @param moduleName 名称
 */
-(void)unregistor:(NSString *)moduleName;

/**
 *  @Author 刘宝, 2014-11-28 01:11:48
 *
 *  注册webview
 *
 *  @param moduleName 浏览器名称
 *  @param webView    webWiew对象
 */
-(void)registor:(NSString *)moduleName webView:(UIWebView *)webView;

/**
 *  @Author 刘宝, 2015-09-29 20:09:27
 *
 *  创建一个webView对象，支持缓冲池
 *
 *  @param moduleName  模块名称
 *
 *  @return
 */
-(JSCallBack *)createJsCallBack:(NSString *)moduleName;

/**
 *  @Author 刘宝, 2015-09-29 20:09:27
 *
 *  创建一个webView对象，不支持缓冲池
 *
 *  @param moduleName  模块名称
 *
 *  @return
 */
-(JSCallBack *)createJsCallBackForNoCache:(NSString *)moduleName;

/**
 *  @Author 刘宝, 2015-09-30 10:09:29
 *
 *  预处理webView对象
 *
 *  @param moduleName webView名称
 *  @param pageUrl    url地址
 */
-(JSCallBack *)prepareJsCallBack:(NSString *)moduleName pageUrl:(NSString *)pageUrl;

/**
 *  @Author 刘宝, 2015-11-19 14:11:40
 *
 *  获取所有的浏览器对象
 *
 *  @return
 */
-(NSArray *)getAllJSCallBack;

@end
