//
//  TKImageClipEditorController.h
//  TKAppBase_V1
//
//  Created by liubao on 15-7-23.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKBaseViewController.h"

@class TKImageClipEditorController;

/**
 *  @Author 刘宝, 2015-07-23 23:07:22
 *
 *  编辑代理方法
 */
@protocol TKImageClipEditorDelegate <NSObject>

/**
 *  @Author 刘宝, 2015-07-23 23:07:32
 *
 *  编辑完成
 *
 *  @param imageEditorViewController
 *  @param editedImage
 */
- (void)imageEdit:(TKImageClipEditorController *)imageEditorViewController didFinished:(UIImage *)editedImage;

/**
 *  @Author 刘宝, 2015-07-23 23:07:47
 *
 *  编辑取消
 *
 *  @param imageEditorViewController
 */
- (void)imageEditDidCancel:(TKImageClipEditorController *)imageEditorViewController;

@end

/**
 *  @Author 刘宝, 2015-07-23 19:07:42
 *
 *  增强版裁剪编辑器
 */
@interface TKImageClipEditorController : TKBaseViewController

/**
 *  @Author 刘宝, 2015-07-23 19:07:03
 *
 *  原始图片
 */
@property (nonatomic,retain)UIImage *image;

/**
 *  @Author 刘宝, 2015-07-23 23:07:17
 *
 *  代理对象
 */
@property (nonatomic, weak) id<TKImageClipEditorDelegate> delegate;

/**
 *  @Author 刘宝, 2015-07-28 13:07:00
 *
 *  状态栏背景颜色
 */
@property(nonatomic,retain)UIColor *statusBarBgColor;

@end
