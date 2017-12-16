//
//  TKAlertHelper.h
//  TKUtil_V1
//
//  Created by liubao on 14-11-8.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  弹出窗口帮组类
 */
@interface TKAlertHelper : NSObject

/**
 *   弹出提示框
 *
 *  @param content 内容
 *  @param title   标题
 *  @param delegate 代理协议
 */
+(UIAlertView *)showAlert:(NSString *)content title:(NSString *)title delegate:(id)delegate;

/**
 *   弹出确认框
 *
 *  @param content 内容
 *  @param title   标题
 *  @param delegate 代理协议
 */
+(UIAlertView *)showConfirm:(NSString *)content title:(NSString *)title delegate:(id)delegate;

@end
