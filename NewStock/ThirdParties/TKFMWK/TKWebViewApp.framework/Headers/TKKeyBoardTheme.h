//
//  TKKeyBoardTheme.h
//  TKComponent_V1
//
//  Created by liubao on 15-5-7.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @Author 刘宝, 2015-05-07 17:05:32
 *
 *  键盘主题
 */
@interface TKKeyBoardTheme : NSObject

/**
 *  @Author 刘宝, 2015-05-07 17:05:10
 *
 *  数字键盘按钮文字默认颜色
 */
@property (nonatomic,retain)UIColor *TKNumKeyBoard_Btn_Color;

/**
 *  @Author 刘宝, 2015-05-07 17:05:11
 *
 *  数字键盘按钮文字高亮颜色
 */
@property (nonatomic,retain)UIColor *TKNumKeyBoard_Btn_Highlight_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:13
 *
 *  数字键盘普通按钮背景颜色
 */
@property (nonatomic,retain)UIColor *TKNumKeyBoard_Btn_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:13
 *
 *  数字键盘业务按钮背景颜色
 */
@property (nonatomic,retain)UIColor *TKNumKeyBoard_Btn_Other_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:32
 *
 *  数字键盘按钮高亮颜色
 */
@property (nonatomic,retain)UIColor *TKNumKeyBoard_Btn_Highlight_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:32
 *
 *  数字键盘背景色
 */
@property (nonatomic,retain)UIColor *TKNumKeyBoard_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 17:05:10
 *
 *  字母键盘按钮文字默认颜色
 */
@property (nonatomic,retain)UIColor *TKAlphaKeyBoard_Btn_Color;

/**
 *  @Author 刘宝, 2015-05-07 17:05:11
 *
 *  字母键盘按钮文字高亮颜色
 */
@property (nonatomic,retain)UIColor *TKAlphaKeyBoard_Btn_Highlight_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:46
 *
 *  字母键盘业务按钮背景颜色
 */
@property (nonatomic,retain)UIColor *TKAlphaKeyBoard_Btn_Other_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:46
 *
 *  字母键盘普通按钮背景颜色
 */
@property (nonatomic,retain)UIColor *TKAlphaKeyBoard_Btn_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:46
 *
 *  字母键盘提示框背景图
 */
@property (nonatomic,copy)NSString *TKAlphaKeyBoard_Tip_Background_Image;

/**
 *  @Author 刘宝, 2015-05-07 18:05:46
 *
 *  字母键盘删除键盘背景图
 */
@property (nonatomic,copy)NSString *TKAlphaKeyBoard_Delete_Background_Image;

/**
 *  @author 刘宝, 2016-05-08 10:05:54
 *
 *  字母键盘删除键盘高亮背景图
 */
@property (nonatomic,copy)NSString *TKAlphaKeyBoard_Delete_Highlight_Background_Image;

/**
 *  @Author 刘宝, 2015-05-07 18:05:46
 *
 *  字母键盘大写键盘背景图
 */
@property (nonatomic,copy)NSString *TKAlphaKeyBoard_Up_Background_Image;

/**
 *  @Author 刘宝, 2015-05-07 18:05:46
 *
 *  字母键盘小写键盘背景图
 */
@property (nonatomic,copy)NSString *TKAlphaKeyBoard_Lower_Background_Image;

/**
 *  @author 刘宝, 2016-05-09 12:05:18
 *
 *  字母键盘输入法切换按钮背景图
 */
@property (nonatomic,copy)NSString *TKAlphaKeyBoard_Change_Background_Image;

/**
 *  @author 刘宝, 2016-05-09 12:05:42
 *
 *  字母键盘输入法切换按钮高亮背景图
 */
@property (nonatomic,copy)NSString *TKAlphaKeyBoard_Change_Highlight_Background_Image;

/**
 *  @Author 刘宝, 2015-05-07 18:05:32
 *
 *  字母键盘背景色
 */
@property (nonatomic,retain)UIColor *TKAlphaKeyBoard_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:17
 *
 *  股票键盘按钮默认文字颜色
 */
@property (nonatomic,retain)UIColor *TKStockKeyBoard_Btn_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:17
 *
 *  股票键盘按钮高亮文字颜色
 */
@property (nonatomic,retain)UIColor *TKStockKeyBoard_Btn_Highlight_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:32
 *
 *  股票键盘按钮高亮颜色
 */
@property (nonatomic,retain)UIColor *TKStockKeyBoard_Btn_Highlight_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:13
 *
 *  股票键盘业务按钮背景颜色
 */
@property (nonatomic,retain)UIColor *TKStockKeyBoard_Btn_Other_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:13
 *
 *  股票键盘普通按钮背景颜色
 */
@property (nonatomic,retain)UIColor *TKStockKeyBoard_Btn_Background_Color;

/**
 *  @Author 刘宝, 2015-05-07 18:05:32
 *
 *  股票键盘背景色
 */
@property (nonatomic,retain)UIColor *TKStockKeyBoard_Background_Color;

/**
 *  @author 刘宝, 2016-05-08 14:05:47
 *
 *  招商数字键盘的切换图片
 */
@property (nonatomic,copy)NSString *TKMSNumKeyBoard_Change_Background_Image;

/**
 *  @author 刘宝, 2016-05-08 14:05:41
 *
 *  招商数字键盘的切换高亮图片
 */
@property (nonatomic,copy)NSString *TKMSNumKeyBoard_Change_Highlight_Background_Image;

/**
 *  @Author 刘宝, 2015-05-07 18:05:32
 *
 *   招商数字键盘其它按钮颜色
 */
@property (nonatomic,retain)UIColor *TKMSNumKeyBoard_Btn_Other_Background_Color;

/**
 *  @author 刘宝, 2016-05-09 15:05:50
 *
 *  标题背景色
 */
@property (nonatomic,retain)UIColor *TKMSNumKeyBoard_Title_Background_Color;

/**
 *  @author 刘宝, 2016-05-09 15:05:50
 *
 *  标题文字颜色
 */
@property (nonatomic,retain)UIColor *TKMSNumKeyBoard_Title_Color;

@end