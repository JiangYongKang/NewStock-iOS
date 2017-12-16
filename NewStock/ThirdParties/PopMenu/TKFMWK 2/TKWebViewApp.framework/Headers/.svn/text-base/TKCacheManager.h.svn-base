//
//  TKCacheManager.h
//  TKAppBase_V1
//
//  Created by liubao on 15-10-14.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKUtil.h"

/**
 *  @Author 刘宝, 2015-10-14 00:10:46
 *
 *  缓存管理器
 */
@interface TKCacheManager : NSObject

/**
 *  @Author 刘宝, 2014-11-27 20:11:31
 *
 *  单例模式
 *
 *  @return
 */
+(TKCacheManager *)shareInstance;

/**
 *  @Author 刘宝, 2015-10-14 12:10:07
 *
 *  启动监控
 */
-(void)startMonitor;

/**
 *  @Author 刘宝, 2015-10-14 12:10:41
 *
 *  停止监控
 */
-(void)stopMonitor;

/**
 *  @Author 刘宝, 2015-10-14 00:10:40
 *
 *  永久缓存指定类型的数据对象
 *
 *  @param data      数据
 *  @param cacheType 类型
 *  @param key       关键字
 */
-(void)saveCacheData:(NSObject *)data cacheType:(CacheType)cacheType withKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 00:10:40
 *
 *  根据时效设置指定类型的缓存数据对象
 *
 *  @param data      数据
 *  @param cacheType 类型
 *  @param timeOut   时效-秒，0代表永久缓存
 *  @param key       关键字
 */
-(void)saveCacheData:(NSObject *)data cacheType:(CacheType)cacheType timeOut:(NSTimeInterval)timeOut withKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 00:10:40
 *
 *  根据时效设置指定类型的缓存数据对象
 *
 *  @param data      数据
 *  @param cacheType 类型
 *  @param timeOut   时效-秒，0代表永久缓存
 *  @param key       关键字
 *  @param isEncrypt  是否加密
 */
-(void)saveCacheData:(NSObject *)data cacheType:(CacheType)cacheType timeOut:(NSTimeInterval)timeOut withKey:(NSString *)key isEncrypt:(BOOL)isEncrypt;

/**
 *  @Author 刘宝, 2015-10-14 13:10:25
 *
 *  永久缓存内存数据对象
 *
 *  @param data 数据
 *  @param key  关键字
 */
-(void)saveMemeCacheData:(NSObject *)data withKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:24
 *
 *  根据时效缓存内存数据对象
 *
 *  @param data    数据
 *  @param timeOut 时效-秒，0代表永久缓存
 *  @param key     关键字
 */
-(void)saveMemeCacheData:(NSObject *)data timeOut:(NSTimeInterval)timeOut withKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:24
 *
 *  根据时效缓存内存数据对象
 *
 *  @param data    数据
 *  @param timeOut 时效-秒，0代表永久缓存
 *  @param key     关键字
 *  @param isEncrypt  是否加密
 */
-(void)saveMemeCacheData:(NSObject *)data timeOut:(NSTimeInterval)timeOut withKey:(NSString *)key isEncrypt:(BOOL)isEncrypt;

/**
 *  @Author 刘宝, 2015-10-14 13:10:25
 *
 *  永久缓存文件数据对象
 *
 *  @param data 数据
 *  @param key  关键字
 */
-(void)saveFileCacheData:(NSObject *)data withKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:24
 *
 *  根据时效缓存文件数据对象
 *
 *  @param data    数据
 *  @param timeOut 时效-秒，0代表永久缓存
 *  @param key     关键字
 */
-(void)saveFileCacheData:(NSObject *)data timeOut:(NSTimeInterval)timeOut withKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:24
 *
 *  根据时效缓存文件数据对象
 *
 *  @param data    数据
 *  @param timeOut 时效-秒，0代表永久缓存
 *  @param key     关键字
 *  @param isEncrypt  是否加密
 */
-(void)saveFileCacheData:(NSObject *)data timeOut:(NSTimeInterval)timeOut withKey:(NSString *)key isEncrypt:(BOOL)isEncrypt;

