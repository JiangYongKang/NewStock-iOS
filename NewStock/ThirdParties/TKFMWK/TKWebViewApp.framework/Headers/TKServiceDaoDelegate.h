//
//  TKServiceDao.h
//  TKApp
//
//  Created by liubao on 14-11-24.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReqParamVo.h"

/**
 *  @Author 刘宝, 2014-11-25 17:11:29
 *
 *  服务通信Dao协议
 */
@protocol TKServiceDaoDelegate <NSObject>
@required

/**
 *  处理请求
 *
 *  @param reqParamVo 请求对象
 */
-(void)invoke:(ReqParamVo *)reqParamVo;

/**
 *  @Author 刘宝, 2014-11-25 15:11:09
 *
 *  清除请求对象
 *
 *  @param flowNo 流水号
 */
-(void)clearRequest:(NSString *)flowNo;

/**
 *  @Author 刘宝, 2014-11-25 22:11:05
 *
 *  清除组请求对象
 *
 *  @param groupNo 组号
 */
-(void)clearGroup:(NSString *)groupNo;

@end
