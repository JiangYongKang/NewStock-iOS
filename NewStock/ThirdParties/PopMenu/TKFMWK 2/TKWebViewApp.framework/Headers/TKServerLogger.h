//
//  TKServerLogger.h
//  TKUtil_V1
//
//  Created by 刘宝 on 16/6/25.
//  Copyright © 2016年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKAbstractDatabaseLogger.h"

/**
 *  @author 刘宝, 2016-06-27 14:06:13
 *
 *  服务器上传代理
 */
@protocol TKServerLoggerDelegate <NSObject>

/**
 *  @author 刘宝, 2016-06-25 22:06:22
 *
 *  为保证顺序，同步发送日志到服务器
 *
 *  @param log 日志内容
 */
-(BOOL)sendLogToServer:(NSString *)log num:(int)num;

@end

/**
 *  @author 刘宝, 2016-06-25 22:06:46
 *
 *  服务器日志记录
 */
@interface TKServerLogger : TKAbstractDatabaseLogger

/**
 *  @author 刘宝, 2016-06-25 22:06:28
 *
 *  代理对象
 */
@property(nonatomic,weak)id<TKServerLoggerDelegate> delegate;

@end
