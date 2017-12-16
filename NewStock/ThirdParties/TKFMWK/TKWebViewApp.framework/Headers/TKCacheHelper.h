//
//  TKCacheHelper.h
//  TKUtil
//
//  Created by liubao on 14-11-11.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  缓存处理帮助类
 */
@interface TKCacheHelper : NSObject

/**
 *  设置objc基础对象缓存
 *
 *  @param item 对象
 *  @param key  key
 */
+(void)setItem:(NSObject *)item withKey:(NSString*)key;

/**
 *  设置objc基础对象缓存
 *
 *  @param item 对象
 *  @param key       key
 *  @param isEncrypt  是否加密
 */
+(void)setItem:(NSObject *)item withKey:(NSString*)key isEncrypt:(BOOL)isEncrypt;

/**
 *  保存自定义对象（对象实现NSCoding协议）
 *
 *  @param item 自定义对象
 *  @param key  key
 */
+(void)setCustomItem:(NSObject *)item withKey:(NSString*)key;

/**
 *  保存自定义对象（对象实现NSCoding协议）
 *
 *  @param item 自定义对象
 *  @param key  key
 *  @param isEncrypt  是否加密
 */
+(void)setCustomItem:(NSObject *)item withKey:(NSString*)key isEncrypt:(BOOL)isEncrypt;

/**
 *  获取缓存的基础objc对象
 *
 *  @param key key
 *
 *  @return 基础oc对象
 */
+(NSObject *)getItemWithKey:(NSString *)key;

/**
 *  获取自定义对象（对象实现NSCoding协议）
 *
 *  @param key key
 *
 *  @return 自定义对象
 */
+(NSObject *)getCustomItemWithKey:(NSString *)key;

/**
 *  删除缓存(通用)
 *
 *  @param key key
 */
+(void)removeItem:(NSString *)key;

/**
 *  缓存布尔值
 *
 *  @param item 布尔值
 *  @param key  key
 */
+(void)setBoolItem:(BOOL)item withKey:(NSString *)key;

/**
 *  获取布尔值
 *
 *  @param key key
 *
 *  @return 布尔值
 */
+(BOOL)getBoolItemWithKey:(NSString *)key;

/**
 *  删除所有缓存
 */
+(void)clearAll;

/**
 *  @Author 刘宝, 2015-10-14 13:10:07
 *
 *  所有key
 *
 *  @return 所有key
 */
+(NSArray *)getAllKeys;

@end
