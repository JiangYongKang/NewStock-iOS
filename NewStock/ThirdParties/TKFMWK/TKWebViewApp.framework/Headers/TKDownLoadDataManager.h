//
//  TYDownLoadDataManager.h
//  TYDownloadManagerDemo
//
//  Created by tany on 16/6/12.
//  Copyright © 2016年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKDownloadModel.h"
#import "TKDownloadDelegate.h"

/**
 *  下载管理类 封装NSURLSessionDataTask
 */
@interface TKDownLoadDataManager : NSObject <NSURLSessionDataDelegate>

// 下载代理
@property (nonatomic,weak) id<TKDownloadDelegate> delegate;

// 下载中的模型 只读
@property (nonatomic, strong,readonly) NSMutableArray *waitingDownloadModels;

// 等待中的模型 只读
@property (nonatomic, strong,readonly) NSMutableArray *downloadingModels;

// 最大下载数
@property (nonatomic, assign) NSInteger maxDownloadCount;

// 等待下载队列 先进先出 默认YES， 当NO时，先进后出
@property (nonatomic, assign) BOOL resumeDownloadFIFO;

// 全部并发 默认NO, 当YES时，忽略maxDownloadCount
@property (nonatomic, assign) BOOL isBatchDownload;

// 单例
+ (TKDownLoadDataManager *)manager;

// 开始下载
- (TKDownloadModel *)startDownloadURLString:(NSString *)URLString toDestinationPath:(NSString *)destinationPath progress:(TKDownloadProgressBlock)progress state:(TKDownloadStateBlock)state;

// 开始下载
- (void)startWithDownloadModel:(TKDownloadModel *)downloadModel progress:(TKDownloadProgressBlock)progress state:(TKDownloadStateBlock)state;

// 开始下载
- (void)startWithDownloadModel:(TKDownloadModel *)downloadModel;

// 恢复下载（除非确定对这个model进行了suspend，否则使用start）
- (void)resumeWithDownloadModel:(TKDownloadModel *)downloadModel;

// 暂停下载
- (void)suspendWithDownloadModel:(TKDownloadModel *)downloadModel;

// 取消下载
- (void)cancleWithDownloadModel:(TKDownloadModel *)downloadModel;

// 删除下载
- (void)deleteFileWithDownloadModel:(TKDownloadModel *)downloadModel;

// 删除下载
- (void)deleteAllFileWithDownloadDirectory:(NSString *)downloadDirectory;

// 获取正在下载模型
- (TKDownloadModel *)downLoadingModelForURLString:(NSString *)URLString;

// 获取本地下载模型的进度
- (TKDownloadProgress *)progessWithDownloadModel:(TKDownloadModel *)downloadModel;

// 是否已经下载
- (BOOL)isDownloadCompletedWithDownloadModel:(TKDownloadModel *)downloadModel;

@end
