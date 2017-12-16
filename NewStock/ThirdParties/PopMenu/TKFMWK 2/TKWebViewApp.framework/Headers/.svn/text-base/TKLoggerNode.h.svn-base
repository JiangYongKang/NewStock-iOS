//
//  TKLoggerNode.h
//  TKUtil_V1
//
//  Created by 刘宝 on 16/6/2.
//  Copyright © 2016年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKLoggerDelegate.h"

/**
 *  @author 刘宝, 2016-06-02 19:06:18
 *
 *  记录节点
 */
@interface TKLoggerNode : NSObject
{
    // Direct accessors to be used only for performance
@public
    id <TKLoggerDelegate> _logger;
    TKLogLevel _level;
    dispatch_queue_t _loggerQueue;
}

@property (nonatomic, readonly) id <TKLoggerDelegate> logger;
@property (nonatomic, readonly) TKLogLevel level;
@property (nonatomic, readonly) dispatch_queue_t loggerQueue;

+ (TKLoggerNode *)nodeWithLogger:(id <TKLoggerDelegate>)logger
                     loggerQueue:(dispatch_queue_t)loggerQueue
                           level:(TKLogLevel)level;

@end
