//
//  TKASIHttpDao.h
//  TKApp
//
//  Created by liubao on 14-11-24.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKBaseDao.h"
#import "TKServiceDelegate.h"

/**
 *  @Author 刘宝, 2014-11-24 22:11:04
 *
 *  同步，异步Http请求
 */
@interface TKHttpDao : TKBaseDao

/**
 *  @Author 刘宝, 2014-11-25 15:11:20
 *
 *  单例模式
 *
 *  @return 单例
 */
+(TKHttpDao *)shareInstance;

@end
