//
//  TKDataPicker.h
//  TKApp
//
//  Created by liubao on 15-9-9.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-04-21 17:04:04
 *
 *  操作代理
 */
@protocol DataPikerDelegate <NSObject>

@required
/**
 *  @Author 刘宝, 2015-04-21 17:04:41
 *
 *  选中了数据
 *
 *  @param date 日期
 */
-(void)dataPikerChooseData:(NSString*)data;

@end

/**
 *  @Author 刘宝, 2015-09-09 18:09:21
 *
 *  数据选择器
 */
@interface TKDataPicker : UIView

/**
 *  @Author 刘宝, 2015-04-21 17:04:12
 *
 *  操作代理
 */
@property(nonatomic,weak)id<DataPikerDelegate> delegate;

/**
 *  @Author 刘宝, 2015-09-09 18:09:55
 *
 *  数据源
 */
@property(nonatomic,strong)NSArray *datasource;

/**
 *  @Author 刘宝, 2015-09-09 21:09:57
 *
 *  列数
 */
@property(nonatomic,assign)int column;

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
 *  @Author 刘宝, 2015-09-22 10:09:46
 *
 *  文字颜色
 */
@property(nonatomic,strong)UIColor *textColor;

/**
 *  @Author 刘宝, 2015-04-21 17:04:32
 *
 *  初始化
 *
 *  @param title   标题
 *  @param supView 父容器
 *
 *  @return
 */
-(id)initWithTitle:(NSString*)title coverView:(UIView*)supView;

/**
 *  @Author 刘宝, 2015-04-21 17:04:46
 *
 *  显示选择控件
 */
-(void)showPicker;

@end
