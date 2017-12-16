//
//  TKJSBasePlugin.h
//  TKApp
//
//  Created by liubao on 14-11-27.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKServerInvokeDelegate.h"
#import "JSCallBack.h"
#import "UIViewController+TKBaseViewController.h"
#import "TKCommonService.h"

/**
 *  @Author 刘宝, 2014-11-27 16:11:08
 *
 *  js插件基础类
 */
@interface TKBasePlugin : NSObject<TKServerInvokeDelegate>
{
    @protected
    /**
     *  服务类
     */
    TKCommonService *_commonService;
}

/**
 *  @Author 刘宝, 2014-12-10 00:12:35
 *
 *  当前操作模块名称
 */
@property (nonatomic,copy)NSString *moduleName;

/**
 *  @Author 刘宝, 2015-06-12 10:06:19
 *
 *  是否H5调用
 */
@property (nonatomic,assign)BOOL isH5;

/**
 *  @author 刘宝, 2016-06-09 13:06:23
 *
 *  是否是JS回调模式
 */
@property (nonatomic,assign)BOOL isUseJsCallBack;

/**
 *  @author 刘宝, 2016-06-09 13:06:49
 *
 *  请求流水号
 */
@property (nonatomic,copy)NSString *flowNo;

/**
 *  @Author 刘宝, 2015-06-12 12:06:50
 *
 *  回调函数
 */
@property (nonatomic,strong)PluginCallBackFunc callBackFunc;

/**
 *  @Author 刘宝, 2014-12-10 00:12:51
 *
 *  当前模块名称对应的浏览器WebView
 */
@property (nonatomic,readonly,strong)JSCallBack *currentJsCallBack;

/**
 *  @Author 刘宝, 2014-12-10 00:12:25
 *
 *  当前模块名称对应的控制器
 */
@property (nonatomic,readonly,strong)UIViewController *currentViewCtrl;

/**
 *  @Author 刘宝, 2014-12-01 17:12:16
 *
 *  根控制器
 */
@property(nonatomic,readonly,strong) UIViewController *rootViewCtrl;

/**
 *  @Author 刘宝, 2014-12-24 00:12:54
 *
 *  根窗口
 */
@property(nonatomic,readonly,strong) UIWindow *rootWindow;

/**
 *  @Author 刘宝, 2014-12-24 00:12:17
 *
 *  根代理
 */
@property(nonatomic,readonly,strong)id<UIApplicationDelegate> rootDelegate;

/**
 *  @Author 刘宝, 2015-04-21 00:04:56
 *
 *  IOS调用JS
 *
 *  @param param       参数
 */
-(void)iosCallJsWithParam:(NSMutableDictionary *)param;

/**
 *  @Author 刘宝, 2015-04-22 10:04:09
 *
 *  IOS调用JS
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
 *  @param function    函数名称
 *  @param params      多个JS入参用,分割的，这里用数组表示
 */
-(void)iosCallJsWithFunction:(NSString *)function params:(NSArray *)params;

/**
 *  @Author 刘宝, 2015-06-12 12:06:12
 *
 *  原生执行插件的回调函数
 *
 *  @param param 参数
 */
-(void)iosCallPluginCallBack:(NSMutableDictionary *)param;

@end
