//
//  TKImageHelper.h
//  ios4
//
//  Created by liubao on 14-10-28.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MIRRORED ((image.imageOrientation == UIImageOrientationUpMirrored) || (image.imageOrientation == UIImageOrientationLeftMirrored) || (image.imageOrientation == UIImageOrientationRightMirrored) || (image.imageOrientation == UIImageOrientationDownMirrored))
#define ROTATED90 ((image.imageOrientation == UIImageOrientationLeft) || (image.imageOrientation == UIImageOrientationLeftMirrored) || (image.imageOrientation == UIImageOrientationRight) || (image.imageOrientation == UIImageOrientationRightMirrored))

/**
 *  图片处理帮助类
 */
@interface TKImageHelper : NSObject

/**
 *  在指定的目录里面递归查找文件，包含子目录查询
 *
 *  @param name   文件名称
 *  @param folder 目录路径
 *
 *  @return 图片
 */
+(UIImage *) imageByName:(NSString *)name inFiolder:(NSString *) folder;

/**
 *  根据图片名称查找文件，先在应用包路径下找，找不到就在沙盒里面找
 *
 *  @param name 图片名称
 *
 *  @return 图片
 */
+(UIImage *) imageByName:(NSString *)name;

/**
 *  从网络url里面获取图片
 *
 *  @param url 网络地址
 *
 *  @return 图片
 */
+(UIImage *) imageByUrl:(NSString *) url;

/**
 *  缩放图像
 *
 *  @param image 原图片
 *  @param size  缩放的矩形
 *
 *  @return 缩放后的图片
 */
+(UIImage *) imageByImage:(UIImage *)image fillSize:(CGSize)size;

/**
 *  缩放图像
 *
 *  @param image        原图片
 *  @param size         缩放的矩形
 *  @param isKeepScale  是否保持等比例
 *
 *  @return 缩放后的图片
 */
+(UIImage *) imageByImage:(UIImage *)image fillSize:(CGSize)size isKeepScale:(BOOL)isKeepScale;

/**
 *  取消图片的旋转，获得正常显示的图片
 *
 *  @param image 原图片
 *
 *  @return 还原后的图片
 */
+(UIImage *) fixOrientation:(UIImage *)image;

/**
 *  @Author 刘鹏民, 15-05-13 13:05:38
 *
 *  获取Default.png 自动判断iPhone 5
 *
 *  @param orientation 程序界面的当前旋转方向 
 *
 *  @return
 */
+ (UIImage *)defaultLaunchImage:(UIInterfaceOrientation)orientation;

/**
 *  截取屏幕
 *
 *  @param view 屏幕的View
 *
 *  @return 截屏的图片
 */
+(UIImage *) imageByView:(UIView *)view;

/**
 *  @Author 刘宝, 2015-06-04 19:06:01
 *
 *  截取整个屏幕
 *
 *  @return 截屏的图片
 */
+(UIImage *) imageByCaptureScreen;

/**
 *  得到图片的位图数据
 *
 *  @param image 图片
 *
 *  @return 位图数据
 */
+(unsigned char *)bitmapFromImage:(UIImage *)image;

/**
 *  灰化图片
 *
 *  @param image 原图片
 *
 *  @return 灰化后的图片
 */
+(UIImage *) grayImage:(UIImage *)image;

/**
 *  生成纯色的直角图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageByColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成纯色的圆角图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)roundRectImageByColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成纯色的圆角图片
 *
 *  @param color 颜色
 *  @param size  大小
 *  @param round 弧度
 *
 *  @return 图片
 */
+ (UIImage *)roundRectImageByColor:(UIColor *)color size:(CGSize)size round:(CGFloat)round;

@end
