//
//  TKFormatHelper.h
//  TKUtil
//
//  Created by liubao on 14-11-3.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  格式化选项
 */
typedef enum
{
    /**
     *  不为空
     */
    TKFormatOption_NotEmpty,
    /**
     *  日期
     */
    TKFormatOption_Date,
    /**
     *  日期时间
     */
    TKFormatOption_DateTime,
    /**
     *  字母数字
     */
    TKFormatOption_AlphaNumeric,
    /**
     *  电子邮件
     */
    TKFormatOption_Email,
    /**
     *  货币
     */
    TKFormatOption_Money,
    /**
     *  数字
     */
    TKFormatOption_Numeric,
    /**
     *  浮点数
     */
    TKFormatOption_NumberFloat,
    /**
     *  手机号
     */
    TKFormatOption_Mobile,
    /**
     *  电话
     */
    TKFormatOption_Phone,
    /**
     *  固话
     */
    TKFormatOption_Tel,
    /**
     *  邮政编码
     */
    TKFormatOption_PostalCode,
    /**
     *  网址
     */
    TKFormatOption_URL,
    /**
     *  身份证
     */
    TKFormatOption_CardID,
    /**
     *  股票代码
     */
    TKFormatOption_Stock,
    /**
     *  强交易密码
     */
    TKFormatOption_StrongPwd,
    /**
     *  银行卡
     */
    TKFormatOption_BankCode,
    /**
     *  中文，英文，字母或_
     */
    TKFormatOption_CnAndEnNumeric,
    /**
     *  英文，字母或_
     */
    TKFormatOption_EnNumeric,
    /**
     *  中文
     */
    TKFormatOption_Chinese
} TKFormatOption;

/**
 *  字符串格式化判断的帮助类
 */
@interface TKFormatHelper : NSObject

/**
 *  判断字符串是否满足正则表达式
 *
 *  @param regex 正则表达式
 *  @param str   要校验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isFormatRegex:(NSString *)regex with:(NSString *)str;

/**
 *  判断字符串是否为日期，正确格式为YYYY-MM-DD或者YYYY/MM/DD
 *
 *  @param str 要校验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isDate:(NSString *)str;

/**
 *  判断是否为长时间，例如 YYYY-MM-DD HH:mm:ss或者YYYY/MM/DD HH:mm:ss
 *
 *  @param str 要校验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isDateTime:(NSString *)str;

/**
 *  判断字符串是否为字母或数字
 *
 *  @param str 要校验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isAlphaNumber:(NSString *)str;

/**
 *  判断是否为中文，英文，字母或_
 *
 *  @param str 要校验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isCnAndEnNumeric:(NSString *)str;

/**
 *  判断是否为英文，字母或_
 *
 *  @param str 要校验的字母串
 *
 *  @return YES,NO
 */
+(BOOL)isEnNumeric:(NSString *)str;

/**
 *  判断是否为中文
 *
 *  @param str 要校验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isChinese:(NSString *)str;

/**
 *  判断是否是邮箱
 *
 *  @param str 要校验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isEmail:(NSString *)str;

/**
 *  判断是否是货币
 *
 *  @param str 要校验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isMoney:(NSString *)str;

/**
 *  判断是否为数字
 *
 *  @param str 要检验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isNumeric:(NSString *)str;

/**
 *  判断是否是浮点数
 *
 *  @param str 要检验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isNumberFloat:(NSString *)str;

/**
 *  判断是否是手机号
 *
 *  @param str 要检验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isMobile:(NSString *)str;

/**
 *  判断是否是电话，包含手机和固话
 *
 *  @param str 要检验的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isPhone:(NSString *)str;

/**
 *  判断是否为固话
 *
 *  @param str 要检查的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isTel:(NSString *)str;

/**
 *  判断是否是邮政编码
 *
 *  @param str 要检查的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isPostalCode:(NSString *)str;

/**
 *  判断是否为合法的URL
 *
 *  @param str 要检查的字符串
 *
 *  @return YES，NO
 */
+(BOOL)isURL:(NSString *)str;

/**
 *  判断是否为身份证
 *
 *  @param str 要检查的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isCardID:(NSString *)str;

/**
 *  判断是否六位交易密码
 *
 *  @param str 要检测的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isTradePassword:(NSString *)str;

/**
 *  判断是否6位强交易密码
 *
 *  @param str 要检查的密码字符串
 *  @param filters 要过滤数组,数组中的每一项都不能包含当前的密码串，否则认为密码为弱密码，比如可以用身份证，手机等校验
 
 *  @return YES,NO
 */
+(BOOL)isStrongPassword:(NSString *)str filters:(NSArray *)filters;

/**
 *  判断是否6位强交易密码
 *
 *  @param str 要检查的密码字符串
 
 *  @return YES,NO
 */
+(BOOL)isStrongPassword:(NSString *)str;

/**
 *  判断是否是银行密码
 *
 *  @param str 要检查的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isBankCode:(NSString *)str;

/**
 *  校验字符串格式
 *
 *  @param srcStr      要校验的字符串
 *  @param description 描述
 *  @param option      校验格式
 *  @param filter      过滤字符串数组，用于密码强弱校验，过滤数组,数组中的每一项都不能包含当前的密码串，否则认为密码为弱密码，比如可以用身份证，手机等校验
 *
 *  @return 校验结果
 */
+(NSString *)checkValid:(NSString *)srcStr description:(NSString *)description option:(TKFormatOption)option filter:(NSArray*)filter;

/**
 *  校验字符串格式
 *
 *  @param srcStr      要校验的字符串
 *  @param description 描述
 *  @param option      校验格式
 *
 *  @return 校验结果
 */
+(NSString *)checkValid:(NSString *)srcStr description:(NSString *)description option:(TKFormatOption)option;

@end
