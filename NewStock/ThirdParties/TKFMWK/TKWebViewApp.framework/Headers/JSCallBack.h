//
//  JSCallBack.h
//  TKApp
//
//  Created by liubao on 14-11-26.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @Author 刘宝, 2014-11-26 23:11:07
 *
 *  js交互类
 */
@interface JSCallBack : NSObject

/**
 *  @Author 刘宝, 2014-11-27 10:11:39
 *
 *  当前的webview对象
 */
@property (nonatomic,strong)UIWebView *webView;

/**
 *  @Author 刘宝, 2014-11-27 10:11:51
 *
 *  当前webView所在的控制器
 */
@property (nonatomic,weak,readonly)UIViewController *viewCtrl;

/**
 *  @Author 刘宝, 2014-11-27 16:11:52
 *
 * 浏览器对象的名称
 */
@property (nonatomic,copy)NSString *webViewName;

/**
 *  @Author 刘宝, 2015-08-06 10:08:33
 *
 *  H5是否加载完成
 */
@property(nonatomic,readonly)BOOL isH5LoadFinish;

/**
 *  @Author 刘宝, 2015-09-30 12:09:58
 *
 *  是否已经被使用
 */
@property(nonatomic,assign)BOOL isUsed;

/**
 *  @Author 刘宝, 2015-10-08 19:10:50
 *
 *  是否被缓存
 */
@property(nonatomic,assign)BOOL isCached;

/**
 *  @Author 刘宝, 2015-10-08 22:10:11
 *
 *  唯一id
 */
@property(nonatomic,copy)NSString *uuid;

/**
 *  @Author 刘宝, 2014-11-26 23:11:31
 *
 *  初始化对象
 *
 *  @param webView WebView对象
 *
 *  @return
 */
-(id)initWithWebView:(UIWebView *)webView;

/**
 *  @Author 刘宝, 2014-11-26 23:11:52
 *
 *  原生调用js
 *
 *  @param funcName 函数名
 *  @param paramMap json参数
 *  @param isAsync 是否异步
 */
-(NSString *)iosCallJSFunction:(NSString *)funcName paramMap:(NSMutableDictionary *)paramMap isAsync:(BOOL)isAsync;

/**
 *  @Author 刘宝, 2014-11-26 23:11:52
 *
 *  原生调用js同步方法
 *
 *  @param funcName 函数名
 *  @param paramMap json参数
 */
-(NSString *)iosCallJSFunction:(NSString *)funcName paramMap:(NSMutableDictionary *)paramMap;

/**
 *  @Author 刘宝, 2014-11-26 23:11:52
 *
 *  原生调用js
 *
 *  @param funcName 函数名
 *  @param params   参数数组
 *  @param isAsync 是否异步
 */
-(NSString *)iosCallJSFunction:(NSString *)funcName params:(NSArray *)params isAsync:(BOOL)isAsync;

/**
 *  @Author 刘宝, 2014-11-26 23:11:52
 *
 *  原生调用js同步方法
 *
 *  @param funcName 函数名
 *  @param params   参数数组
 */
-(NSString *)iosCallJSFunction:(NSString *)funcName params:(NSArray *)params;

/**
 *  @Author 刘宝, 2014-11-27 10:11:12
 *
 *  ios老的调用js的方法，现在建议用新的格式
 *
 *  @param moduleName      模块名
 *  @param childModuleName 子模块名
 *  @param msgId           消息ID
 *  @param msgData         参数
 *
 *  @return
 */
-(NSString *)iosOldCallJSFunction:(NSString *)moduleName childModuleName:(NSString *)childModuleName msgId:(NSString *)msgId msgData:(NSObject *)msgData;

/**
 *  @Author 刘宝, 2015-09-30 02:09:16
 *
 *  预加载函数
 *
 *  @param pageUrl 加载地址
 */
-(void)prepareLoadUrl:(NSString *)pageUrl;

/**
 *  @Author 刘宝, 2015-09-30 00:09:22
 *
 *  根据页面里面pageCode进行初始化模块
 *
 *  @param pageUrl
 */
-(void)initH5JSModuleForPageUrl:(NSString *)pageUrl;

@end
