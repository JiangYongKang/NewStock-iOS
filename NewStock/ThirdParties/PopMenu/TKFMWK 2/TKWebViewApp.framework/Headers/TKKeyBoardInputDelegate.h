//
//  TKKeyBoardInputDelegate.h
//  TKComponent_V1
//
//  Created by liubao on 15-4-7.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-04-07 12:04:49
 *
 *  自定义键盘输入框代理
 */
@protocol TKKeyBoardInputDelegate <NSObject>

@optional

/**
 * @Author 刘鹏民, 15-03-17 16:03:08
 *
 * 自定义键盘输入框，点击确定
 */
-(void)textFieldConfirm:(UITextField *)textField;

/**
 * @Author 刘鹏民, 15-03-17 16:03:08
 *
 * 自定义键盘输入框，文字改变
 */
-(void)textFieldChange:(UITextField *)textField;

/**
 *  @Author 刘宝, 2015-07-22 21:07:45
 *
 *  输入特殊字符
 *
 *  @param textField
 *  @param charStr   
 */
-(void)textField:(UITextField *)textField doOtherChar:(NSString *)charStr;

@end
