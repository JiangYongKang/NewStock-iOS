//
//  StockBaseInfoModel.m
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockBaseInfoModel.h"

@implementation StockBaseInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"symbolName" : @"symbolName",
             @"symbolTyp" : @"symbolTyp",
             @"symbol" : @"symbol",
             @"pricePrecision" : @"pricePrecision",
             @"consecutivePresentPrice" : @"consecutivePresentPrice",
             
             @"consecutivePresentPriceTime" : @"consecutivePresentPriceTime",
             @"hand" : @"hand",
             @"tradeIncrease" : @"tradeIncrease",
             @"stockUD" : @"stockUD",
             @"high" : @"high",
             
             @"low" : @"low",
             @"volumePrice" : @"volumePrice",
             @"open" : @"open",
             @"prevClose" : @"prevClose",
             
             @"highLimited" : @"highLimited",
             @"lowLimited" : @"lowLimited",
             @"turnover" : @"turnover",
             @"averagePrice" : @"averagePrice",
             @"consecutiveVolume" : @"consecutiveVolume",
             
             @"volumeRatio" : @"volumeRatio",
             @"quantityRatio" : @"quantityRatio",
             @"sellTotal" : @"sellTotal",
             @"buyTotal" : @"buyTotal",
             @"baseDate" : @"baseDate",
             
             @"amplitude" : @"amplitude",
             @"min5UpDpwn" : @"min5UpDpwn",
             @"industryUp" : @"industryUp",
             @"sectorMketVal" : @"sectorMketVal",
             @"riseCount" : @"riseCount",
             @"keepCount" : @"keepCount",
             @"fallCount" : @"fallCount",
             
             @"tradeHaltCnt" : @"tradeHaltCnt",
             @"zsCnt" : @"zsCnt",
             @"sectorTurnover" : @"sectorTurnover",
             @"leadingStock" : @"leadingStock",
             @"earning" : @"earning",
             @"pbRatio" : @"pbRatio",

             @"industryName" : @"industryName",
             @"zgb" : @"zgb",
             @"ltg" : @"ltg",
             @"netAsset" : @"netAsset",
             @"marketVal" : @"marketVal",
             @"totalMarketVal" : @"totalMarketVal"
};
}


@end
