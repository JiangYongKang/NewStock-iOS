//
//  TKStringHelper.h
//  TKUtil
//
//  Created by liubao on 14-10-31.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NSString* (^ReplaceBlock)(NSString*,NSInteger);

/**
 *  字符串相关帮助类
 */
@interface TKStringHelper : NSObject

/**
 *  判断字符串是否为空，空格也算空
 *
 *  @param str 需要判断的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isEmpty:(NSString *)str;

/**
 *  判断字符串是否为非空
 *
 *  @param str 需要判断的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isNotEmpty:(NSString *)str;

/**
 *  产生num位随机数
 *
 *  @param num 随机数的位数
 *
 *  @return 生成的随机数
 */
+(NSString *)stringWithRandom:(int)num;

/**
 *  全部替换字符串，支持正则表达式
 *
 *  @param source 原字符串
 *  @param oldStr 需要替换的字符串，支持正则表达式
 *  @param newStr 用来替换的字符串
 *
 *  @return 替换后新的字符串
 */
+(NSString *)stringWithReplace:(NSString *)srcStr oldStr:(NSString *)oldStr newStr:(NSString *)newStr;

/**
 *  全部替换字符串，支持正则表达式
 *
 *  @param source 原字符串
 *  @param oldStr 需要替换的字符串，支持正则表达式
 *  @param block  用于处理替换的块函数 NSString* ^(NSString*,int)
 *
 *  @return 替换后新的字符串
 */
+(NSString *)stringWithReplace:(NSString *)srcStr oldStr:(NSString *)oldStr block:(ReplaceBlock)block;

/**
 * 去掉两边的空格，如果入参是nil自动转换为空字符串
 *
 *  @param str 需要操作的字符串
 *
 *  @return
 */
+(NSString *)stringWithTrim:(NSString *)str;

/**
 *  判断字符串是否以指定的字符串开头
 *
 *  @param source 源字符串
 *  @param str    要判断的字符串的值
 *
 *  @return YES,NO
 */
+(BOOL)string:(NSString *)srcStr beginWith:(NSString *)str;

/**
*  判断字符串是否以指定的字符串结尾
*
*  @param source 源字符串
*  @param str    要判断的字符串的值
*
*  @return YES,NO
*/
+(BOOL)string:(NSString *)srcStr endWith:(NSString *)str;

/**
 *  截取字符串
 *
 *  @param source 原字符串
 *  @param begin  开始索引
 *  @param end    结束索引
 *
 *  @return 截取的字符串
 */
+(NSString *)subStringWith:(NSString *)srcStr fromIndex:(NSInteger)begin toIndex:(NSInteger)end;

/**
 *  截取字符串
 *
 *  @param source 原字符串
 *  @param begin  开始索引
 *  @param count  截取数目
 *
 *  @return 截取的字符串
 */
+(NSString *)subStringWith:(NSString *)srcStr fromIndex:(NSInteger)begin count:(NSInteger)count;

/**
 *  查找字符串
 *
 *  @param srcStr 原字符串
 *  @param str    要查找的字符串
 *
 *  @return 返回字符串的位置，没有返回-1
 */
+(NSInteger)string:(NSString *)srcStr indexOf:(NSString *)str;

/**
 *  查找最后匹配的字符串
 *
 *  @param srcStr 原字符串
 *  @param str    要查找的字符串
 *
 *  @return 返回字符串的位置，没有返回-1
 */
+(NSInteger)string:(NSString *)srcStr lastIndexOf:(NSString *)str;

/**
 *  分割字符串,分隔符支持正则表达式
 *
 *  @param srcStr 原字符串
 *  @param str    分割符,支持正则表达式
 *
 *  @return 字符串数组
 */
+(NSArray *)string:(NSString *)srcStr splitWith:(NSString *)str;

/**
 *  字符串数组链接
 *
 *  @param array 字符串数组
 *
 *  @return 链接后的字符串
 */
+(NSString *)stringWithArray:(NSArray *)array;

/**
 *  获取Url的参数
 *
 *  @param url 地址
 *
 *  @return 参数数据字典
 */
+(NSDictionary *)getUrlParam:(NSString *)url;

/**
 *  根据正则表达式找到第一个满足的子串
 *
 *  @param srcStr 原字符串
 *  @param regExp 正则表达式
 *
 *  @return 子字符串
 */
+(NSString *)firstSubStringWith:(NSString *)srcStr byRegExp:(NSString *)regExp;

/**
 *  根据正则表达式找到最后一个满足的子串
 *
 *  @param srcStr 原字符串
 *  @param regExp 正则表达式
 *
 *  @return 子字符串
 */
+(NSString *)lastSubStringWith:(NSString *)srcStr byRegExp:(NSString *)regExp;

/**
 *  根据正则表达式找到所有满足的字符串
 *
 *  @param srcStr 原字符串
 *  @param regExp 正则表达式
 *
 *  @return 子字符串数组
 */
+(NSArray *)subStringsWith:(NSString *)srcStr byRegExp:(NSString *)regExp;

/**
 *  URL编码
 *
 *  @param url
 *
 *  @return utf-8编码的结果
 */
+(NSString *)encodeURL:(NSString *)url;

/**
 *  URL编码
 *
 *  @param url
 *
 *  @return utf-8编码的结果
 */
+(NSString *)escapeURL:(NSString *)url;

/**
 *  URL解码
 *
 *  @param url
 *
 *  @return utf-8解码的结果
 */
+(NSString *)decodeURL:(NSString *)url;

/**
 *  @Author 刘宝, 2015-04-20 10:04:15
 *
 *  UTF-8转Unicode
 *
 *  @param str 字符串
 *
 *  @return Unicode字符串
 */
+(NSString *)utfToUnicode:(NSString *)str;

/**
 *  @Author 刘宝, 2015-04-20 10:04:16
 *
 *  Unicode转成UTF-8
 *
 *  @param str 字符串
 *
 *  @return UTF-8
 */
+(NSString *)unicodeToUTF:(NSString *)str;

/**
 *  @author 刘宝, 2016-07-15 20:07:18
 *
 *  构建H5插件的URL
 *
 *  @param funcNo 功能号
 *  @param param  入参
 *
 *  @return
 */
+(NSString *)buildH5PluginURL:(NSString *)funcNo param:(NSMutableDictionary *)param;

@end
