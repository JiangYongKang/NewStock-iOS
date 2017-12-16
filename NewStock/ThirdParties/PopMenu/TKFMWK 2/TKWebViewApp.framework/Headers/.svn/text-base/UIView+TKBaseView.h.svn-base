//
//  UIView+TKBaseView.h
//  TKApp
//
//  Created by liubao on 14-12-2.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TKKeyBoard;

/**
 *  @Author 刘宝, 2014-12-02 10:12:59
 *
 *  基础view
 */
@interface UIView (TKBaseView)

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
 *  @Author 刘宝, 2014-12-12 12:12:00
 *
 *  获取子view
 *
 *  @param name 名称
 *
 *  @return
 */
-(UIView *)getChildViewByName:(NSString *)name;

/**
 *  @Author 刘宝, 2014-12-02 12:12:49
 *
 *  刷新当前页面
 */
- (void)fresh;

/**
 *  @Author 刘宝, 2014-12-16 12:12:56
 *
 *  初始化界面
 */
-(void)loadView;

/**
 *  隐藏键盘
 *  @param textfield 输入框
 */
-(void)closeSystemKeyBoard:(UITextField *)textfield;

/**
 *  @Author 刘宝, 2015-04-10 12:04:15
 *
 *  获取窗口中得键盘对象
 *
 *  @return
 */
- (NSArray *)getSystemKeyBoardViews;

/**
 *  @Author 刘宝, 2015-04-23 19:04:37
 *
 *  关闭系统键盘
 */
- (void)closeSystemKeyBoard;

/**
 *  获得父控制器
 */
- (UIViewController *)getViewController;

/**
 *  @Author 刘宝, 2015-04-21 00:04:25
 *
 *  获取H5键盘
 *
 *  @return
 */
-(TKKeyBoard *)getH5KeyBoard;

/**
 *  @Author 刘宝, 2015-04-23 19:04:37
 *
 *  关闭H5键盘
 */
- (void)closeH5KeyBoard;

@end
