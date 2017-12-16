//
//  TKSystemHelper.h
//  TKUtil_V1
//
//  Created by liubao on 14-11-10.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @Author 刘宝, 2015-11-06 18:11:31
 *
 *  读取通信录回调
 *
 *  @param TelAddressAry 通信录列表
 */
typedef void(^ReadTelAddressBookComplete)(NSArray * telAddressAry);

/**
 *  系统相关帮组类
 */
@interface TKSystemHelper : NSObject

/**
 *  读取系统配置
 *
 *  @param key key
 *
 *  @return 配置value
 */
+(NSString*)getConfigByKey:(NSString*)key;

/**
 *  修改系统配置
 *
 *  @param key      key
 *  @param newValue value
 *
 *  @return 成功标志
 */
+(BOOL)setConfigWithKey:(NSString*)key value:(NSString*)newValue;

/**
 *  @Author 刘宝, 2015-04-30 14:04:02
 *
 *  刷新重载系统配置
 */
+(void)refreshConfig;

/**
 *  获得升级展示版本号
 *
 *  @return 获取升级展示版本号
 */
+(NSString *) getVersion;

/**
 *  获得内部升级版本序号
 *
 *  @return 获取内部升级版本序号
 */
+(NSString *) getVersionSn;

/**
 *  @Author 刘宝, 2015-05-18 14:05:25
 *
 *  获取系统应用版本号
 *
 *  @return 系统应用版本号
 */
+(NSString *)getAppVersion;

/**
 *  @Author 刘宝, 2015-05-18 14:05:25
 *
 *  获取系统应用内部Build版本序号
 *
 *  @return 系统应用版本号
 */
+(NSString *)getAppVersionSn;

/**
 *  获取应用名称
 *
 *  @return 应用名称
 */
+(NSString *)getAppName;

/**
 *  @Author 刘宝, 2014-12-23 16:12:21
 *
 *  获取应用描述名
 *
 *  @return 应用描述
 */
+(NSString *)getAppDisplayName;

/**
 *  @Author 刘宝, 2014-12-23 16:12:06
 *
 *  获取应用唯一值
 *
 *  @return 应用唯一值
 */
+(NSString *)getAppIdentifier;

/**
 *  @Author 刘宝, 2014-12-23 16:12:57
 *
 *  获取系统最低版本
 *
 *  @return 获取支持的系统最低版本
 */
+(NSString *)getAppLowerSystemVersion;

/**
 *  @Author 刘宝, 2014-12-23 16:12:10
 *
 *  获取应用的URL标示
 *
 *  @return
 */
+(NSString *)getAppURLName;

/**
 *  @Author 刘宝, 2014-12-23 16:12:03
 *
 *  获取URLScheme
 *
 *  @return
 */
+(NSString *)getAppURLScheme;

/**
 *  @Author 刘宝, 2014-12-22 19:12:12
 *
 *  打电话
 *
 *  @param telPhone 电话号码
 */
+(void)callTelPhone:(NSString *)telPhone;

/**
 *  @Author 刘宝, 2014-12-23 10:12:26
 *
 *  读取通信录
 *
 *  @return 通讯录列表
 */
+(NSArray *)readTelAddressBook;

/**
 *  @Author 刘宝, 2014-12-23 10:12:26
 *
 *  读取通信录
 *
 *  @return 通讯录列表
 */
+(void)readTelAddressBook:(ReadTelAddressBookComplete)readTelAddressBookComplete;

/**
 *  @Author 刘宝, 2014-12-23 16:12:23
 *
 *  是否已经安装了自己
 *
 *  @return
 */
+(BOOL)isInstallCurrentApp;

/**
 *  @Author 刘宝, 2014-12-23 16:12:58
 *
 *  是否安装指定的软件
 *
 *  @param urlScheme
 *  @param urlName
 *
 *  @return
 */
+(BOOL)isInstallAppWithURLScheme:(NSString *)urlScheme urlName:(NSString *)urlName;

/**
 *  @Author 刘宝, 2015-04-20 20:04:33
 *
 *  设置全局缓存
 *
 *  @param value 值
 *  @param key   键
 */
+(void)setMemcache:(NSObject *)value WithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-04-20 20:04:33
 *
 *  设置全局缓存
 *
 *  @param value 值
 *  @param key   键
 *  @param isEncrypt   是否加密存储
 */
+(void)setMemcache:(NSObject *)value WithKey:(NSString *)key isEncrypt:(BOOL)isEncrypt;

/**
 *  @Author 刘宝, 2015-04-20 20:04:18
 *
 *  获取全局缓存
 *
 *  @param key 键
 *
 *  @return 值
 */
+(NSObject *)getMemcacheWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-07-08 16:07:08
 *
 *  删除缓存值
 *
 *  @param key 键
 */
+(void)removeMemcacheWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 12:10:24
 *
 *  删除所有内存缓存
 */
+(void)removeAllMemecache;

/**
 *  @Author 刘宝, 2015-10-14 13:10:25
 *
 *  所有内存key
 *
 *  @return 所有内存key
 */
+(NSArray *)getAllMemecacheKeys;

/**
 *  @Author 刘宝, 2015-04-23 11:04:28
 *
 *  获取系统字体
 *
 *  @param size 大小
 *
 *  @return
 */
+(UIFont *)getSystemFontWithSize:(CGFloat)size;

/**
 *  @Author 刘宝, 2015-04-23 11:04:28
 *
 *  获取系统粗体
 *
 *  @param size 大小
 *
 *  @return
 */
+(UIFont *)getBoldSystemFontOfSize:(CGFloat)size;

/**
 *  @Author 刘宝, 2015-04-23 11:04:28
 *
 *  获取系统环境
 *
 *  @return
 */
+(NSString *)getEnvironment;

@end
