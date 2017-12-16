//
//  TKTrafficManager.h
//  TKAppBase_V2
//
//  Created by 刘宝 on 16/8/10.
//  Copyright © 2016年 com.thinkive. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 REALTIME只在“模拟器”设备模式下有效，其它情况下的REALTIME会改为使用最小间隔或数目发送策略。
 */
typedef enum {
    TKTrafficReportPolicy_RealTime = 0,          //实时发送              (只在“模拟器”设备下有效)
    TKTrafficReportPolicy_Batch = 1,             //启动发送
    TKTrafficReportPolicy_Send_Interval = 2,     //最小间隔发送           (默认是 90s)
    TKTrafficReportPolicy_Send_Num = 3,          //最小数目发送           (默认是 10条)
    TKTrafficReportPolicy_Send_IntervalOrNum = 4,//最小间隔或数目发送      (默认是 满足10条记录或者90s钟就发送一次)
    TKTrafficReportPolicy_SendOnBackgound = 5,   //APP切入后台时发送
    TKTrafficReportPolicy_None                   //默认策略
} TKTrafficReportPolicy;

static void *const TKTrafficGlobalLoggingQueueIdentityKey = (void *)&TKTrafficGlobalLoggingQueueIdentityKey;

/**
 *  @author 刘宝, 2016-08-10 18:08:19
 *
 *  流量统计,使用步骤为：调用相关设置-------->启动统计-------->统计页面+事件
 */
@interface TKTraffic : NSObject

/**
 *  禁用默认的初始化动作，全部采用静态调用
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 *  @author 刘宝, 2016-08-15 10:08:51
 *
 *  统计队列
 *
 *  @return
 */
+ (dispatch_queue_t)trafficQueue;

#pragma mark 初始化配置

/**
 *  @author 刘宝, 2016-08-10 23:08:18
 *
 *  设置APP的版本
 *
 *  @param appVersion
 */
+ (void)setAppVersion:(NSString *)appVersion;

/**
 *  @author 刘宝, 2016-08-11 09:08:00
 *
 *   开启CrashReport收集, 默认YES(开启状态).
 *
 *  @param value 设置为NO,可关闭CrashReport收集功能.
 */
+ (void)setCrashReportEnabled:(BOOL)value;

/**
 *  @author 刘宝, 2016-08-11 09:08:21
 *
 *  设置是否开启background模式, 默认YES.
 *
 *  @param value 为YES,SDK会确保在app进入后台的短暂时间保存日志信息的完整性，对于已支持background模式和一般app不会有影响.如果该模式影响某些App在切换到后台的功能，也可将该值设置为NO.
 */
+ (void)setBackgroundTaskEnabled:(BOOL)value;

/**
 *  @author 刘宝, 2016-12-01 13:12:01
 *
 *  是否仅Wifi环境才发送请求，默认NO
 *
 *  @param value
 */
+ (void)setOnlyWifiEnabled:(BOOL)value;

/**
 *  @author 刘宝, 2016-08-11 10:08:37
 *
 *  设置是否对日志信息进行加密, 默认NO(不加密).
 *
 *  @param value
 */
+ (void)setEncryptEnabled:(BOOL)value;

/**
 *  @author 刘宝, 2016-08-12 13:08:28
 *
 *  加密key
 *
 *  @param key 加密key
 */
+ (void)setEncryptKey:(NSString *)key;

/**
 *  @author 刘宝, 2016-08-11 10:08:39
 *
 *  当reportPolicy == TKTrafficReportPolicy_Send_Interval 时设定log发送间隔
 *
 *  @param second 单位为秒
 */
+ (void)setLogSendInterval:(double)second;

/**
 *  @author 刘宝, 2016-08-11 10:08:13
 *
 *  当reportPolicy == TKTrafficReportPolicy_Send_Num 时设定log发送数目间隔
 *
 *  @param num 数目
 */
+ (void)setLogSendNum:(NSUInteger)num;

