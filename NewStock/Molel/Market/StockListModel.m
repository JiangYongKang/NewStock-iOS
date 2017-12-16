//
//  StockListModel.m
//  NewStock
//
//  Created by Willey on 16/8/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockListModel.h"

@implementation StockListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"symbol" : @"symbol",
             @"symbolTyp" : @"symbolTyp",
             @"marketCd" : @"marketCd",
             @"consecutivePresentPrice" : @"consecutivePresentPrice",
             @"presentPrice":@"presentPrice",
             @"tradeIncrease" : @"tradeIncrease",
             @"stockUD" : @"stockUD",
             @"symbolName" : @"symbolName",
             @"min5UpDown" : @"min5UpDown",
             @"sectorTurnover" : @"sectorTurnover",
             @"consecutiveVolume" : @"consecutiveVolume",
             @"turnover" : @"turnover",
             @"volumePrice" : @"volumePrice",
             @"riseCount" : @"riseCount",
             @"fallCount" : @"fallCount",
             @"keepCount" : @"keepCount"
             };
}

@end
