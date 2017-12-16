//
//  ThemeDetailModel.m
//  NewStock
//
//  Created by 王迪 on 2017/5/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ThemeDetailModel.h"

@implementation ThemeDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"tt":@"tt",
             @"dsc":@"dsc",
             @"tm":@"tm",
             @"star":@"star",
             @"url":@"url",
             @"rmd":@"rmd",
             @"sl":@"sl",
             @"tml":@"tml",
             @"sct":@"sct",
             @"ids":@"id",
             };
}

+ (NSValueTransformer *)slJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * tagsArray = [NSMutableArray array];
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ThemeDetailStockModel * tagItem = [MTLJSONAdapter modelOfClass:[ThemeDetailStockModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        return tagsArray;
    }];
}

+ (NSValueTransformer *)tmlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * tagsArray = [NSMutableArray array];
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ThemeDetailTmlModel * tagItem = [MTLJSONAdapter modelOfClass:[ThemeDetailTmlModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        return tagsArray;
    }];
}

+ (NSValueTransformer *)sctJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * tagsArray = [NSMutableArray array];
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ThemeDetailSctModel * tagItem = [MTLJSONAdapter modelOfClass:[ThemeDetailSctModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        return tagsArray;
    }];
}

@end

@implementation ThemeDetailTmlModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"ids":@"id",
             @"rmd":@"rmd",
             @"tt":@"tt",
             @"tm":@"tm",
             @"sl":@"sl",
             };
}

+ (NSValueTransformer *)slJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * tagsArray = [NSMutableArray array];
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ThemeDetailStockModel * tagItem = [MTLJSONAdapter modelOfClass:[ThemeDetailStockModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        return tagsArray;
    }];
}

@end

@implementation ThemeDetailStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"s":@"s",
             @"m":@"m",
             @"n":@"n",
             @"zdf":@"zdf",
             @"zx":@"zx",
             };
}

@end

@implementation ThemeDetailSctModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"s":@"s",
             @"zdf":@"zdf",
             };
}

@end
