//
//  MonthModel.m
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MonthModel.h"

@implementation MonthModel

- (NSMutableArray<DayModel *> *)dayArray {
    if (_dayArray == nil) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}

@end
