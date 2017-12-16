//
//  TKOptionKeyBoardBar.h
//  TKKeyboardDemo
//
//  Created by liupm on 16/10/12.
//  Copyright © 2016年 liupm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKOptionKeyBoardBarDelegate <NSObject>

/**
 *  @Author lpm, 16-10-12 15:10:33
 *
 *  @brief  切换键盘
 *
 *  @param selectIndex 选中键盘的索引
 */
-(void)switchKeyBoard:(NSInteger)selectIndex;


/**
 *  @Author lpm, 16-10-12 15:10:53
 *
 *  @brief
 *
 *  @param isFok
 */
-(void)doFok:(BOOL)isFok;

@end

/**
 *  @author 刘宝, 2016-10-18 06:10:16
 *
 *  顶部标题菜单
 */
@interface TKOptionKeyBoardBar : UIView

/**
 *  @author 刘宝, 2016-10-18 10:10:51
 *
 *  是否fok
 */
@property(nonatomic,assign)BOOL isFok;

/**
 *  @author 刘宝, 2016-10-18 06:10:00
 *
 *  0是快速报价 1是键盘报价 默认是0
 */
@property(nonatomic,assign) NSInteger selectIndex;

/**
 *  @author 刘宝, 2016-10-18 06:10:16
 *
 *  点击代理
 */
@property(nonatomic,weak) id<TKOptionKeyBoardBarDelegate> delegate;

@end