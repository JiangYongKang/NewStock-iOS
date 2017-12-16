
//
//  Created by YeJian on 13-8-12.
//  Copyright (c) 2013年 YeJian. All rights reserved.
//
#import <UIKit/UIKit.h>

/**
 *  @author 刘宝, 2016-12-31 14:12:54
 *
 *  扩展支持头部颜色的设置透明度的设置和位置的设置
 */
@interface UINavigationBar (TKAwesome)

- (void)tk_setBackgroundColor:(UIColor *)backgroundColor;

- (void)tk_setElementsAlpha:(CGFloat)alpha;

- (void)tk_setTranslationY:(CGFloat)translationY;

- (void)tk_reset;

@end

/**
 *  @Author 刘宝, 2015-04-29 13:04:32
 *
 *  自定义导航栏
 */
@interface Navbar : UINavigationBar

/**
 *  @Author 刘宝, 2015-04-29 13:04:19
 *
 *  这个是导航栏中关于状态栏的颜色,ios7以上的状态栏在内容里
 */
@property (nonatomic,strong)UIColor *stateBarColor;

/**
 *  @Author 刘宝, 2015-04-29 13:04:19
 *
 *  这个是导航栏中关于状态栏的颜色,ios7以上的状态栏在内容里
 */
@property (nonatomic,strong)UIImage *stateBarImage;

/**
 *  @Author 刘宝, 2015-07-01 12:07:18
 *
 *  状态栏颜色
 */
@property (nonatomic,strong)UIColor *barTitleColor;

/**
 *  @Author 刘宝, 2015-04-22 18:04:11
 *
 *  导航栏的背景颜色
 */
@property (nonatomic,strong)UIColor *backgroundColor;

/**
 *  @Author 刘宝, 2015-08-24 19:08:53
 *
 *  导航栏背景图片
 */
@property (nonatomic,strong)UIImage *backgroundImage;

/**
 *  @Author 刘宝, 2015-04-29 22:04:14
 *
 *  导航栏的样式
 */
@property (nonatomic,assign)UIBarStyle cusBarStyle;

/**
 *  @Author 刘宝, 2015-01-30 11:01:56
 *
 *  设置默认的颜色和背景色，样式等配置
 */
- (void)setDefault;

@end

/**
 导航栏的按钮类型
 */
typedef enum
{
    /**
     *  @Author 刘宝, 2015-04-29 17:04:45
     *
     *  默认按钮
     */
    NavBarButtonItemTypeDefault = 0,
    /**
     *  @Author 刘宝, 2015-04-29 17:04:02
     *
     *  返回按钮
     */
    NavBarButtonItemTypeBack = 1
    
}NavBarButtonItemType;

/**
 *  @Author 刘宝, 2015-04-29 17:04:42
 *
 *  自定义导航栏按钮，用来生成导航栏按钮
 */
@interface NavBarButtonItem : NSObject

/**
 *  @Author 刘宝, 2015-04-29 17:04:59
 *
 *  按钮类型
 */
@property (nonatomic,assign)NavBarButtonItemType itemType;

/**
 *  @Author 刘宝, 2015-04-29 17:04:42
 *
 *  生成的按钮对象
 */
@property (nonatomic,readonly)UIButton *button;

/**
 *  @Author 刘宝, 2015-04-29 17:04:21
 *
 *  按钮上的文字
 */
@property (nonatomic,strong)NSString *title;

/**
 *  @Author 刘宝, 2015-04-29 17:04:40
 *
 *  按钮的背景图片
 */
@property (nonatomic,strong)NSString *image;

/**
 *  @Author 刘宝, 2015-04-29 17:04:51
 *
 *  按钮的字体
 */
@property (nonatomic,strong)UIFont *font;

/**
 *  @Author 刘宝, 2015-04-29 18:04:46
 *
 *  正常文字颜色
 */
@property (nonatomic,strong)UIColor *normalColor;

/**
 *  @Author 刘宝, 2015-04-29 18:04:03
 *
 *  选中文字的颜色
 */
@property (nonatomic,strong)UIColor *selectedColor;

/**
 *  @Author 刘宝, 2015-04-29 18:04:19
 *
 *  设置高亮状态
 */
@property (nonatomic,assign)BOOL highlightedWhileSwitch;

