//
//  TaoPoolListModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/20.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoPoolListModel.h"

@implementation TaoPoolListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title":@"title",
             @"list":@"list",
             @"code":@"code",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoPoolListStockModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoPoolListStockModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation TaoPoolListStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"s":@"s",
             @"n":@"n",
             @"m":@"m",
             @"zx":@"zx",
             @"zdf":@"zdf",
             };
}

@end
