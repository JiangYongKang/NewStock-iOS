//
//  NSMutableDictionary+DataRow.h
//  TKDataBase_V1
//
//  Created by liubao on 14-11-14.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  DataRow
 */
@interface NSMutableDictionary (TKDataRow)
/**
 *  设置字符串
 *
 *  @param value
 *  @param key
 */
-(void)setString:(NSString *)value withKey:(NSString *)key;

/**
 *  设置Int类型
 *
 *  @param value
 *  @param key
 */
-(void)setInt:(int)value withKey:(NSString *)key;

/**
 *  设置Long类型
 *
 *  @param value
 *  @param key
 */
-(void)setLong:(long)value withKey:(NSString *)key;

/**
 *  设置Long Long类型
 *
 *  @param value
 *  @param key
 */
-(void)setLongLong:(long long)value withKey:(NSString *)key;

/**
 *  设置Float类型
 *
 *  @param value
 *  @param key
 */
-(void)setFloat:(float)value withKey:(NSString *)key;

/**
 *  设置Double类型
 *
 *  @param value
 *  @param key
 */
-(void)setDouble:(double)value withKey:(NSString *)key;

/*
 *  设置数字类型
 *
 *  @param value
 *  @param key
 */
-(void)setInteger:(NSInteger)value withKey:(NSString *)key;

/**
 *  设置Number类型
 *
 *  @param value
 *  @param key
 */
-(void)setNumber:(NSNumber *)value withKey:(NSString *)key;

/**
 *  设置bool类型
 *
 *  @param value
 *  @param key
 */
-(void)setBool:(BOOL)value withKey:(NSString *)key;

/**
 *  设置对象
 *
 *  @param obj
 *  @param key
 */
-(void)setObject:(NSObject *)obj withKey:(NSString *)key;

/**
 *  获取字符串
 *
 *  @param key
 *
 *  @return
 */
-(NSString *)getStringWithKey:(NSString *)key;

/**
 *  获取int
 *
 *  @param key
 *
 *  @return
 */
-(int)getIntWithKey:(NSString *)key;

/**
 *  获取Long
 *
 *  @param key
 *
 *  @return
 */
-(long)getLongWithKey:(NSString *)key;

/**
 *  获取Long Long
 *
 *  @param key
 *
 *  @return
 */
-(long long)getLongLongWithKey:(NSString *)key;

/**
 *  获取float
 *
 *  @param key
 *
 *  @return
 */
-(float)getFloatWithKey:(NSString *)key;

/**
 *  获取double
 *
 *  @param key
 *
 *  @return
 */
-(double)getDoubleWithKey:(NSString *)key;

/**
 *  获取数字
 *
 *  @param key
 *
 *  @return
 */
-(NSInteger)getIntegerWithKey:(NSString *)key;

/**
 *  获取Number
 *
 *  @param key
 *
 *  @return
 */
-(NSNumber *)getNumberWithKey:(NSString *)key;

/**
 *  获取Bool
 *
 *  @param key
 *
 *  @return
 */
-(BOOL)getBoolWithKey:(NSString *)key;

/**
 *  获取对象
 *
 *  @param key
 *
 *  @return
 */
-(NSObject *)getObjectWithKey:(NSString *)key;

@end
