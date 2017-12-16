//
//  LoadInfo.h
//  TKApp
//
//  Created by liubao on 14-11-25.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKUtil.h"

/**
 *  @Author 刘宝, 2014-11-25 14:11:43
 *
 *  加载的数据
 */
@interface LoadInfo :DynModel

/**
 *  @Author 刘宝, 2014-11-25 14:11:25
 *
 *  总共的长度
 */
@property(nonatomic,assign)long long bytesTotal;

/**
 *  @Author 刘宝, 2014-11-25 14:11:50
 *
 *  已经加载的长度
 */
@property(nonatomic,assign)long long bytesLoaded;

@end
