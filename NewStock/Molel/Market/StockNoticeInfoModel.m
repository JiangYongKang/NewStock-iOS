//
//  StockNoticeInfoModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/28.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockNoticeInfoModel.h"

@implementation StockNoticeInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"ins":@"in",
             @"m":@"m",
             @"n":@"n",
             @"np":@"np",
             @"outs":@"out",
             @"s":@"s",
             @"sp":@"sp",
             @"st":@"st",
             @"szdf":@"szdf",
             @"t":@"t",
             @"zdf":@"zdf",
             };
}

@end
