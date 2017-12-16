//
//  TKBase64Helper.h
//  TKUtil
//
//  Created by liubao on 14-11-6.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Base64帮组类
 */
@interface TKBase64Helper : NSObject

/**
 *  base64加密
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+(NSString*)stringWithEncodeBase64String:(NSString *)string;

/**
 *  base64解密
 *
 *  @param string 需要解密的字符串
 *
 *  @return 解密后的字符串
 */
+(NSString*)stringWithDecodeBase64String:(NSString *)string;

/**
 *  base64加密
 *
 *  @param data 需要加密的数据
 *
 *  @return 加密后的字符串
 */
+(NSString*)stringWithEncodeBase64Data:(NSData *)data;

/**
 *  base64解密
 *
 *  @param data 需要解密的数据
 *
 *  @return 解密后后的字符串
 */
+(NSString*)stringWithDecodeBase64Data:(NSData *)data;

/**
 *  base64加密
 *
 *  @param data 需要加密的数据
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithEncodeBase64Data:(NSData *)data;

/**
 *  base64加密
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithEncodeBase64String:(NSString *)string;

/**
 *  base64解密
 *
 *  @param data 需要解密的数据
 *
 *  @return 解密后的数据
 */
+(NSData *)dataWithDecodeBase64Data:(NSData *)data;

/**
 *  base64解密
 *
 *  @param string 需要解密的字符串
 *
 *  @return 解密后的数据
 */
+(NSData *)dataWithDecodeBase64String:(NSString *)string;

@end
