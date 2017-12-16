//
//  TabView.h
//  TKComponent_V1
//
//  Created by liubao on 15-9-10.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @Author 刘宝, 2014-11-26 10:11:11
 *
 *  分割标示相对分割线的位置
 */
typedef enum{
    TKTabViewIndicatorPosition_Top = 0,
    TKTabViewIndicatorPosition_Middle = 1,
    TKTabViewIndicatorPosition_Buttom = 2
}TKTabViewIndicatorPosition;

/**
 *  @Author 刘宝, 2015-09-10 03:09:52
 *
 *  tab切换头
 */
@interface TKTabView : UIView

/**
 *  @Author 刘宝, 2015-09-10 03:09:06
 *
 *  是否选择
 */
@property (nonatomic, getter = isSelected) BOOL selected;

/**
 *  @Author 刘宝, 2015-09-10 03:09:15
 *
 *  分割线颜色
 */
@property (nonatomic,retain) UIColor *indicatorColor;

/**
 *  @Author 刘宝, 2015-09-10 03:09:15
 *
 *  上下分割线的颜色
 */
@property (nonatomic,retain) UIColor *indicatorLineColor;

/**
 *  @Author 刘宝, 2015-09-10 03:09:33
 *
 *  当前选择的背景色
 */
@property (nonatomic,retain) UIColor *currentTabSelectedColor;

/**
 *  @Author 刘宝, 2015-09-10 03:09:45
 *
 *  当前选择文字颜色
 */
@property (nonatomic,retain) UIColor *currentTabSelectedTextColor;

/**
 *  @Author 刘宝, 2015-09-10 03:09:55
 *
 *  没有选择的背景色
 */
@property (nonatomic,retain) UIColor *currentTabNormalColor;

/**
 *  @Author 刘宝, 2015-09-10 03:09:16
 *
 *  没有选择的背景颜色
 */
@property (nonatomic,retain) UIColor *currentTabNormalTextColor;

/**
 *  @author 刘宝, 2016-05-31 14:05:45
 *
 *  顶部线的高度
 */
@property (nonatomic,assign)CGFloat topLineHeight;

/**
 *  @author 刘宝, 2016-05-31 14:05:02
 *
 *  底部线的高度
 */
@property (nonatomic,assign)CGFloat buttomLineHeight;

/**
 *  @Author 刘宝, 2015-09-10 03:09:15
 *
 *  标示线的高度
 */
@property (nonatomic,assign) CGFloat indicatorHeight;

/**
 *  @Author 刘宝, 2015-09-10 03:09:15
 *
 *  标示线的宽度
 */
@property (nonatomic,assign) CGFloat indicatorWidth;

/**
 *  @author 刘宝, 2016-07-18 15:07:42
 *
 *  分割标示相对分割线的位置
 */
@property(nonatomic,assign) TKTabViewIndicatorPosition indicatorPosition;

/**
 *  @author 刘宝, 2016-11-25 15:11:31
 *
 *  获取分割线对象
 *
 *  @return
 */
-(UIView *)getIndicatorLabel;

@end