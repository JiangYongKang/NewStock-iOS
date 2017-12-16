//
//  TKBlowFishHelper.h
//  TKUtil_V1
//
//  Created by liubao on 14-11-10.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2014-12-15 01:12:23
 *
 *  BlowFish 加解密
 */
@interface TKBlowFishHelper : NSObject

/**
 *  BlowFish加密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 加密后的字符串
 */
+(NSString *)stringWithBlowFishEncryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  BlowFish加密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithBlowFishEncryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  BlowFish加密
 *
 *  @param data 数据
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithBlowFishEncryptData:(NSData *)data withKey:(NSString *)key;

/**
 *  BlowFish解密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 解密后的字符串
 */
+(NSString *)stringWithBlowFishDecryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  BlowFish解密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 解密后的数据
 */
+(NSData *)dataWithBlowFishDecryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  BlowFish解密
 *
 *  @param data 数据
 *  @param key    秘钥
 *
 *  @return 解密后的数据
 */
+(NSData *)dataWithBlowFishDecryptData:(NSData *)data withKey:(NSString *)key;

@end
