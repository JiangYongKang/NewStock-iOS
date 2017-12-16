//
//  TKLogFormatterDefault.h
//  TKUtil_V1
//
//  Created by 刘宝 on 16/6/29.
//  Copyright © 2016年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKLogFormatterDelegate.h"

/**
 *  @author 刘宝, 2016-06-29 23:06:29
 *
 *  默认格式化类
 */
@interface TKLogFormatterDefault : NSObject <TKLogFormatterDelegate>
/**
 *  Default initializer
 */
- (instancetype)init;

/**
 *  Designated initializer, requires a date formatter
 */
- (instancetype)initWithDateFormatter:(NSDateFormatter *)dateFormatter NS_DESIGNATED_INITIALIZER;

@end
