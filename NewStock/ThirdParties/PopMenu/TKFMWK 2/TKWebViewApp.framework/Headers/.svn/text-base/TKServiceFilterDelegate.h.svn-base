//
//  TKServiceFilterDelegate.h
//  TKApp
//
//  Created by liubao on 14-11-26.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReqParamVo.h"
#import "ResultVo.h"

/**
 *  @Author 刘宝, 2014-11-26 13:11:08
 *
 *  结果过滤器
 */
@protocol TKServiceFilterDelegate <NSObject>

/**
 *  @Author 刘宝, 2014-11-26 13:11:23
 *
 *  请求拦截
 *
 *  @param reqParamVo 请求对象
 *
 *  @return 是否继续执行
 */
-(BOOL)requestFilter:(ReqParamVo*)reqParamVo;

/**
 *  @Author 刘宝, 2014-11-26 13:11:42
 *
 *  结果拦截器
 *
 *  @param resultVo 返回对象
 *
 *  @return 是否继续执行
 */
-(BOOL)resultFilter:(ResultVo *)resultVo;

@end
