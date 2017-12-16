//
//  YearModel.m
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "YearModel.h"

@implementation YearModel

+ (NSArray <YearModel *> *)anayliesDate:(NSArray *)arr {

    NSMutableArray <YearModel *> *nmYear = [NSMutableArray array];
    
    for (int i = 0; i < arr.count; i ++) {
        
        NSString *str = arr[i];
        NSString *yearS = [str substringWithRange:NSMakeRange(0, 4)];
        NSString *monthS = [str substringWithRange:NSMakeRange(5, 2)];
        NSString *dayS = [str substringWithRange:NSMakeRange(8, 2)];
        
        //年
        YearModel *yModel = nil;
        for (YearModel *model in nmYear) {
            if ([model.yearStr isEqualToString:yearS]) {
                yModel = model;
            }
        }
        if (yModel == nil) {
            yModel = [YearModel new];
            yModel.yearStr = yearS;
            [nmYear addObject:yModel];
        }
        
        //月
        MonthModel *mModel = nil;
        for (MonthModel *model in yModel.monthArray) {
            if ([model.monthStr isEqualToString:monthS]) {
                mModel = model;
            }
        }
        if (mModel == nil) {
            mModel = [MonthModel new];
            mModel.monthStr = monthS;
            [yModel.monthArray addObject:mModel];
        }
        
        //日
        DayModel *dModel = nil;
        for (DayModel *model in mModel.dayArray) {
            if ([model.dayStr isEqualToString:dayS]) {
                dModel = model;
            }
        }
        
        if (dModel == nil) {
            dModel = [DayModel new];
            dModel.dayStr = dayS;
            [mModel.dayArray addObject:dModel];
        }
        
    }
    return nmYear;
}

- (NSMutableArray <MonthModel *> *)monthArray {
    if (_monthArray == nil) {
        _monthArray = [NSMutableArray array];
    }
    return _monthArray;
}

@end
