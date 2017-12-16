//
//  TKLoggerDelegate.h
//  TKUtil_V1
//
//  Created by 刘宝 on 16/6/2.
//  Copyright © 2016年 liubao. All rights reserved.
//
/**
 *  This protocol describes a basic logger behavior.
 *  Basically, it can log messages, store a logFormatter plus a bunch of optional behaviors.
 *  (i.e. flush, get its loggerQueue, get its name, ...
 */

#import "TKLogMessage.h"
@protocol TKLogFormatterDelegate;

/**
 *  @author 刘宝, 2016-06-02 11:06:45
 *
 *  记录日志
 */
@protocol TKLoggerDelegate <NSObject>

/**
 *  The log message method
 *
 *  @param logMessage the message (model)
 */
- (void)logMessage:(TKLogMessage *)logMessage;

/**
 * Formatters may optionally be added to any logger.
 *
 * If no formatter is set, the logger simply logs the message as it is given in logMessage,
 * or it may use its own built in formatting style.
 **/
@property (nonatomic, strong) id <TKLogFormatterDelegate> logFormatter;

@optional

/**
 * Since logging is asynchronous, adding and removing loggers is also asynchronous.
 * In other words, the loggers are added and removed at appropriate times with regards to log messages.
 *
 * - Loggers will not receive log messages that were executed prior to when they were added.
 * - Loggers will not receive log messages that were executed after they were removed.
 *
 * These methods are executed in the logging thread/queue.
 * This is the same thread/queue that will execute every logMessage: invocation.
 * Loggers may use these methods for thread synchronization or other setup/teardown tasks.
 **/
- (void)didAddLogger;

/**
 *  See the above description for `didAddLoger`
 */
- (void)willRemoveLogger;

/**
 * Some loggers may buffer IO for optimization purposes.
 * For example, a database logger may only save occasionaly as the disk IO is slow.
 * In such loggers, this method should be implemented to flush any pending IO.
 *
 * This allows invocations of DDLog's flushLog method to be propogated to loggers that need it.
 *
 * Note that DDLog's flushLog method is invoked automatically when the application quits,
 * and it may be also invoked manually by the developer prior to application crashes, or other such reasons.
 **/
- (void)flush;

/**
 * Each logger is executed concurrently with respect to the other loggers.
 * Thus, a dedicated dispatch queue is used for each logger.
 * Logger implementations may optionally choose to provide their own dispatch queue.
 **/
@property (nonatomic, DISPATCH_QUEUE_REFERENCE_TYPE, readonly) dispatch_queue_t loggerQueue;

/**
 * If the logger implementation does not choose to provide its own queue,
 * one will automatically be created for it.
 * The created queue will receive its name from this method.
 * This may be helpful for debugging or profiling reasons.
 **/
@property (nonatomic, readonly) NSString *loggerName;

@end