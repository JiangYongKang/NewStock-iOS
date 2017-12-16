//
//  TKLogFormatterDelegate.h
//  TKUtil_V1
//
//  Created by 刘宝 on 16/6/2.
//  Copyright © 2016年 liubao. All rights reserved.
//

#import "TKLogMessage.h"

@protocol TKLoggerDelegate;

/**
 *  @author 刘宝, 2016-06-02 11:06:29
 *
 *  格式化日志
 */
@protocol TKLogFormatterDelegate <NSObject>
@required

/**
 * Formatters may optionally be added to any logger.
 * This allows for increased flexibility in the logging environment.
 * For example, log messages for log files may be formatted differently than log messages for the console.
 *
 * For more information about formatters, see the "Custom Formatters" page:
 * Documentation/CustomFormatters.md
 *
 * The formatter may also optionally filter the log message by returning nil,
 * in which case the logger will not log the message.
 **/
- (NSString *)formatLogMessage:(TKLogMessage *)logMessage;

@optional

/**
 * A single formatter instance can be added to multiple loggers.
 * These methods provides hooks to notify the formatter of when it's added/removed.
 *
 * This is primarily for thread-safety.
 * If a formatter is explicitly not thread-safe, it may wish to throw an exception if added to multiple loggers.
 * Or if a formatter has potentially thread-unsafe code (e.g. NSDateFormatter),
 * it could possibly use these hooks to switch to thread-safe versions of the code.
 **/
- (void)didAddToLogger:(id <TKLoggerDelegate>)logger;

/**
 *  See the above description for `didAddToLogger:`
 */
- (void)willRemoveFromLogger:(id <TKLoggerDelegate>)logger;

@end