//
//  TKArrayHelper.h
//  TKUtil
//
//  Created by liubao on 14-12-2.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author 刘宝, 2014-12-02 13:12:29
 *
 *  数组帮组类
 */
@interface TKArrayHelper : NSObject

/**
 *  @Author 刘宝, 2014-12-02 13:12:50
 *
 *  移动数组中的元素
 *
 *  @param array      数组
 *  @param startIndex 起始位置
 *  @param endIndex   截止位置
 */
+(void)moveArrayItem:(NSMutableArray *)array fromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex;

@end
