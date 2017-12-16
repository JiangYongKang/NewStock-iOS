//
//  TKMd5Helper.h
//  TKUtil
//
//  Created by liubao on 14-11-6.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  MD5帮组类
 */
@interface TKMd5Helper : NSObject

/**
 *  MD5摘要算法
 *
 *  @param str 要编码的字符串
 *
 *  @return 编码后的字符串
 */
+(NSString *)md5Encrypt:(NSString *)str;

/**
 *  @author 刘宝, 2016-11-16 10:11:31
 *
 *  MD5摘要算法
 *
 *  @param data 要编码的二进制
 *
 *  @return 编码后的字符串
 */
+(NSString *)md5EncryptData:(NSData *)data;

/**
 *  @author 刘宝, 2016-11-16 10:11:31
 *
 *  MD5摘要算法
 *
 *  @param data   要编码的二进制
 *  @param length 要编码的二进制长度
 *
 *  @return 编码后的字符串
 */
+(NSString *)md5EncryptBytes:(char *)bytes length:(uint32_t)length;

@end
