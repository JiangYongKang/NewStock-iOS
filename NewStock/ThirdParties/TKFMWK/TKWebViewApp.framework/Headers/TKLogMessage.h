//
//  TKLogMessage.h
//  TKUtil_V1
//
//  Created by 刘宝 on 16/6/2.
//  Copyright © 2016年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

#if OS_OBJECT_USE_OBJC
     #define DISPATCH_QUEUE_REFERENCE_TYPE strong
#else
     #define DISPATCH_QUEUE_REFERENCE_TYPE assign
#endif

#ifndef NS_DESIGNATED_INITIALIZER
   #define NS_DESIGNATED_INITIALIZER
#endif

/**
 *  Flags accompany each log. They are used together with levels to filter out logs.
 */
typedef NS_OPTIONS(NSUInteger, TKLogFlag){
    /**
     *  0...00001 DDLogFlagError
     */
    TKLogFlagError      = (1 << 0),
    
    /**
     *  0...00010 DDLogFlagWarning
     */
    TKLogFlagWarning    = (1 << 1),
    
    /**
     *  0...00100 DDLogFlagInfo
     */
    TKLogFlagInfo       = (1 << 2),
    
    /**
     *  0...01000 DDLogFlagDebug
     */
    TKLogFlagDebug      = (1 << 3),
    
    /**
     *  0...10000 DDLogFlagVerbose
     */
    TKLogFlagVerbose    = (1 << 4)
};

/**
 *  Log levels are used to filter out logs. Used together with flags.
 */
typedef NS_ENUM(NSUInteger, TKLogLevel){
    /**
     *  No logs
     */
    TKLogLevelOff       = 0,
    
    /**
     *  Error logs only
     */
    TKLogLevelError     = (TKLogFlagError),
    
    /**
     *  Error and warning logs
     */
    TKLogLevelWarning   = (TKLogLevelError   | TKLogFlagWarning),
    
    /**
     *  Error, warning and info logs
     */
    TKLogLevelInfo      = (TKLogLevelWarning | TKLogFlagInfo),
    
    /**
     *  Error, warning, info and debug logs
     */
    TKLogLevelDebug     = (TKLogLevelInfo    | TKLogFlagDebug),
    
    /**
     *  Error, warning, info, debug and verbose logs
     */
    TKLogLevelVerbose   = (TKLogLevelDebug   | TKLogFlagVerbose),
    
    /**
     *  All logs (1...11111)
     */
    TKLogLevelAll       = NSUIntegerMax
};

/**
 *  Log message options, allow copying certain log elements
 */
typedef NS_OPTIONS(NSInteger, TKLogMessageOptions){
    /**
     *  Use this to use a copy of the file path
     */
    TKLogMessageCopyFile     = 1 << 0,
    /**
     *  Use this to use a copy of the function name
     */
    TKLogMessageCopyFunction = 1 << 1
};

/**
 *  @author 刘宝, 2016-06-02 10:06:52
 *
 *  日志对象
 */
@interface TKLogMessage : NSObject <NSCopying>
{
    // Direct accessors to be used only for performance
@public
    NSString *_message;
    TKLogLevel _level;
    TKLogFlag _flag;
    NSInteger _context;
    NSString *_file;
    NSString *_fileName;
    NSString *_function;
    NSUInteger _line;
    id _tag;
    TKLogMessageOptions _options;
    NSDate *_timestamp;
    NSString *_threadID;
    NSString *_threadName;
    NSString *_queueLabel;
}

/**
 *  Default `init` is not available
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 * Standard init method for a log message object.
 * Used by the logging primitives. (And the macros use the logging primitives.)
 *
 * If you find need to manually create logMessage objects, there is one thing you should be aware of:
 *
 * If no flags are passed, the method expects the file and function parameters to be string literals.
 * That is, it expects the given strings to exist for the duration of the object's lifetime,
 * and it expects the given strings to be immutable.
 * In other words, it does not copy these strings, it simply points to them.
 * This is due to the fact that __FILE__ and __FUNCTION__ are usually used to specify these parameters,
 * so it makes sense to optimize and skip the unnecessary allocations.
 * However, if you need them to be copied you may use the options parameter to specify this.
 *
 *  @param message   the message
 *  @param level     the log level
 *  @param flag      the log flag
 *  @param context   the context (if any is defined)
 *  @param file      the current file
 *  @param function  the current function
 *  @param line      the current code line
 *  @param tag       potential tag
 *  @param options   a bitmask which supports DDLogMessageCopyFile and DDLogMessageCopyFunction.
 *  @param timestamp the log timestamp
 *
 *  @return a new instance of a log message model object
 */
- (instancetype)initWithMessage:(NSString *)message
                          level:(TKLogLevel)level
                           flag:(TKLogFlag)flag
                        context:(NSInteger)context
                           file:(NSString *)file
                       function:(NSString *)function
                           line:(NSUInteger)line
                            tag:(id)tag
                        options:(TKLogMessageOptions)options
                      timestamp:(NSDate *)timestamp NS_DESIGNATED_INITIALIZER;

/**
 * Read-only properties
 **/

/**
 *  The log message
 */
@property (readonly, nonatomic) NSString *message;
@property (readonly, nonatomic) TKLogLevel level;
@property (readonly, nonatomic) TKLogFlag flag;
@property (readonly, nonatomic) NSString *flagInfo;
@property (readonly, nonatomic) NSInteger context;
@property (readonly, nonatomic) NSString *file;
@property (readonly, nonatomic) NSString *fileName;
@property (readonly, nonatomic) NSString *function;
@property (readonly, nonatomic) NSUInteger line;
@property (readonly, nonatomic) id tag;
@property (readonly, nonatomic) TKLogMessageOptions options;
@property (readonly, nonatomic) NSDate *timestamp;
@property (readonly, nonatomic) NSString *threadID; // ID as it appears in NSLog calculated from the machThreadID
@property (readonly, nonatomic) NSString *threadName;
@property (readonly, nonatomic) NSString *queueLabel;

@end