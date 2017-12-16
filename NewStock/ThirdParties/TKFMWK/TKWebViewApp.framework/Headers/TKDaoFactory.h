//
//  TKDaoFactory.h
//  TKApp
//
//  Created by liubao on 14-11-26.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKServiceDaoDelegate.h"

/**
 *  @Author 刘宝, 2014-11-26 10:11:34
 *
 *  Dao工厂
 */
@interface TKDaoFactory : NSObject

/**
 *  @Author 刘宝, 2014-11-26 10:11:53
 *
 *  获取通信Dao
 *
 *  @param DaoType 类型
 *
 *  @return 通信Dao
 */
+(id<TKServiceDaoDelegate>)getDao:(DaoType)daoType;

@end