/**
 *  @Author 刘宝, 2015-10-14 13:10:25
 *
 *  永久缓存DB数据对象
 *
 *  @param data 数据
 *  @param key  关键字
 */
-(void)saveDBCacheData:(NSObject *)data withKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:24
 *
 *  根据时效缓存DB数据对象
 *
 *  @param data    数据
 *  @param timeOut 时效-秒，0代表永久缓存
 *  @param key     关键字
 */
-(void)saveDBCacheData:(NSObject *)data timeOut:(NSTimeInterval)timeOut withKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:24
 *
 *  根据时效缓存DB数据对象
 *
 *  @param data    数据
 *  @param timeOut 时效-秒，0代表永久缓存
 *  @param key     关键字
 *  @param isEncrypt  是否加密
 */
-(void)saveDBCacheData:(NSObject *)data timeOut:(NSTimeInterval)timeOut withKey:(NSString *)key isEncrypt:(BOOL)isEncrypt;

/**
 *  @Author 刘宝, 2015-10-14 00:10:43
 *
 *  根据关键字获取指定类型的缓存数据
 *
 *  @param key       关键字
 *  @param cacheType 类型
 *
 *  @return 缓存的数据
 */
-(NSObject *)getCacheDataWithKey:(NSString *)key cacheType:(CacheType)cacheType;

/**
 *  @Author 刘宝, 2015-10-14 00:10:29
 *
 *  根据关键字，获取缓存数据，先从内存里面，找不到再找缓存文件，最后找数据库文件
 *
 *  @param key 关键key
 *
 *  @return 缓存的数据
 */
-(NSObject *)getCacheDataWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:34
 *
 *  根据关键字获取内存缓存数据
 *
 *  @param key 关键字
 *
 *  @return 缓存数据
 */
-(NSObject *)getMemCacheDataWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:34
 *
 *  根据关键字获取文件缓存数据
 *
 *  @param key 关键字
 *
 *  @return 缓存数据
 */
-(NSObject *)getFileCacheDataWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 13:10:34
 *
 *  根据关键字获取DB缓存数据
 *
 *  @param key 关键字
 *
 *  @return 缓存数据
 */
-(NSObject *)getDBCacheDataWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 00:10:53
 *
 *  根据关键字删除指定类型缓存
 *
 *  @param key       关键字
 *  @param cacheType 类型
 */
-(void)removeCacheWithKey:(NSString *)key cacheType:(CacheType)cacheType;

/**
 *  @Author 刘宝, 2015-10-14 00:10:23
 *
 *  根据关键字删除所有类型的缓存
 *
 *  @param key 关键字
 */
-(void)removeCacheWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 14:10:50
 *
 *  根据关键字删除内存里面的缓存数据
 *
 *  @param key 关键字
 */
-(void)removeMemCacheWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 14:10:50
 *
 *  根据关键字删除文件里面的缓存数据
 *
 *  @param key 关键字
 */
-(void)removeFileCacheWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 14:10:50
 *
 *  根据关键字删除内存里面的缓存数据
 *
 *  @param key 关键字
 */
-(void)removeDBCacheWithKey:(NSString *)key;

/**
 *  @Author 刘宝, 2015-10-14 00:10:26
 *
 *  删除指定类型所有缓存数据
 *
 *  @param cacheType 缓存类型
 */
-(void)removeAllCache:(CacheType)cacheType;

/**
 *  @Author 刘宝, 2015-10-14 14:10:36
 *
 *  删除所有的内存缓存数据
 */
-(void)removeAllMemCache;

/**
 *  @Author 刘宝, 2015-10-14 14:10:01
 *
 *  删除所有的文件缓存数据
 */
-(void)removeAllFileCache;

/**
 *  @Author 刘宝, 2015-10-14 14:10:09
 *
 *  删除所有的数据库缓存数据
 */
-(void)removeAllDBCache;

/**
 *  @Author 刘宝, 2015-10-14 00:10:01
 *
 *  删除所有类型的缓存数据
 */
-(void)removeAllCache;

@end