#pragma mark 业务字段

/**
 *  @author 刘宝, 2016-12-06 00:12:24
 *
 *  设置用户的资金账号
 *
 *  @param fundAccunt
 */
+ (void)setFundAccount:(NSString *)fundAccunt;

/**
 *  @author 刘宝, 2016-12-11 00:12:51
 *
 *  获取用户的资金账户
 *
 *  @return
 */
+ (NSString *)fundAccunt;

/**
 *  @author 刘宝, 2016-12-06 00:12:31
 *
 *  设置用户的手机号
 *
 *  @param mobile
 */
+ (void)setMobile:(NSString *)mobile;

/**
 *  @author 刘宝, 2016-12-11 00:12:21
 *
 *  获取用户手机号
 *
 *  @return
 */
+ (NSString *)mobile;

#pragma mark 开启统计

/**
 *  @author 刘宝, 2016-08-12 14:08:16
 *  初始化统计模块
 *
 */
+ (void)start;

/**
 *  @author 刘宝, 2016-08-11 10:08:21
 *
 *  初始化统计模块
 *
 *  @param appKey 授权key
 */
+ (void)startWithAppkey:(NSString *)appKey appId:(NSString *)appId;

/**
 *  @author 刘宝, 2016-08-11 10:08:03
 *
 *  初始化统计模块
 *
 *  @param appKey 授权key
 *  @param rp     发送策略, 默认值为：Send_IntervalOrNum，即“最小间隔或数目发送”模式
 *  @param cid    渠道名称,为nil或@""时, 默认为@"App Store"渠道
 */
+ (void)startWithAppkey:(NSString *)appKey appId:(NSString *)appId reportPolicy:(TKTrafficReportPolicy)rp channelId:(NSString *)cid;

#pragma mark 页面统计

/**
 *  @author 刘宝, 2016-08-11 10:08:26
 *
 *  手动页面时长统计, 记录某个页面展示的时长.
 *
 *  @param pageName 统计的页面名称.
 *  @param pageUrl  统计的页面路径.
 *  @param seconds  单位为秒，int型.
 */
+ (void)logPageView:(NSString *)pageName pageUrl:(NSString *)pageUrl seconds:(double)seconds;

/**
 *  @author 刘宝, 2016-08-11 10:08:53
 *
 *  自动页面时长统计, 开始记录某个页面展示时长.
    使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
    在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 *
 *  @param pageName 统计的页面名称.
 *  @param pageUrl  统计的页面路径.
 */
+ (void)beginLogPageView:(NSString *)pageName pageUrl:(NSString *)pageUrl;

/**
 *  @author 刘宝, 2016-08-11 10:08:38
 *
 *  自动页面时长统计, 结束记录某个页面展示时长.
    使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
    在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 *
 *  @param pageName 统计的页面名称.
 *  @param pageUrl  统计的页面路径.
 */
+ (void)endLogPageView:(NSString *)pageName pageUrl:(NSString *)pageUrl;

#pragma mark 统计事件

/**
 *  @author 刘宝, 2016-08-11 10:08:21
 *
 *  自定义事件,数量统计.
 *
 *  @param eventId      事件ID
 *  @param eventName    事件名称
 *  @param attributes   事件属性
 */
+ (void)event:(NSString *)eventId eventName:(NSString *)eventName attributes:(NSDictionary *)attributes;

#pragma mark 统计异常

/**
 *  @author 刘宝, 2016-08-11 17:08:41
 *
 *  统计崩溃，这个要同步操作
 *
 *  @param exception_type    崩溃日志标题
 *  @param exception_content 崩溃日志内容
 */
+ (void)logCrashException:(NSString *)exception_type content:(NSString *)exception_content;

#pragma mark 刷新缓存

/**
 *  @author 刘宝, 2016-08-25 19:08:24
 *
 *  刷新缓冲区数据，保存到本地给下次发送
 */
+ (void)flush;

@end
