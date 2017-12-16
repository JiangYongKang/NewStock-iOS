//
//  UIViewController+TKBaseViewController.h
//  TKApp
//
//  Created by liubao on 14-11-21.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKMesageDelegate.h"
#import "TKAppInvokeDelegate.h"
#include "TKModuleDelegate.h"
#import "TKComponent.h"

/**
 *  @author 刘宝, 2016-07-24 18:07:53
 *
 *  方法绑定交换
 *
 *  @param c
 *  @param origSEL
 *  @param newSEL
 */
void TKSwizzlingMethod(Class c, SEL origSEL, SEL newSEL);

/**
 *  扩展UIViewController
 */
@interface UIViewController (TKBaseViewController)<TKMesageDelegate,UIGestureRecognizerDelegate,TKModuleDelegate>

/**
 *  @Author 刘宝, 2015-06-19 16:06:54
 *
 *  是否显示
 */
@property(nonatomic,readonly)BOOL isShow;

/**
 *  @Author 刘宝, 2014-12-01 21:12:41
 *
 *  名称
 */
@property (nonatomic,copy)NSString *name;

/**
 *  @Author 刘宝, 2014-12-02 09:12:12
 *
 *  用户信息
 */
@property (nonatomic,retain)NSMutableDictionary *userInfo;

/**
 *  @Author 刘宝, 2015-06-11 12:06:22
 *
 *  前一个页面控制器的路径
 */
@property (nonatomic,copy)NSString *prevPageCode;

/**
 *  @Author 刘宝, 2014-12-04 10:12:50
 *
 *  唯一id
 */
@property (nonatomic,readonly,copy)NSString *uuid;

/**
 *  @author 刘宝, 2016-06-30 17:06:50
 *
 *  控制器标示
 */
@property (nonatomic,assign)NSUInteger tag;

/**
 *  @Author 刘宝, 2014-12-10 14:12:38
 *
 *  当前显示的子控制器
 */
@property (nonatomic,retain)UIViewController *currentChildViewCtrl;

/**
 *  @Author 刘宝, 2015-08-24 16:08:05
 *
 *  是否已经弹出
 */
@property (nonatomic,assign)BOOL isPopUp;

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
 *  @Author 刘宝, 2014-12-02 10:12:35
 *
 *  根据名称初始化
 *
 *  @param name 名称
 *
 *  @return 
 */
-(id)initWithName:(NSString *)name;

/**
 *  注册监听动作函数
 */
-(void)onRegister;

/**
 *  @Author 刘宝, 2014-12-01 20:12:26
 *
 *  处理屏幕触摸
 *
 *  @param point 位置
 */
-(void)handleScreenTouch:(CGPoint)point;

/**
 *  @Author 刘宝, 2015-04-23 00:04:56
 *
 *  显示系统键盘
 */
- (void)showSystemKeyBoard;

/**
 *  @Author 刘宝, 2015-04-23 00:04:26
 *
 *  隐藏系统键盘
 */
- (void)hideSystemKeyBoard;

/**
 *  @Author 刘宝, 2015-04-23 00:04:33
 *
 *  监听系统键盘弹出
 */
- (void)listenSystemKeyBoardShow;

/**
 *  @Author 刘宝, 2015-04-23 00:04:52
 *
 *  取消监听系统键盘弹出
 */
- (void)unListenSystemKeyBoardShow;

/**
 *  @Author 刘宝, 2015-06-11 14:06:55
 *
 *  页面切换跳转
 *
 *  @param srcModuleName  原页面模块名称
 *  @param destModuleName 目标页面模块名称
 *  @param param          参数
 *  @param animate        动画
 */
-(BOOL)switchPageFrom:(NSString *)srcModuleName to:(NSString *)destModuleName param:(NSMutableDictionary *)param animate:(TDAnimate)animate;

/**
 *  @Author 刘宝, 2014-12-09 21:12:58
 *
 *  页面跳转切换
 *
 *  @param moduleName 模块名称
 *  @param param      参数
 *  @param animate    切换动画
 */
-(BOOL)switchPage:(NSString *)moduleName param:(NSMutableDictionary *)param animate:(TDAnimate)animate;

/**
 *  获得父控制器
 */
- (UIViewController *)getParentViewCtrl;

/**
 *  @Author 刘宝, 2014-12-03 09:12:43
 *
 *  获取子控制器
 *
 *  @param name 名称
 *
 *  @return 子控制器
 */
-(UIViewController *)getChildViewController:(NSString *)name;

/**
 *  关闭系统键盘
 *  @param textfield 输入框
 */
-(void)closeSystemKeyBoard:(UITextField *)textfield;

/**
 *  @Author 刘宝, 2014-12-02 12:12:49
 *
 *  刷新当前页面
 */
- (void)fresh;

/**
 *  注册消息
 */
-(void)onRegisterNotificationInter;

/**
 *  @Author 刘宝, 2014-12-16 21:12:25
 *
 *  添加子控制器
 *
 *  @param childViewCtrls 子控制器
 */
-(void)addChildViewControllers:(NSArray *)childViewCtrls;

/**
 *  @Author 刘宝, 2015-04-10 12:04:15
 *
 *  获取窗口中得键盘对象
 *
 *  @return
 */
- (NSArray *)getSystemKeyBoardViews;

/**
 *  @Author 刘宝, 2015-04-21 00:04:25
 *
 *  获取H5键盘
 *
 *  @return
 */
-(TKKeyBoard *)getH5KeyBoard;

/**
 *  获得页面路径
 */
- (NSString *)getPageCode;

/**
 *  @Author 刘宝, 2015-06-11 15:06:34
 *
 *  添加手势,默认这个方法是水平方向手势
 */
-(void)addSwipeGestureRecognizer;

/**
 *  @Author 刘宝, 2015-08-28 13:08:59
 *
 *  添加手势
 *
 *  @param isHorizontal 是否水平滑动手势
 */
-(void)addSwipeGestureRecognizer:(BOOL)isHorizontal;

/**
 *  @Author 刘宝, 2015-06-12 14:06:53
 *
 *  删除滑动手势
 */
-(void)removeSwipGestureRecognizer;

/**
 *  @Author 刘宝, 2015-06-11 15:06:01
 *
 *  处理滑动手势
 *
 *  @param recognizer
 */
//-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
-(void)handleSwipeFrom:(UITapGestureRecognizer *)recognizer;

/**
 *  @Author 刘宝, 2015-08-19 19:08:35
 *
 *  是否弹出控制器
 *
 *  @return
 */
-(BOOL)isPopController;

/**
 *  @Author 刘宝, 2015-08-25 19:08:11
 *
 *  获取根父亲控制器
 *
 *  @return
 */
-(UIViewController *)getRootParentViewCtrl;

@end
