//
//  TKOptionNumKeyBoard.h
//  TKKeyboardDemo
//
//  Created by liupm on 16/10/12.
//  Copyright © 2016年 liupm. All rights reserved.
//

#import "TKMSNumKeyBoard.h"

/**
 *  @author 刘宝, 2016-10-18 09:10:30
 *
 *  市场类型
 */
typedef enum{
    TKOptionNumKeyBoardMarket_SZ,
    TKOptionNumKeyBoardMarket_SH
}TKOptionNumKeyBoardMarket;

/**
 *  @author 刘宝, 2016-10-18 07:10:02
 *
 *  第一创业期货数字键盘
 */
@interface TKOptionNumKeyBoard : TKBaseKeyBoard

/**
 *  @author 刘宝, 2016-10-18 09:10:07
 *
 *  市场类型
 */
@property(nonatomic,assign)TKOptionNumKeyBoardMarket market;

/**
 *  @author 刘宝, 2016-10-18 10:10:59
 *
 *  初始化
 *
 *  @param marekt 市场
 *
 *  @return
 */
-(instancetype)initWithMarket:(TKOptionNumKeyBoardMarket)marekt;

@end
