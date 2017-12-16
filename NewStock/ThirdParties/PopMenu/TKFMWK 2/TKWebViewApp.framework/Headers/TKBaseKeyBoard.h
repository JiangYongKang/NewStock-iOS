//
//  TKBaseKeyBoard.h
//  TKComponent_V1
//
//  Created by liubao on 15-4-3.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+TKBaseView.h"
#import "TKKeyBoardDelegate.h"
#import "RKLayout.h"
#import "TKKeyBoardThemeManager.h"

/**
 *  @Author 刘宝, 2015-04-07 10:04:47
 *
 *  键盘高度
 */
#define KEYBOARD_HEIGHT 215

/**
 *  @Author 刘宝, 2015-04-03 20:04:27
 *
 *  基础键盘
 */
@interface TKBaseKeyBoard : UIView<TKKeyBoardDelegate>

/**
 *  @Author 刘宝, 2015-04-01 09:04:26
 *
 *  确定按钮是否可用
 */
@property(nonatomic) BOOL confirmEnable;

/**
 *  @Author 刘宝, 2015-04-01 09:04:42
 *
 *  中英文切换按钮是否可用
 */
@property(nonatomic) BOOL changeEnable;

/**
 *  @Author 刘宝, 2015-04-01 09:04:13
 *
 *  确定按钮内容
 */
@property(nonatomic,strong) NSString *confirmStr;

/**
 *  @Author 刘宝, 2015-04-07 09:04:02
 *
 *  键盘类型
 */
@property(nonatomic)TKKeyBoardType tkKeyboardType;

/**
 *  @Author 刘宝, 2015-04-03 20:04:16
 *
 *  键盘代理
 */
@property(nonatomic,weak) id<TKKeyBoardDelegate>delegate;

/**
 *  @Author 刘宝, 2015-07-22 18:07:13
 *
 *  是否随机数字键盘
 */
@property (nonatomic,assign)BOOL isRandom;

/**
 *  @author 刘宝, 2016-05-09 15:05:56
 *
 *  标题
 */
@property(nonatomic,copy)NSString *keyboardTitle;

/**
 *  @author 刘宝, 2016-05-09 15:05:54
 *
 *  获取头
 *
 *  @return
 */
-(UIView *)getKeyboardTitleView;

/**
 *  @author 刘宝, 2016-10-19 11:10:58
 *
 *  处理键盘的显示状态
 *
 *  @param isShow
 */
-(void)initShow:(BOOL)isShow;

@end
