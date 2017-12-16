//
//  TKDesHelper.h
//  TKUtil
//
//  Created by liubao on 14-11-6.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  DES帮助类
 */
@interface TKDesHelper : NSObject

/**
 *  Des加密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 加密后的字符串
 */
+(NSString *)stringWithDesEncryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  Des加密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithDesEncryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  Des加密
 *
 *  @param data 数据
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithDesEncryptData:(NSData *)data withKey:(NSString *)key;

/**
 *  Des解密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 解密后的字符串
 */
+(NSString *)stringWithDesDecryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  Des解密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 解密后的数据
 */
+(NSData *)dataWithDesDecryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  Des解密
 *
 *  @param data 数据
 *  @param key    秘钥
 *
 *  @return 解密后的数据
 */
+(NSData *)dataWithDesDecryptData:(NSData *)data withKey:(NSString *)key;

@end
