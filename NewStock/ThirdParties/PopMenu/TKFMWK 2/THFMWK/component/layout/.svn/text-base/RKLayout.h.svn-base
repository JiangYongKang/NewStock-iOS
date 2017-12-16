//
//  RKLayout.h
//
//  Created by Robert Kovačević on 12/17/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RKLayoutVersion 1.1

/**
 布局模式
 */
typedef enum
{
    RKLayoutModeHorizontal,
    RKLayoutModeVertical,
    RKLayoutModeGrid
} RKLayoutMode;

/**
 间隔模式
 */
typedef enum
{
    RKLayoutSpacingModeFixed,
    RKLayoutSpacingModeAuto
} RKLayoutSpacingMode;

/**
 水平布局方向
 */
typedef enum
{
    RKLayoutHorizontalAlignLeft,
    RKLayoutHorizontalAlignRight,
    RKLayoutHorizontalAlignCenter
} RKLayoutHorizontalAlign;

/**
 垂直布局方向
 */
typedef enum
{
    RKLayoutVerticalAlignTop,
    RKLayoutVerticalAlignBottom,
    RKLayoutVerticalAlignCenter
} RKLayoutVerticalAlign;

/**
 *  @Author 刘宝, 2014-12-15 10:12:10
 *
 *  布局器
 */
@interface RKLayout : UIView

/**
 *  @Author 刘宝, 2014-12-15 10:12:20
 *
 *  布局器模式
 */
@property (nonatomic, assign) RKLayoutMode layoutMode; // default is RKLayoutModeHorizontal

/**
 *  @Author 刘宝, 2014-12-15 10:12:47
 *
 *  布局器间隔模式
 */
@property (nonatomic, assign) RKLayoutSpacingMode spacingMode; // default is RKLayoutSpacingModeFixed

/**
 *  @Author 刘宝, 2014-12-15 10:12:13
 *
 *  水平布局的方向
 */
@property (nonatomic, assign) RKLayoutHorizontalAlign horizontalAlign; // default is RKLayoutHorizontalAlignLeft

/**
 *  @Author 刘宝, 2014-12-15 10:12:27
 *
 *  垂直布局的方向
 */
@property (nonatomic, assign) RKLayoutVerticalAlign verticalAlign; // default is RKLayoutVerticalAlignTop

/**
 *  @Author 刘宝, 2014-12-15 10:12:56
 *
 *  间距
 */
@property (nonatomic, assign) CGFloat spacing; // spacing between subviews, default is zero

/**
 *  @Author 刘宝, 2014-12-15 10:12:44
 *
 *  初始化
 *
 *  @param frame   大小位置
 *  @param spacing 间隔
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame withSpacing:(CGFloat)spacing;

/**
 *  @Author 刘宝, 2014-12-15 10:12:01
 *
 *  初始化
 *
 *  @param frame   大小位置
 *  @param mode    布局模式
 *  @param spacing 间隔
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame withMode:(RKLayoutMode)mode withSpacing:(CGFloat)spacing;

/**
 *  @Author 刘宝, 2014-12-15 10:12:26
 *
 *  初始化
 *
 *  @param frame 大小位置
 *  @param mode  布局模式
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame withMode:(RKLayoutMode)mode;

/**
 *  @Author 刘宝, 2014-12-15 10:12:44
 *
 *  内容大小
 *
 *  @return
 */
- (CGSize)contentSize;

@end

/**
 *  @Author 刘宝, 2014-12-15 10:12:04
 *
 *  绝对布局
 */
@interface RKLayout (RKLayoutPositioning)

/**
 *  @Author 刘宝, 2014-12-15 10:12:22
 *
 *  布局一个容积到另外一个容器的右边
 *
 *  @param view     要布局的容器
 *  @param baseView 参照的容器
 */
+ (void)positionView:(UIView*)view rightOfView:(UIView*)baseView;

/**
 *  @Author 刘宝, 2014-12-15 10:12:00
 *
 *  布局一个容器到另外一个容器的右边，留有间隔
 *
 *  @param view     要布局的容器
 *  @param baseView 参照的容器
 *  @param spacing  间隔
 */
+ (void)positionView:(UIView*)view rightOfView:(UIView*)baseView withSpacing:(CGFloat)spacing;

/**
 *  @Author 刘宝, 2014-12-15 10:12:38
 *
 *  布局一个容器到另外一个容器的左边
 *
 *  @param view     要布局的容器
 *  @param baseView 参照的容器
 */
+ (void)positionView:(UIView*)view leftOfView:(UIView*)baseView;

/**
 *  @Author 刘宝, 2014-12-15 10:12:22
 *
 *  布局一个容器到另一个容器的左边，留有间隔
 *
 *  @param view     要布局的容器
 *  @param baseView 参照的容器
 *  @param spacing  间隔
 */
+ (void)positionView:(UIView*)view leftOfView:(UIView*)baseView withSpacing:(CGFloat)spacing;

/**
 *  @Author 刘宝, 2014-12-15 10:12:00
 *
 *  布局一个容器到另一个容器的上面
 *
 *  @param view     要布局的容器
 *  @param baseView 参照的容器
 */
+ (void)positionView:(UIView*)view aboveView:(UIView*)baseView;

/**
 *  @Author 刘宝, 2014-12-15 10:12:44
 *
 *  布局一个容器到另一个容器的上面，留有间隔
 *
 *  @param view     要布局的容器
 *  @param baseView 参照的容器
 *  @param spacing  间隔
 */
+ (void)positionView:(UIView*)view aboveView:(UIView*)baseView withSpacing:(CGFloat)spacing;

/**
 *  @Author 刘宝, 2014-12-15 10:12:13
 *
 *  布局一个容器到另一个容器的下面
 *
 *  @param view     要布局的容器
 *  @param baseView 参照的容器
 */
+ (void)positionView:(UIView*)view bellowView:(UIView*)baseView;

/**
 *  @Author 刘宝, 2014-12-15 10:12:41
 *
 *  布局一个容器到另一个容器的下面，留有间隔
 *
 *  @param view     要布局的容器
 *  @param baseView 参照的容器
 *  @param spacing  间隔
 */
+ (void)positionView:(UIView*)view bellowView:(UIView*)baseView withSpacing:(CGFloat)spacing;

/**
 *  @Author 刘宝, 2014-12-15 10:12:13
 *
 *  布局一个容器到另一个容器的中心
 *
 *  @param view  要布局的容器
 *  @param frame 参照的容器
 */
+ (void)centerView:(UIView*)view inFrame:(CGRect)frame;

/**
 *  @Author 刘宝, 2014-12-15 10:12:46
 *
 *  布局一个容器到另一个容器中
 *
 *  @param view            要布局的容器
 *  @param frame           参照的容器
 *  @param horizontalAlign 水平方向
 *  @param verticalAlign   垂直方向
 */
+ (void)placeView:(UIView*)view inFrame:(CGRect)frame withHorizontalAlign:(RKLayoutHorizontalAlign)horizontalAlign withVerticalAlign:(RKLayoutVerticalAlign)verticalAlign;

@end

CG_INLINE CGRect
RKOriginRectMake(CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = 0; rect.origin.y = 0;
    rect.size.width = width; rect.size.height = height;
    return rect;
}
