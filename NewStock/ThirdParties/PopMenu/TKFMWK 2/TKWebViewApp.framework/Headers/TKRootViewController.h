//
//  TKRootViewController.h
//  TKApp
//
//  Created by liubao on 14-12-1.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TKAppInvokeDelegate.h"

/**
 *  @author 刘宝, 2017-01-13 10:01:46
 *
 *  控制器存储对象
 */
@interface TKViewControllerVo : NSObject

@property (nonatomic,weak)UIViewController *viewController;

@end

/**
 *  @Author 刘宝, 2014-12-01 17:12:25
 *
 *  应用根控制器
 */
@interface TKRootViewController : NSObject

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
 *  @Author 刘宝, 2015-08-05 03:08:28
 *
 *  当前控制器名称
 */
@property(nonatomic,copy)NSString *currentViewCtrlName;

/**
 *  @Author 刘宝, 2015-08-05 03:08:32
 *
 *  当前控制器
 */
@property(nonatomic,readonly,strong)UIViewController *currentViewCtrl;

/**
 *  @Author 刘宝, 2014-12-01 17:12:47
 *
 *  单例
 *
 *  @return 
 */
+(TKRootViewController *)shareInstance;

/**
 *  @Author 刘宝, 2014-12-01 17:12:22
 *
 *  注册viewCtrl
 *
 *  @param viewCtrl 控制器
 */
-(void)registerViewCtrl:(UIViewController *)viewCtrl;

/**
 *  @Author 刘宝, 2014-12-01 17:12:45
 *
 *  卸载控制器
 *
 *  @param name 名称
 */
-(void)unRegisterViewCtrl:(NSString *)name;

/**
 *  @Author 刘宝, 2014-12-04 12:12:59
 *
 *  卸载控制器
 *
 *  @param name 名称
 *  @param uuid 唯一值
 */
-(void)unRegisterViewCtrl:(NSString *)name withUUID:(NSString *)uuid;

/**
 *  @Author 刘宝, 2014-12-01 17:12:52
 *
 *  获取控制器
 *
 *  @param name 名称
 *
 *  @return 控制器
 */
-(UIViewController *)getViewCtrlByName:(NSString *)name;

/**
 *  @author 刘宝, 2017-01-13 10:01:00
 *
 *  获取所有注册的控制器
 *
 *  @return
 */
-(NSDictionary *)getAllViewCtrlMap;

/**
 *  @Author 刘宝, 2014-12-09 21:12:58
 *
 *  页面跳转切换
 *
 *  @param srcPageCode   模块路径名称 例如xxxx/xxxx
 *  @param destPageCode   模块路径名称 例如xxxx/xxxx
 *  @param param      参数
 *  @param animate    切换动画
 *  @param dismissSrcPageFlag 是否在源目标是弹出层的时候关闭
 */
-(void)invokeSwitchPageFrom:(NSString *)srcPageCode to:(NSString *)destPageCode param:(NSMutableDictionary *)param animate:(TDAnimate)animate dismissSrcPageFlag:(BOOL)flag;

/**
 *  @Author 刘宝, 2015-07-07 10:07:50
 *
 *  显示框架版本号
 */
-(void)showTKFRWKVersion;

@end
