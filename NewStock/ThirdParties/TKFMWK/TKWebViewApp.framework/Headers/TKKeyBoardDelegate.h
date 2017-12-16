//
//  TKKeyBoardDelegate.h
//  TKStockKeyBoardDemo
//
//  Created by liupm on 15-3-17.
//  Copyright (c) 2015年 liupm. All rights reserved.
//
/**
 键盘类型
 */
typedef enum
{
    /**
     *  @Author 刘宝, 2015-03-31 13:03:52
     *
     *  有序数字键盘
     */
    TKKeyBoardTypeNum = 0,
    /**
     *  @Author 刘宝, 2015-07-22 18:07:04
     *
     *  随机数字键盘
     */
    TKKeyBoardTypeRandNum = 1,
    /**
     *  @Author 刘宝, 2015-05-08 19:05:02
     *
     *  加强版有序数字键盘
     */
    TKKeyBoardTypeNumStrong = 2,
    /**
     *  @Author 刘宝, 2015-05-08 19:05:02
     *
     *  加强版随机数字键盘
     */
    TKKeyBoardTypeRandNumStrong = 3,
    /**
     *  @Author 刘宝, 2015-03-31 13:03:02
     *
     *  英文键盘
     */
    TKKeyBoardTypeAlpha = 4,
    /**
     *  @Author 刘宝, 2015-03-31 13:03:30
     *
     *  股票键盘
     */
    TKKeyBoardTypeStock = 5,
    /**
     *  @Author 刘宝, 2015-05-08 19:05:02
     *
     *  交易买卖键盘
     */
    TKKeyBoardTypeTrade = 6,
    /**
     *  @Author 刘宝, 2015-05-08 19:05:02
     *
     *  招商有序数字键盘
     */
    TKKeyBoardTypeMSNum  = 10,
    /**
     *  @Author 刘宝, 2015-05-08 19:05:02
     *
     *  招商随机数字键盘
     */
    TKKeyBoardTypeMSRandNum = 11,
    /**
     *  @Author 刘宝, 2015-05-08 19:05:02
     *
     *  招商英文键盘
     */
    TKKeyBoardTypeMSAlpha  = 12,
    /**
     *  @Author 刘宝, 2015-05-08 19:05:02
     *
     *  招商数字符号键盘
     */
    TKKeyBoardTypeMSNumSymbol  = 13,
    /**
     *  @Author 刘宝, 2015-05-08 19:05:02
     *
     *  招商符号键盘
     */
    TKKeyBoardTypeMSSymbol  = 14,
    /**
     *  @Author lpm, 16-10-12 14:10:33
     *
     *  @brief  一创期权通键盘深圳快速报价键盘
     */
    TKKeyBoardTypeOptionSZFast  = 20,
    
    /**
     *  @Author lpm, 16-10-12 14:10:33
     *
     *  @brief  一创期权通键盘上海快速报价键盘
     */
    TKKeyBoardTypeOptionSHFast  = 21,
    
    /**
     *  @Author lpm, 16-10-12 14:10:50
     *
     *  @brief  一创期权通深圳数字报价键盘
     */
    TKKeyBoardTypeOptionSZNum = 22,
    
    /**
     *  @Author lpm, 16-10-12 14:10:50
     *
     *  @brief  一创期权通上海数字报价键盘
     */
    TKKeyBoardTypeOptionSHNum = 23
    
}TKKeyBoardType;

/**
 * @Author 刘鹏民, 14-11-25 15:11:04
 * 键盘代理
 */
@protocol TKKeyBoardDelegate <NSObject>

@optional

/**
 *  @Author 刘宝, 2015-03-31 13:03:19
 *
 *  追加字符
 *
 *  @param str 内容
 */
- (void)appendChar:(NSString *)charStr;

/**
 *  退格删除字符
 */
- (void)deleteChar;

/**
 * @Author 刘鹏民, 14-11-27 15:11:20
 *
 * 清空值
 * @param str
 */
-(void)clearValue;

/**
 * @Author 刘鹏民, 15-03-17 16:03:08
 *
 * 点击确定
 */
-(void)doConfirm;

/**
 *  @Author 刘宝, 2015-07-22 21:07:20
 *
 *  其他键
 *
 *  @param charStr 
 */
-(void)doOtherChar:(NSString *)charStr;

/**
 * @Author 刘鹏民, 14-11-25 11:11:11
 * 隐藏自定义键盘
 */
-(void)hideKeyBoard;

/**
 * @Author 刘鹏民, 14-11-25 11:11:11
 * 显示自定义键盘
 */
-(void)showKeyBoard;

/**
 * @Author 刘鹏民, 15-03-17 15:03:43
 *
 * 切换键盘
 */
- (void)changeKeyBoard;

/**
 * @Author 刘鹏民, 15-03-17 15:03:43
 *
 * 切换到键盘
 */
- (void)changeToKeyBoard:(TKKeyBoardType)keyBoard;

/**
 * @Author 刘鹏民, 15-03-18 10:03:00
 *
 * 重新设置键盘
 */
- (void)resetKeyBoard;
@end