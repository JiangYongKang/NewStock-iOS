//
//  TKRsaHelper.h
//  TKUtil_V1
//
//  Created by liubao on 15-7-14.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2015-07-14 13:07:46
 *
 *  RSA加解密
 */
@interface TKRsaHelper : NSObject

/**
 *  @Author 刘宝, 2015-07-14 13:07:06
 *
 *  RSA公钥加密，对应要用RSA私钥解密
 *
 *  @param content 内容
 *  @param pubExpd 公钥部分
 *  @param module  加密模块
 *  @param padding 格式
 *
 *  @return 加密后内容
 */
+(NSString *)rsaPublicKeyEncryptString:(NSString *)content pubExpd:(NSString *)pubExpd module:(NSString *)module padding:(int)padding;

/**
 *  @Author 刘宝, 2015-07-14 13:07:06
 *
 *  RSA公钥加密，对应要用RSA私钥解密
 *
 *  @param content 内容
 *  @param pubExpd 公钥部分
 *  @param module  加密模块
 *
 *  @return 加密后内容
 */
+(NSString *)rsaPublicKeyEncryptString:(NSString *)content pubExpd:(NSString *)pubExpd module:(NSString *)module;

/**
 *  @Author 刘宝, 2015-07-14 13:07:02
 *
 *  RSA私钥解密
 *
 *  @param content  内容
 *  @param pubExpd  公钥部分
 *  @param privExpd 私钥部分
 *  @param module   加密模块
 *  @param padding  格式
 *
 *  @return 解密后内容
 */
+(NSString *)rsaPrivateKeyDecryptString:(NSString *)content pubExpd:(NSString *)pubExpd privExpd:(NSString *)privExpd module:(NSString *)module padding:(int)padding;

/**
 *  @Author 刘宝, 2015-07-14 13:07:02
 *
 *  RSA私钥解密
 *
 *  @param content  内容
 *  @param pubExpd  公钥部分
 *  @param privExpd 私钥部分
 *  @param module   加密模块
 *
 *  @return 解密后内容
 */
+(NSString *)rsaPrivateKeyDecryptString:(NSString *)content pubExpd:(NSString *)pubExpd privExpd:(NSString *)privExpd module:(NSString *)module;

/**
 *  @Author 刘宝, 2015-07-14 13:07:41
 *
 *  RSA私钥加密
 *
 *  @param content  内容
 *  @param pubExpd  公钥部分
 *  @param privExpd 私钥部分
 *  @param module   加密模块
 *  @param padding  格式
 *
 *  @return 加密后内容
 */
+(NSString *)rsaPrivateKeyEncryptString:(NSString *)content pubExpd:(NSString *)pubExpd privExpd:(NSString *)privExpd module:(NSString *)module padding:(int)padding;

/**
 *  @Author 刘宝, 2015-07-14 13:07:41
 *
 *  RSA私钥加密
 *
 *  @param content  内容
 *  @param pubExpd  公钥部分
 *  @param privExpd 私钥部分
 *  @param module   加密模块
 *
 *  @return 加密后内容
 */
+(NSString *)rsaPrivateKeyEncryptString:(NSString *)content pubExpd:(NSString *)pubExpd privExpd:(NSString *)privExpd module:(NSString *)module;

/**
 *  @Author 刘宝, 2015-07-14 13:07:17
 *
 *  RSA公钥解密
 *
 *  @param content 内容
 *  @param pubExpd 公钥部分
 *  @param module  加密模块
 *  @param padding  格式
 *
 *  @return 解密后内容
 */
+(NSString *)rsaPublicKeyDecryptString:(NSString *)content pubExpd:(NSString *)pubExpd module:(NSString *)module padding:(int)padding;

/**
 *  @Author 刘宝, 2015-07-14 13:07:17
 *
 *  RSA公钥解密
 *
 *  @param content 内容
 *  @param pubExpd 公钥部分
 *  @param module  加密模块
 *
 *  @return 解密后内容
 */
+(NSString *)rsaPublicKeyDecryptString:(NSString *)content pubExpd:(NSString *)pubExpd module:(NSString *)module;

/**
 *  @Author 刘宝, 2015-07-14 14:07:11
 *
 *  利用证书公钥进行加密
 *
 *  @param data        原始的二进制
 *  @param pubCertPath 证书公钥的路径
 *
 *  @return 加密的二进制
 */
+(NSData *)rsaEncryptData:(NSData *)data pubCertPath:(NSString *)pubCertPath;

/**
 *  @author 刘宝, 2016-11-16 17:11:10
 *
 *  利用证书私钥进行解密
 *
 *  @param data        加密的二进制
 *  @param priCertPath 证书私钥路径
 *  @param password    证书私钥密码
 *
 *  @return 解密后的二进制
 */
+(NSData *)rsaDecryptData:(NSData *)data priCertPath:(NSString *)priCertPath password:(NSString *)password;

@end
