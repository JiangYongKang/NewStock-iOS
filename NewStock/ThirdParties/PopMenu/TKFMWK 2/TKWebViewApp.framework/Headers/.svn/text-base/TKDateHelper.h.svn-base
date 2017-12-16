//
//  TKDateHelper.h
//  TKUtil
//
//  Created by liubao on 14-11-5.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 一天的秒数
 */
#define SECS_OF_DAY (60 * 60 * 24)

/**
 *  日期处理帮助类
 */
@interface TKDateHelper : NSObject

/**
 *  把Date转换为缺省的日期格式字串，缺省的字转换格式为yyyy-MM-dd 如：2004-10-10
 *
 *  @param date 要转换的日期
 *
 *  @return 格式化以后的日期字符串
 */
+(NSString *)formatDate:(NSDate *)date;

/**
 *  把Date转换日期格式字串
 *
 *  @param date   要转换的日期
 *  @param format 格式串
 *
 *  @return 格式化以后的日期字符串
 */
+(NSString *)formatDate:(NSDate *)date format:(NSString *)format;

/**
 *  以缺省的yyyy-MM-dd格式转换字符串为Date,若转换成功，则返回相应的Date对象 若转换失败，则返回nil。
 *
 *  @param str 日期字符串
 *
 *  @return 转换后的日期对象
 */
+(NSDate *)parseDateStr:(NSString *)dateStr;

/**
 *  转换字符串为Date,若转换成功，则返回相应的Date对象 若转换失败，则返回nil。
 *
 *  @param str    日期字符串
 *  @param format 格式字符串
 *
 *  @return 转换后的日期对象
 */
+(NSDate *)parseDateStr:(NSString *)dateStr format:(NSString *)format;

/**
 *  获得特定日期的星期字串
 *
 *  @param date 日期
 *
 *  @return 星期字符串
 */
+(NSString *)getWeekStr:(NSDate *)date;

/**
 *  获得特定日期的星期数，7是星期天，1是星期一，如此类推
 *
 *  @param date 日期
 *
 *  @return 星期数
 */
+(NSInteger)getWeek:(NSDate *)date;

/**
 *  获取指定日期的年份
 *
 *  @param date 日期
 *
 *  @return 年份
 */
+(NSInteger)getYear:(NSDate *)date;

/**
 *  获取指定日期的月份
 *
 *  @param date 日期
 *
 *  @return 月份
 */
+(NSInteger)getMonth:(NSDate *)date;

/**
 *  获取指定日期的天数
 *
 *  @param date 日期
 *
 *  @return 天数
 */
+(NSInteger)getDay:(NSDate *)date;

/**
 *  提取当前时间的星期数，7是星期天，1是星期一，如此类推
 *
 *  @return 星期数
 */
+(NSInteger)getCurrentWeek;

/**
 *  提取当前的星期数的中文字串，星期一...星期日
 *
 *  @return 星期数
 */
+(NSString *)getCurrentWeekStr;

/**
 *  获取当前年份
 *
 *  @return 年份
 */
+(NSInteger)getCurrentYear;

/**
 *  获取当前月份
 *
 *  @return 月份
 */
+(NSInteger)getCurrentMonth;

/**
 *  获取当前的天数
 *
 *  @return 天数
 */
+(NSInteger)getCurrentDay;

/**
 *  获取两个日期差的秒数
 *
 *  @param date0 日期1
 *  @param date1 日期2
 *
 *  @return 日期差的毫秒数 date0 - date1
 */
+(NSInteger)getTwoDateDiffSecsFrom:(NSDate *)date0 to:(NSDate *)date1;

/**
 *  获取两个日期差的天数
 *
 *  @param date0 日期1
 *  @param date1 日期2
 *
 *  @return 日期差的天数 date0 - date1
 */
+(NSInteger)getTwoDateDiffDaysFrom:(NSDate *)date0 to:(NSDate *)date1;

/**
 *  日期减去天数，得到新的日期
 *
 *  @param date 日期
 *  @param days 天数
 *
 *  @return 新的日期
 */
+(NSDate *)getDateDiffDate:(NSDate *)date days:(NSInteger)days;

/**
 *  日期减去天数，得到新的日期
 *
 *  @param dateStr 日期字符串 yyyy-MM-dd
 *  @param days    天数
 *
 *  @return 新的日期
 */
+(NSDate *)getDateDiffDateStr:(NSString *)dateStr days:(NSInteger)days;

/**
 *  日期减去天数，得到新的日期
 *
 *  @param date 日期
 *  @param days 天数
 *
 *  @return 新的日期字符串 yyyy-MM-dd
 */
+(NSString *)getDateStrDiffDate:(NSDate *)date days:(NSInteger)days;

/**
 *  日期减去天数，得到新的日期
 *
 *  @param date 日期字符串 yyyy-MM-dd
 *  @param days 天数
 *
 *  @return 新的日期字符串 yyyy-MM-dd
 */
+(NSString *)getDateStrDiffDateStr:(NSString *)dateStr days:(NSInteger)days;

/**
 *  获取指定日期所在年的第几周
 *
 *  @param date 日期
 *
 *  @return 第几周
 */
+(NSInteger)getWeekNumOfYear:(NSDate *)date;

/**
 *  获取当前日期所在年的第几周
 *
 *  @param date 日期
 *
 *  @return 第几周
 */
+(NSInteger)getCurrentWeekNumOfYear;

@end
