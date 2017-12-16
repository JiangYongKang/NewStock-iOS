//
//  TaoSearchStockModel.m
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchStockModel.h"

@implementation TaoSearchStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"tm":@"tm",
             @"zx":@"zx",
             @"zxzdf":@"zxzdf",
             @"list":@"list",
             @"close":@"close",
             @"zdf":@"zdf",
             @"tvmt":@"tvmt",
             @"tvlt":@"tvlt",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoSearchStockModelList * tagItem = [MTLJSONAdapter modelOfClass:[TaoSearchStockModelList class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation TaoSearchStockModelList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"t":@"t",
             @"ct":@"ct",
             @"buy":@"buy",
             @"sale":@"sale",
             @"bt":@"bt",
             @"st":@"st",
             @"nbuy":@"nbuy",
             };
}

+ (NSValueTransformer *)buyJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoSearchStockBSModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoSearchStockBSModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

+ (NSValueTransformer *)saleJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoSearchStockBSModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoSearchStockBSModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation TaoSearchStockBSModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"b":@"b",
             @"s":@"s",
             };
}


@end
