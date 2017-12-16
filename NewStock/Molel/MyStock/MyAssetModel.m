//
//  MyAssetModel.m
//  NewStock
//
//  Created by 王迪 on 2017/1/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyAssetModel.h"

@implementation MyAssetModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"allEarnings" : @"allEarnings",
             @"bookValue" : @"bookValue",
             @"cost" : @"cost",
             @"currEarnings" : @"currEarnings",
             @"posList" : @"posList",
             };
}


+ (NSValueTransformer *)posListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MyAssetListModel * tagItem = [MTLJSONAdapter modelOfClass:[MyAssetListModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation MyAssetListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"symbolName" : @"symbolName",
             @"symbol"  : @"symbol",
             @"symbolTyp" : @"symbolTyp",
             @"marketCd" : @"marketCd",
             @"inPrice" : @"inPrice",
             @"qty" : @"qty",
             @"currPrice" : @"currPrice",
             @"currEarnings" : @"currEarnings",
             @"allEarnings" : @"allEarnings",
             @"marketValue" : @"marketValue",
             @"amplitude" : @"amplitude",
             };
}

@end
