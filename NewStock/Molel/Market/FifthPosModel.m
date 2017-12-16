//
//  FifthPosModel.m
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FifthPosModel.h"

@implementation FifthPosModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"buyCount1" : @"buyCount1",
             @"buyCount2" : @"buyCount2",
             @"buyCount3" : @"buyCount3",
             @"buyCount4" : @"buyCount4",
             @"buyCount5" : @"buyCount5",

             @"buyPrice1" : @"buyPrice1",
             @"buyPrice2" : @"buyPrice2",
             @"buyPrice3" : @"buyPrice3",
             @"buyPrice4" : @"buyPrice4",
             @"buyPrice5" : @"buyPrice5",
             
             @"hand" : @"hand",
             @"marketCd" : @"marketCd",
             @"prevClose" : @"prevClose",
             @"pricePrecision" : @"pricePrecision",
             
             @"sellCount1" : @"sellCount1",
             @"sellCount2" : @"sellCount2",
             @"sellCount3" : @"sellCount3",
             @"sellCount4" : @"sellCount4",
             @"sellCount5" : @"sellCount5",

             @"sellPrice1" : @"sellPrice1",
             @"sellPrice2" : @"sellPrice2",
             @"sellPrice3" : @"sellPrice3",
             @"sellPrice4" : @"sellPrice4",
             @"sellPrice5" : @"sellPrice5",
             
             @"symbol" : @"symbol",
             @"symbolTyp" : @"symbolTyp"
             };
}


@end
