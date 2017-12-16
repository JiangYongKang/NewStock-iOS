//
//  TaoIndexModel.m
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoIndexModel.h"

@implementation TaoIndexModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"centerData":@"centerData",
             @"skillStock":@"skillStock",
             @"smartStock":@"smartStock",
             };
}
+ (NSValueTransformer *)smartStockJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TaoIndexModelList class]];
}
+ (NSValueTransformer *)skillStockJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TaoIndexModelList class]];
}
+ (NSValueTransformer *)centerDataJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TaoIndexModelList class]];
}

@end

@implementation TaoIndexModelList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"list":@"list",
             @"title":@"title",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoIndexModelListClild * tagItem = [MTLJSONAdapter modelOfClass:[TaoIndexModelListClild class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation TaoIndexModelListClild


+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"n":@"n",
             @"url":@"url",
             @"ico":@"ico",
             @"ids":@"id",
             @"c":@"c",
             @"count":@"count",
             @"stock":@"stock",
             };
}

+ (NSValueTransformer *)stockJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TaoIndexModelClildStock class]];
}


@end

@implementation TaoIndexModelClildStock

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"n":@"n",
             @"s":@"s",
             @"t":@"t",
             @"m":@"m",
             @"zdf":@"zdf",
             };
    
}

@end




