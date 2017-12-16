//
//  TKLayerView.h
//  TKComponent
//
//  Created by liubao on 14-11-15.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKMBProgressHUD.h"

/**
 位置
 */
typedef enum {
    /**
     * 顶部
     */
    TKLayerPosition_Top,
    /**
     * 中间
     */
    TKLayerPosition_Center,
    /**
     *  @Author 刘宝, 2016-03-01 18:03:20
     *
     *  底部
     */
    TKLayerPosition_Bottom
}TKLayerPosition;

/**
 *  相关弹层组件
 */
@interface TKLayerView:NSObject

/**
 *  @Author 刘宝, 2015-01-04 14:01:32
 *
 *  是否显示加深的背景色
 */
@property(nonatomic,assign)BOOL isDimBackground;

/**
 *  显示缓冲等待层
 *
 *  @param content   显示文本
 */
-(void)showLoading:(NSString *)content;

/**
 *  显示缓冲等待层
 */
-(void)showLoading;

/**
 * 隐藏缓冲等待层
 */
-(void)hideLoading;

/**
 *  显示短消息提示
 *
 *  @param content 提示的信息
 */
-(void)showTip:(NSString *)content;

/**
 *  显示短消息提示
 *
 *  @param content 提示的信息
 */
-(void)showTip:(NSString *)content position:(TKLayerPosition)position;

/**
 *  @Author 刘宝, 2015-01-04 14:01:10
 *
 *  显示文本提示
 *
 *  @param content 内容
 */
-(void)showText:(NSString *)content;

/**
 *  @Author 刘宝, 2015-01-04 14:01:17
 *
 *  显示进度条,记得用完要隐藏进度条
 *
 *  @return
 */
-(TKMBProgressHUD *)showProgressHUD;

/**
 *  弹出确认框
 *
 *  @param content 内容
 *  @param title 标题
 *  @param confirmAction 确认动作
 *  @param cancelAction  取消动作
 */
-(void)showConfirm:(NSString *)content title:(NSString *)title confirmAction:(void(^)())confirmAction cancelAction:(void(^)())cancelAction;

/**
 *  @Author 刘宝, 2015-05-06 22:05:01
 *
 *  弹出确认框
 *
 *  @param content       内容
 *  @param title         标题
 *  @param confirmAction 确认动作
 *  @param cancelAction  取消动作
 *  @param confirmBtn    确认按钮
 *  @param cancelBtn     取消按钮
 */
-(void)showConfirm:(NSString *)content title:(NSString *)title confirmAction:(void(^)())confirmAction cancelAction:(void(^)())cancelAction confirmBtn:(NSString *)confirmBtn cancelBtn:(NSString *)cancelBtn;

/**
 *  弹出提示框
 *
 *  @param content 内容
 *  @param title 标题
 *  @param closeAction  关闭动作
 */
-(void)showAlert:(NSString *)content title:(NSString *)title closeAction:(void(^)())closeAction;

/**
 *  弹出提示框
 *
 *  @param content 内容
 *  @param title 标题
 *  @param closeAction  关闭动作
 *  @param isClose      是否关闭
 */
-(void)showAlert:(NSString *)content title:(NSString *)title closeAction:(void(^)())closeAction isClose:(BOOL)isClose;

/**
 *  弹出提示框
 *
 *  @param content 内容
 *  @param title 标题
 *
 */
-(void)showAlert:(NSString *)content title:(NSString *)title;

/**
 *  弹出提示框
 *
 *  @param content      内容
 *  @param title        标题
 *  @param buttonText   按钮文本
 *  @param closeAction  关闭动作
 */
-(void)showAlert:(NSString *)content title:(NSString *)title buttonText:(NSString *)buttonText closeAction:(void(^)())closeAction;

/**
 *  弹出提示框
 *
 *  @param content      内容
 *  @param title        标题
 *  @param buttonText   按钮文本
 *  @param closeAction  关闭动作
 *  @param isClose      是否关闭
 */
-(void)showAlert:(NSString *)content title:(NSString *)title buttonText:(NSString *)buttonText closeAction:(void(^)())closeAction isClose:(BOOL)isClose;

/**
 *  初始化弹出组件
 *
 *  @param frame 区域范围
 *  @param contentView 操作内容面板
 *  @param btnTextColor  按钮文字颜色
 *
 *  @return
 */
-(id)initContentView:(UIView *)contentView withBtnTextColor:(NSString *)btnTextColor;

/**
 *  初始化弹出组件
 *
 *  @param frame 区域范围
 *  @param contentView 操作内容面板
 *  @param btnTextColor  按钮文字颜色
 *  @param cancelBtnTextColor  取消按钮文字颜色
 *
 *  @return
 */
-(id)initContentView:(UIView *)contentView withBtnTextColor:(NSString *)btnTextColor cancelBtnTextColor:(NSString *)cancelBtnTextColor;

/**
 *  @Author 刘宝, 2015-06-10 20:06:49
 *
 *  设置弹出层的最大宽度和最大宽度
 *
 *  @param maxWidth  最大宽度
 *  @param maxHeight 最大高度
 */
-(void)setAlertConfirmMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

@end
