// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2016, Deusty, LLC
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Neither the name of Deusty nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission of Deusty, LLC.

#import <Foundation/Foundation.h>

#import "TKLogMessage.h"
#import "TKLoggerDelegate.h"
#import "TKLogFormatterDelegate.h"

/**
 * NSAsset replacement that will output a log message even when assertions are disabled.
 **/
#define TKAssert(condition, frmt, ...)                                            \
   if (!(condition)) {                                                            \
        NSString *description = [NSString stringWithFormat:frmt, ## __VA_ARGS__]; \
        TKLogError(@"%@", description);                                           \
        NSAssert(NO, description);                                                \
   }
#define TKAssertCondition(condition) TKAssert(condition, @"Condition not satisfied: %s", #condition)

static void *const TKGlobalLoggingQueueIdentityKey = (void *)&TKGlobalLoggingQueueIdentityKey;

/**
 *  Extracts just the file name, no path or extension
 *
 *  @param filePath input file path
 *  @param copy     YES if we want the result to be copied
 *
 *  @return the file name
 */
NSString * TKExtractFileNameWithoutExtension(const char *filePath, BOOL copy);

/**
 * The THIS_FILE macro gives you an NSString of the file name.
 * For simplicity and clarity, the file name does not include the full path or file extension.
 *
 * For example: DDLogWarn(@"%@: Unable to find thingy", THIS_FILE) -> @"MyViewController: Unable to find thingy"
 **/
#define TKTHIS_FILE         (TKExtractFileNameWithoutExtension(__FILE__, NO))

/**
 * The THIS_METHOD macro gives you the name of the current objective-c method.
 *
 * For example: DDLogWarn(@"%@ - Requires non-nil strings", THIS_METHOD) -> @"setMake:model: requires non-nil strings"
 *
 * Note: This does NOT work in straight C functions (non objective-c).
 * Instead you should use the predefined __FUNCTION__ macro.
 **/
#define TKTHIS_METHOD       NSStringFromSelector(_cmd)

#pragma mark -

/**
 *  The main class, exposes all logging mechanisms, loggers, ...
 *  For most of the users, this class is hidden behind the logging functions like `DDLogInfo`
 */
@interface TKLogManager : NSObject

/**
 * Provides access to the underlying logging queue.
 * This may be helpful to Logger classes for things like thread synchronization.
 **/
+ (dispatch_queue_t)loggingQueue;

/**
 * Logging Primitive.
 *
 * This method is used by the macros or logging functions.
 * It is suggested you stick with the macros as they're easier to use.
 *
 *  @param asynchronous YES if the logging is done async, NO if you want to force sync
 *  @param level        the log level
 *  @param flag         the log flag
 *  @param context      the context (if any is defined)
 *  @param file         the current file
 *  @param function     the current function
 *  @param line         the current code line
 *  @param tag          potential tag
 *  @param format       the log format
 */
+ (void)log:(BOOL)asynchronous
      level:(TKLogLevel)level
       flag:(TKLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format, ... NS_FORMAT_FUNCTION(9,10);

/**
 * Logging Primitive.
 *
 * This method can be used if you have a prepared va_list.
 * Similar to `log:level:flag:context:file:function:line:tag:format:...`
 *
 *  @param asynchronous YES if the logging is done async, NO if you want to force sync
 *  @param level        the log level
 *  @param flag         the log flag
 *  @param context      the context (if any is defined)
 *  @param file         the current file
 *  @param function     the current function
 *  @param line         the current code line
 *  @param tag          potential tag
 *  @param format       the log format
 *  @param argList      the arguments list as a va_list
 */
+ (void)log:(BOOL)asynchronous
      level:(TKLogLevel)level
       flag:(TKLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format
       args:(va_list)argList;

/**
 * Logging Primitive.
 *
 * This method can be used if you manualy prepared DDLogMessage.
 *
 *  @param asynchronous YES if the logging is done async, NO if you want to force sync
 *  @param logMessage   the log message stored in a `DDLogMessage` model object
 */
+ (void)log:(BOOL)asynchronous message:(TKLogMessage *)logMessage;

/**
 * Since logging can be asynchronous, there may be times when you want to flush the logs.
 * The framework invokes this automatically when the application quits.
 **/
+ (void)flushLog;

/**
 * Loggers
 *
 * In order for your log statements to go somewhere, you should create and add a logger.
 *
 * You can add multiple loggers in order to direct your log statements to multiple places.
 * And each logger can be configured separately.
 * So you could have, for example, verbose logging to the console, but a concise log file with only warnings & errors.
 **/

/**
 * Adds the logger to the system.
 *
 * This is equivalent to invoking `[DDLog addLogger:logger withLogLevel:DDLogLevelAll]`.
 **/
+ (void)addLogger:(id <TKLoggerDelegate>)logger;

/**
 * Adds the logger to the system.
 *
 * The level that you provide here is a preemptive filter (for performance).
 * That is, the level specified here will be used to filter out logMessages so that
 * the logger is never even invoked for the messages.
 *
 * More information:
 * When you issue a log statement, the logging framework iterates over each logger,
 * and checks to see if it should forward the logMessage to the logger.
 * This check is done using the level parameter passed to this method.
 *
 * For example:
 *
 * `[DDLog addLogger:consoleLogger withLogLevel:DDLogLevelVerbose];`
 * `[DDLog addLogger:fileLogger    withLogLevel:DDLogLevelWarning];`
 *
 * `DDLogError(@"oh no");` => gets forwarded to consoleLogger & fileLogger
 * `DDLogInfo(@"hi");`     => gets forwarded to consoleLogger only
 *
 * It is important to remember that Lumberjack uses a BITMASK.
 * Many developers & third party frameworks may define extra log levels & flags.
 * For example:
 *
 * `#define SOME_FRAMEWORK_LOG_FLAG_TRACE (1 << 6) // 0...1000000`
 *
 * So if you specify `DDLogLevelVerbose` to this method, you won't see the framework's trace messages.
 *
 * `(SOME_FRAMEWORK_LOG_FLAG_TRACE & DDLogLevelVerbose) => (01000000 & 00011111) => NO`
 *
 * Consider passing `DDLogLevelAll` to this method, which has all bits set.
 * You can also use the exclusive-or bitwise operator to get a bitmask that has all flags set,
 * except the ones you explicitly don't want. For example, if you wanted everything except verbose & debug:
 *
 * `((DDLogLevelAll ^ DDLogLevelVerbose) | DDLogLevelInfo)`
 **/
+ (void)addLogger:(id <TKLoggerDelegate>)logger withLevel:(TKLogLevel)level;

/**
 *  Remove the logger from the system
 */
+ (void)removeLogger:(id <TKLoggerDelegate>)logger;

/**
 *  Remove all the current loggers
 */
+ (void)removeAllLoggers;

/**
 *  Return all the current loggers
 */
+ (NSArray *)allLoggers;

+ (TKLogLevel)logLevel;

+ (void)setLogLevel:(TKLogLevel)logLevel;

+ (BOOL)logAsyncEnabled;

+ (void)setLogAsyncEnabled:(BOOL)logAsyncEnabled;

@end