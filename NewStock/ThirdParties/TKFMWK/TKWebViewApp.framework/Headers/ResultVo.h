//
//  ResultVo.h
//  TKApp
//
//  Created by liubao on 14-11-24.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReqParamVo.h"

/**
 *  结果对象
 */
@interface ResultVo : DynModel

/**
 *  错误号
 */
@property (nonatomic,assign)NSInteger errorNo;

/**
 *  错误信息
 */
@property (nonatomic,copy)NSString *errorInfo;

/**
 *  结果集
 */
@property (nonatomic,retain)NSObject *results;

/**
 *  结果集名称集合
 */
@property (nonatomic,retain)NSArray *dsName;

/**
 *  请求对象
 */
@property (nonatomic,retain)ReqParamVo *reqParamVo;

/**
 *  请求结果集的头，使用于单结果集
 */
@property (nonatomic,retain)NSArray *fileds;

/**
 *  @Author 刘宝, 2016-12-31 10:12:26
 *
 *  是否缓存命中的数据
 */
@property (nonatomic,assign)BOOL isCacheData;

/**
 *  获取指定的结果集
 *
 *  @param dsName 结果集名称
 *
 *  @return 结果集
 */
-(NSObject *)results:(NSString *)dsName;

/**
 *  设置指定的结果集
 *
 *  @param results 结果集
 *  @param dsName  结果集名称
 */
-(void)setResults:(NSObject *)results dsName:(NSString *)dsName;

@end
