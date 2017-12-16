//
//  StockApplyModel.m
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockApplyModel.h"

@implementation StockApplyModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tm":@"tm",
             @"wk":@"wk",
             @"list":@"list",
             @"count":@"count",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * tagsArray = [NSMutableArray array];
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            StockApplyModelList * tagItem = [MTLJSONAdapter modelOfClass:[StockApplyModelList class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        return tagsArray;
    }];
}

@end

@implementation StockApplyModelList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"mx":@"mx",
             @"n":@"n",
             @"pe":@"pe",
             @"pr":@"pr",
             @"s":@"s",
             @"tm":@"tm",
             @"lr":@"lr",
             };
}

@end
