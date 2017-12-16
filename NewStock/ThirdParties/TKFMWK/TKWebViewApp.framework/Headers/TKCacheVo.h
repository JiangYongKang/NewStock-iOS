//
//  CacheVo.h
//  TKAppBase_V1
//
//  Created by liubao on 15-10-12.
//  Copyright (c) 2015年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynModel.h"

/**
 缓存类型
 */
typedef enum {
    /**
     *  @Author 刘宝, 2015-10-12 12:10:11
     *
     *  内存
     */
    CacheType_Memo,
    /**
     *  @Author 刘宝, 2015-10-12 12:10:39
     *
     *  文件
     */
    CacheType_File,
    /**
     *  @Author 刘宝, 2015-10-12 12:10:59
     *
     *  数据库
     */
    CacheType_DB,
    /**
     *  @Author 刘宝, 2015-10-12 12:10:11
     *
     *  内存，命中时候自动更新
     */
    CacheType_Memo_AutoUpdate,
    
    /**
     *  @Author 刘宝, 2015-10-12 12:10:11
     *
     *  文件，命中时候自动更新
     */
    CacheType_File_AutoUpdate,
    /**
     *  @Author 刘宝, 2015-10-12 12:10:11
     *
     *  数据库，命中时候自动更新
     */
    CacheType_DB_AutoUpdate
}CacheType;

/**
 *  @Author 刘宝, 2015-10-12 12:10:53
 *
 *  缓存对象
 */
@interface TKCacheVo :DynModel

/**
 *  @Author 刘宝, 2015-10-12 12:10:38
 *
 *  缓存类型
 */
@property(nonatomic,assign)CacheType type;

/**
 *  @Author 刘宝, 2015-10-12 12:10:16
 *
 *  缓存的时间,单位秒，0代表永久缓存
 */
@property(nonatomic,assign)NSInteger cacheTime;

/**
 *  @Author 刘宝, 2015-10-12 12:10:44
 *
 *  缓存对象创建时间
 */
@property(nonatomic,assign)NSTimeInterval beginTime;

/**
 *  @Author 刘宝, 2015-10-12 12:10:19
 *
 *  缓存的数据对象
 */
@property(nonatomic,strong)NSObject *data;

/**
 *  @Author 刘宝, 2015-10-14 00:10:09
 *
 *  key
 */
@property(nonatomic,copy)NSString *key;

@end
