//
//  TKAbstractLogger.h
//  TKUtil_V1
//
//  Created by 刘宝 on 16/6/2.
//  Copyright © 2016年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKLoggerDelegate.h"
#import "TKLogFormatterDelegate.h"

/**
 * The `DDLogger` protocol specifies that an optional formatter can be added to a logger.
 * Most (but not all) loggers will want to support formatters.
 *
 * However, writting getters and setters in a thread safe manner,
 * while still maintaining maximum speed for the logging process, is a difficult task.
 *
 * To do it right, the implementation of the getter/setter has strict requiremenets:
 * - Must NOT require the `logMessage:` method to acquire a lock.
 * - Must NOT require the `logMessage:` method to access an atomic property (also a lock of sorts).
 *
 * To simplify things, an abstract logger is provided that implements the getter and setter.
 *
 * Logger implementations may simply extend this class,
 * and they can ACCESS THE FORMATTER VARIABLE DIRECTLY from within their `logMessage:` method!
 **/
@interface TKAbstractLogger : NSObject <TKLoggerDelegate>
{
    // Direct accessors to be used only for performance
@public
    id <TKLogFormatterDelegate> _logFormatter;
    dispatch_queue_t _loggerQueue;
}

@property (nonatomic, strong) id <TKLogFormatterDelegate> logFormatter;

@property (nonatomic, DISPATCH_QUEUE_REFERENCE_TYPE) dispatch_queue_t loggerQueue;

// For thread-safety assertions

/**
 *  Return YES if the current logger uses a global queue for logging
 */
@property (nonatomic, readonly, getter=isOnGlobalLoggingQueue)  BOOL onGlobalLoggingQueue;

/**
 *  Return YES if the current logger uses the internal designated queue for logging
 */
@property (nonatomic, readonly, getter=isOnInternalLoggerQueue) BOOL onInternalLoggerQueue;

@end

