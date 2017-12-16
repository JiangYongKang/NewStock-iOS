//
//  NSString+getLength.m
//  NewStock
//
//  Created by 王迪 on 2017/3/16.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "NSString+getLength.h"

@implementation NSString (getLength)


- (NSInteger)calculateTextNumber {
    float number = 0.0;
    int index;
    for (index = 0; index < [self length]; index++) {
        
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number++;
        } else {
            number = number+0.5;
        }
    }
    return ceil(number);
}


@end
