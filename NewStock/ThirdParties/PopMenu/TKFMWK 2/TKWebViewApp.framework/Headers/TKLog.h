#import <Foundation/Foundation.h>

// Core
#import "TKLogManager.h"

// Loggers
#import "TKTTYLogger.h"
#import "TKFileLogger.h"
#import "TKServerLogger.h"

#ifndef TKLOG_LEVEL_DEF
  #define TKLOG_LEVEL_DEF [TKLogManager logLevel]
#endif

#ifndef TKLOG_ASYNC_ENABLED
  #define TKLOG_ASYNC_ENABLED [TKLogManager logAsyncEnabled]
#endif

#define TKLOG_MAYBE(async, lvl, flg, ctx, atag, frmt, ...)                                        \
        do { if(lvl & flg) [TKLogManager log : async                                              \
                                       level : lvl                                                \
                                        flag : flg                                                \
                                     context : ctx                                                \
                                        file : __FILE__                                           \
                                    function : __PRETTY_FUNCTION__                                \
                                        line : __LINE__                                           \
                                         tag : atag                                               \
                                      format : (frmt), ## __VA_ARGS__]; } while(0)


#define TKLOG_MAYBE_TO_TKLOG(tklog, async, lvl, flg, ctx, atag, frmt, ...)                 \
        do { if(lvl & flg) [tklog log : async                                              \
                                level : lvl                                                \
                                 flag : flg                                                \
                              context : ctx                                                \
                                 file : __FILE__                                           \
                             function : __PRETTY_FUNCTION__                                \
                                 line : __LINE__                                           \
                                  tag : atag                                               \
                               format : (frmt), ## __VA_ARGS__]; } while(0)

#define TKLogError(frmt, ...)   TKLOG_MAYBE(NO,                  TKLOG_LEVEL_DEF, TKLogFlagError,   0, nil, frmt, ##__VA_ARGS__)
#define TKLogWarn(frmt, ...)    TKLOG_MAYBE(TKLOG_ASYNC_ENABLED, TKLOG_LEVEL_DEF, TKLogFlagWarning, 0, nil, frmt, ##__VA_ARGS__)
#define TKLogInfo(frmt, ...)    TKLOG_MAYBE(TKLOG_ASYNC_ENABLED, TKLOG_LEVEL_DEF, TKLogFlagInfo,    0, nil, frmt, ##__VA_ARGS__)
#define TKLogDebug(frmt, ...)   TKLOG_MAYBE(TKLOG_ASYNC_ENABLED, TKLOG_LEVEL_DEF, TKLogFlagDebug,   0, nil, frmt, ##__VA_ARGS__)
#define TKLogVerbose(frmt, ...) TKLOG_MAYBE(TKLOG_ASYNC_ENABLED, TKLOG_LEVEL_DEF, TKLogFlagVerbose, 0, nil, frmt, ##__VA_ARGS__)

#define TKLogErrorToTKLog(tklog, frmt, ...)   TKLOG_MAYBE_TO_TKLOG(tklog, NO,                  TKLOG_LEVEL_DEF, TKLogFlagError,   0, nil, frmt, ##__VA_ARGS__)
#define TKLogWarnToTKLog(tklog, frmt, ...)    TKLOG_MAYBE_TO_TKLOG(tklog, TKLOG_ASYNC_ENABLED, TKLOG_LEVEL_DEF, TKLogFlagWarning, 0, nil, frmt, ##__VA_ARGS__)
#define TKLogInfoToTKLog(tklog, frmt, ...)    TKLOG_MAYBE_TO_TKLOG(tklog, TKLOG_ASYNC_ENABLED, TKLOG_LEVEL_DEF, TKLogFlagInfo,    0, nil, frmt, ##__VA_ARGS__)
#define TKLogDebugToTKLog(tklog, frmt, ...)   TKLOG_MAYBE_TO_TKLOG(tklog, TKLOG_ASYNC_ENABLED, TKLOG_LEVEL_DEF, TKLogFlagDebug,   0, nil, frmt, ##__VA_ARGS__)
#define TKLogVerboseToTKLog(tklog, frmt, ...) TKLOG_MAYBE_TO_TKLOG(tklog, TKLOG_ASYNC_ENABLED, TKLOG_LEVEL_DEF, TKLogFlagVerbose, 0, nil, frmt, ##__VA_ARGS__)
