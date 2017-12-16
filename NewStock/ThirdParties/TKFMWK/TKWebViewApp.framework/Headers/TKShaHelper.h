//
//  TKShaHelper.h
//  TKUtil
//
//  Created by liubao on 14-11-6.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  SHA帮组类
 */
@interface TKShaHelper : NSObject

/**
 *  SHA1摘要算法
 *
 *  @param str 字符串
 *
 *  @return 编码后的字符串
 */
+(NSString *) sha1:(NSString *)str;

/**
 *  SHA224摘要算法
 *
 *  @param str 字符串
 *
 *  @return 编码后的字符串
 */
+(NSString *) sha224:(NSString *)str;

/**
 *  SHA256摘要算法
 *
 *  @param str 字符串
 *
 *  @return 编码后的字符串
 */
+(NSString *) sha256:(NSString *)str;

/**
 *  SHA384摘要算法
 *
 *  @param str 字符串
 *
 *  @return 编码后的字符串
 */
+(NSString *) sha384:(NSString *)str;

/**
 *  SHA512摘要算法
 *
 *  @param str 字符串
 *
 *  @return 编码后的字符串
 */
+(NSString *) sha512:(NSString *)str;

@end