/**
 *  @Author 刘宝, 2015-04-29 22:04:28
 *
 *  生成默认的文字按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param title  文字
 *
 *  @return 文字按钮
 */
+ (id)defauleItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

/**
 *  @Author 刘宝, 2015-04-29 22:04:21
 *
 *  生成默认的图片按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param image  图片名称
 *
 *  @return 图片按钮
 */
+ (id)defauleItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;

/**
 *  @Author 刘宝, 2015-04-29 22:04:07
 *
 *  生成回退按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param title  文字
 *
 *  @return 回退按钮
 */
+ (id)backItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

@end

/**
 *  @Author 刘宝, 2015-04-30 00:04:18
 *
 *  导航栏子容器对象
 */
@interface UINavigationItem (CustomBarButtonItem)

/**
 *  @Author 刘宝, 2015-04-30 00:04:47
 *
 *  设置文字标题
 *
 *  @param title 文字
 */
- (void)setNewTitle:(NSString *)title;

/**
 *  @Author 刘宝, 2015-04-30 00:04:24
 *
 *  设置标题图片
 *
 *  @param image 图片
 */
- (void)setNewTitleImage:(UIImage *)image;

/**
 *  @Author 刘宝, 2015-04-30 00:04:54
 *
 *  设置左边普通文字按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param title  文字
 */
- (void)setLeftItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

/**
 *  @Author 刘宝, 2015-04-30 00:04:46
 *
 *  设置左边图片按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param image  图片
 */
- (void)setLeftItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;

/**
 *  @Author 刘宝, 2015-04-30 00:04:04
 *
 *  设置左边按钮
 *
 *  @param item 按钮对象
 */
- (void)setLeftItemWithButtonItem:(NavBarButtonItem *)item;

/**
 *  @Author 刘宝, 2015-04-30 00:04:21
 *
 *  设置右边文本按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param title  文本
 */
- (void)setRightItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

/**
 *  @Author 刘宝, 2015-04-30 00:04:17
 *
 *  设置右边图片按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param image  图片
 */
- (void)setRightItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;

/**
 *  @Author 刘宝, 2015-04-30 00:04:10
 *
 *  设置右边按钮
 *
 *  @param item 按钮对象
 */
- (void)setRightItemWithButtonItem:(NavBarButtonItem *)item;

/**
 *  @Author 刘宝, 2015-04-30 00:04:40
 *
 *  设置后退按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 */
- (void)setBackItemWithTarget:(id)target action:(SEL)action;

/**
 *  @Author 刘宝, 2015-04-30 00:04:23
 *
 *  设置后退按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param title  文字
 */
- (void)setBackItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

/**
 *  @Author 刘宝, 2015-04-30 00:04:19
 *
 *  设置后退按钮
 *
 *  @param target 代理类
 *  @param action 代理方法
 *  @param image  图片
 */
- (void)setBackItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;

/**
 * 设置导航左侧按钮
 * @param target 代理对象
 * @param action 事件
 * @param image  图片
 * @param space  间隔
 */
- (void)setLeftItemWithTarget:(id)target action:(SEL)action image:(NSString *)image space:(CGFloat)space;

/**
 *  @Author 刘宝, 2015-04-23 14:04:55
 *
 *  设置导航左侧的按钮
 *
 *  @param target 代理对象
 *  @param action 动作事件
 *  @param title  标题
 *  @param space  间隔
 */
- (void)setLeftItemWithTarget:(id)target action:(SEL)action title:(NSString *)title space:(CGFloat)space;

/**
 * 设置导航右侧按钮
 * @param target 代理对象
 * @param action 事件
 * @param image  图片
 * @param space  间隔
 */
- (void)setRightItemWithTarget:(id)target action:(SEL)action image:(NSString *)image space:(CGFloat)space;

/**
 *  @Author 刘宝, 2015-04-23 14:04:55
 *
 *  设置导航右侧的按钮
 *
 *  @param target 代理对象
 *  @param action 动作事件
 *  @param title  标题
 *  @param space  间隔
 */
- (void)setRightItemWithTarget:(id)target action:(SEL)action title:(NSString *)title space:(CGFloat)space;

/**
 * 设置右侧加载按钮
 * @param space 右侧间距
 */
- (void)setRightItemWithLoadingSpace:(CGFloat)space;

@end
