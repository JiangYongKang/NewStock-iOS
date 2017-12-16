//
//  TYDownloadDelegate.h
//  TYDownloadManagerDemo
//
//  Created by tany on 16/6/24.
//  Copyright © 2016年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKDownloadModel.h"

// 下载代理
@protocol TKDownloadDelegate <NSObject>

// 更新下载进度
- (void)downloadModel:(TKDownloadModel *)downloadModel didUpdateProgress:(TKDownloadProgress *)progress;

// 更新下载状态
- (void)downloadModel:(TKDownloadModel *)downloadModel didChangeState:(TKDownloadState)state filePath:(NSString *)filePath error:(NSError *)error;

@end
