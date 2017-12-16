//
//  TKService.h
//  TKApp
//
//  Created by liubao on 14-11-25.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReqParamVo.h"
#import "LoadInfo.h"
#import "ResultVo.h"

typedef void(^CallBackFunc)(ResultVo * resultVo);

/**
 *  @Author 刘宝, 2014-11-25 17:11:01
 *
 *  通信服务协议
 */
@protocol TKServiceDelegate <NSObject>

@required
/**
 *  处理失败
 *
 *  @param resultVo 失败的错误对象
 */
-(void)onFault:(ResultVo *)resultVo;

/**
 *  请求成功
 *
 *  @param resultVo 返回的结果对象
 */
-(void)onResult:(ResultVo *)resultVo;

/**
 *  @Author 刘宝, 2014-11-25 23:11:12
 *
 *  请求服务
 *
 *  @param reqParamVo   请求对象
 *  @param callBackFunc 回调函数
 *  @param isReturnList 是否返回List
 */
-(void)invoke:(ReqParamVo *)reqParamVo callBackFunc:(CallBackFunc)callBackFunc isReturnList:(BOOL)isReturnList;

/**
 *  @Author 刘宝, 2014-11-25 23:11:11
 *
 *  请求服务
 *
 *  @param reqParamVo   请求对象
 *  @param callBackFunc 回调函数
 */
-(void)invoke:(ReqParamVo *)reqParamVo callBackFunc:(CallBackFunc)callBackFunc;

/**
 *  @Author 刘宝, 2014-11-26 12:11:13
 *
 *  清除请求对象
 *
 *  @param flowNo  流水号
 */
-(void)clearRequest:(NSString *)flowNo;

/**
 *  @Author 刘宝, 2014-11-28 01:11:26
 *
 *  根据流水号获取请求
 *
 *  @param flowNo 流水号
 *
 *  @return 请求对象
 */
-(ReqParamVo *)getRequestWithFlowNo:(NSString *)flowNo;

/**
 *  @Author 刘宝, 2014-12-15 17:12:36
 *
 *  清理所有请求
 */
-(void)clearAllRequest;

@optional
/**
 *  请求开始
 */
-(void)onOpen:(ReqParamVo *)reqParamVo;

/**
 *  @Author 刘宝, 2014-11-25 14:11:29
 *
 *  @param result 数据对象
 */
-(void)onProgress:(LoadInfo *)loadInfo withRequest:(ReqParamVo *)reqParamVo;

/**
 *  @Author 刘宝, 2014-11-26 11:11:04
 *
 *  请求关闭
 */
-(void)onClose:(ReqParamVo *)reqParamVo;
@end
