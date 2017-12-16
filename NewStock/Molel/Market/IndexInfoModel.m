//
//  IndexInfoModel.m
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "IndexInfoModel.h"


@implementation IndexInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"consecutivePresentPrice" : @"consecutivePresentPrice",
             @"consecutivePresentPriceTime" : @"consecutivePresentPriceTime",
             @"hand" : @"hand",
             @"marketCd" : @"marketCd",
             @"pricePrecision" : @"pricePrecision",
             @"stockUD" : @"stockUD",
             @"symbol" : @"symbol",
             @"symbolName" : @"symbolName",
             @"symbolTyp" : @"symbolTyp",
             @"symbolView" : @"symbolView",
             @"tradeIncrease" : @"tradeIncrease"
             };
}

//+ (NSValueTransformer *)JSONTransformer {
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        NSArray * jsonArray = value;
//        NSMutableArray * attrArray = [NSMutableArray array];
//        
//        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            [attrArray addObject:obj];
//        }];
//        
//        return attrArray;
//    }];
//}


@end
