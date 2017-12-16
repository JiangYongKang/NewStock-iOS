//
//  TKDatePicker.h
//  TKComponent_V1
//
//  Created by liubao on 15-4-21.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-04-21 17:04:04
 *
 *  操作代理
 */
@protocol DatePikerDelegate <NSObject>

@required
/**
 *  @Author 刘宝, 2015-04-21 17:04:41
 *
 *  选中了日期
 *
 *  @param date 日期
 */
-(void)datePikerChooseDate:(NSDate*)date;

@end

/**
 *  @Author 刘宝, 2015-04-21 17:04:36
 *
 *  日期选择器
 */
@interface TKDatePicker : UIView

/**
 *  @Author 刘宝, 2015-04-21 17:04:57
 *
 *  日期控件
 */
@property(nonatomic,strong)UIDatePicker *datePicker;

/**
 *  @Author 刘宝, 2015-04-21 17:04:12
 *
 *  操作代理
 */
@property(nonatomic,weak)id<DatePikerDelegate> delegate;

/**
 *  @Author 刘宝, 2015-09-22 10:09:38
 *
 *  按钮颜色
 */
@property(nonatomic,strong)UIColor *btnColor;

/**
 *  @Author 刘宝, 2015-09-22 10:09:18
 *
 *  按钮标题颜色
 */
@property(nonatomic,strong)UIColor *btnTextColor;

/**
 *  @Author 刘宝, 2015-09-22 10:09:07
 *
 *  背景颜色
 */
@property(nonatomic,strong)UIColor *bgColor;

/**
 *  @Author 刘宝, 2015-04-21 17:04:32
 *
 *  初始化
 *
 *  @param title   标题
 *  @param mode    类型
 *  @param supView 父容器
 *
 *  @return 
 */
-(id)initWithTitle:(NSString*)title mode:(UIDatePickerMode)mode coverView:(UIView*)supView;

/**
 *  @Author 刘宝, 2015-04-21 17:04:46
 *
 *  显示日期控件
 */
-(void)showPicker;

@end
