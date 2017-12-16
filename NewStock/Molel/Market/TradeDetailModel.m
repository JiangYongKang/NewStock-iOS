//
//  TradeDetailModel.m
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "TradeDetailModel.h"

@implementation TradeDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"ask" : @"ask",
             @"bid" : @"bid",
             @"hand" : @"hand",
             @"largeOrder" : @"largeOrder",
             @"presentPrice" : @"presentPrice",
             @"prevClose" : @"prevClose",
             @"pricePrecision" : @"pricePrecision",
             @"volume" : @"volume",
             @"time" : @"time",
             @"stroke" : @"stroke"
             };
}

+ (NSValueTransformer *)timeJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
//        return [NSDate dateWithTimeIntervalSince1970:dateNum.doubleValue/1000];
//    } reverseBlock:^(NSDate *date) {
//        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
//    }];
//    

    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *dateNum, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:dateNum.doubleValue/1000];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }];
}

@end
