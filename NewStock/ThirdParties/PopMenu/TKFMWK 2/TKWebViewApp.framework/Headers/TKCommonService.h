//
//  TKCommonService.h
//  TKApp
//
//  Created by liubao on 14-11-26.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKBaseService.h"



/**
 *  @Author 刘宝, 2014-11-26 18:11:45
 *
 *  通用基础Service
 */
@interface TKCommonService :TKBaseService


/**
 *  @Author 刘宝, 2014-11-26 16:11:56
 *
 *  构建初始化请求对象
 */
-(ReqParamVo *)createReqParamVo;

/**
 *  @Author 刘宝, 2014-11-25 23:11:12
 *
 *  请求服务
 *
 *  @param reqParamVo   请求对象
 *  @param callBackFunc 回调函数
 *  @param isReturnList 是否返回List
 *  @param isRunInMainThread 回调函数是否在主线程上
 */
-(void)invoke:(ReqParamVo *)reqParamVo callBackFunc:(CallBackFunc)callBackFunc isReturnList:(BOOL)isReturnList isRunInMainThread:(BOOL)isRunInMainThread;

/**
 *  @Author 刘宝, 2014-11-25 23:11:12
 *
 *  请求服务
 *
 *  @param reqParamVo   请求对象
 *  @param callBackFunc 回调函数
 *  @param isRunInMainThread 回调函数是否在主线程上
 */
-(void)invoke:(ReqParamVo *)reqParamVo callBackFunc:(CallBackFunc)callBackFunc isRunInMainThread:(BOOL)isRunInMainThread;

/**
 *  @Author 刘宝, 2015-04-21 00:04:56
 *
 *  IOS调用JS
 *
 *  @param webViewName webView
 *  @param param       参数
 */
-(void)iosCallJs:(NSString *)webViewName param:(NSMutableDictionary *)param;

/**
 *  @Author 刘宝, 2015-11-19 13:11:48
 *
 *  IOS调用JS，群发调用
 *
 *  @param param 入参
 */
-(void)iosCallJsWithParam:(NSMutableDictionary *)param;

/**
 *  @Author 刘宝, 2015-04-22 10:04:09
 *
 *  IOS调用JS
 *
 *  @param webViewName webView 名称
 *  @param function    函数名称
 *  @param param       Json格式的JS入参
 */
-(void)iosCallJs:(NSString *)webViewName function:(NSString *)function param:(NSMutableDictionary *)param;

/**
 *  @Author 刘宝, 2015-04-22 10:04:09
 *
 *  IOS调用JS，群发调用
 *
 *  @param function    函数名称
 *  @param param       Json格式的JS入参
 */
-(void)iosCallJsWithFunction:(NSString *)function param:(NSMutableDictionary *)param;

/**
 *  @Author 刘宝, 2015-04-22 10:04:53
 *
 *  IOS调用JS
 *
 *  @param webViewName webView 名称
 *  @param function    函数名称
 *  @param params      多个JS入参用,分割的，这里用数组表示
 */
-(void)iosCallJs:(NSString *)webViewName function:(NSString *)function params:(NSArray *)params;

/**
 *  @Author 刘宝, 2015-04-22 10:04:53
 *
 *  IOS调用JS，群发调用
 *
 *  @param function    函数名称
 *  @param params      多个JS入参用,分割的，这里用数组表示
 */
-(void)iosCallJsWithFunction:(NSString *)function params:(NSArray *)params;

/**
 *  @Author 刘宝, 2015-07-16 03:07:15
 *
 *  检测版本更新
 *
 *  @param url          检测地址
 *  @param callBackFunc 回调函数
 */
-(void)checkVersionUpdate:(NSString *)url callBackFunc:(CallBackFunc)callBackFunc;

/**
 *  @Author 刘宝, 2015-07-16 03:07:15
 *
 *  检测服务器列表更新
 *
 *  @param url          检测地址 例如：http://127.0.0.1:8080/servlet/json
 *  @param callBackFunc 回调函数
 */
-(void)checkServerXmlUpdate:(NSString *)url callBackFunc:(CallBackFunc)callBackFunc;

/**
 *  @author 刘宝, 2016-06-28 16:06:05
 *
 *  发送请求日志
 *
 *  @param url          地址
 *  @param content      日志
 *  @param count        数目
 *  @param callBackFunc 回调
 */
-(void)sendLog:(NSString *)url content:(NSString *)content count:(int)count callBackFunc:(CallBackFunc)callBackFunc;

/**
 *  @Author 刘宝, 2016-02-25 14:02:58
 *
 *  实现网络请求代理
 *
 *  @param moduleName   模块名称
 *  @param protocol     网络协议（0：HTTP/HTTPS 1:行情长连接 2:交易长连接 3:资讯长连接 4:新版统一接入长连接）
 *  @param url          网络地址 (URL地址或站点名称)
 *  @param paramMap     网络参数
 *  @param headerMap    请求头参数
 *  @param isPost       是否post
 *  @param flowNo       流水号
 *  @param timeOut      超时时间(单位秒)
 *  @param mode         请求加密模式(0:正常，1:Http加签，2：Http加密，3：Http加密加签，4:Socket加密，5：Socket压缩，6：Socket压缩加密)
 *  @param callBackFunc 回调函数
 */
-(void)doProxyNetWorkService:(NSString *)moduleName protocol:(NSString *)protocol url:(NSString *)url paramMap:(NSMutableDictionary *)paramMap headerMap:(NSMutableDictionary *)headerMap isPost:(BOOL)isPost flowNo:(NSString *)flowNo timeOut:(int)timeOut mode:(NSString *)mode callBackFunc:(CallBackFunc)callBackFunc;

@end
