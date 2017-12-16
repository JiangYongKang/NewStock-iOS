//
//  RedRootModel.m
//  NewStock
//
//  Created by 王迪 on 2017/2/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "RedRootModel.h"

@implementation RedRootModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"tm":@"tm",
             @"slg":@"slg",
             @"dsc":@"dsc",
             @"list":@"list",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            RedRootListModel * tagItem = [MTLJSONAdapter modelOfClass:[RedRootListModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}


@end

@implementation RedRootListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"n":@"n",
             @"s":@"s",
             @"t":@"t",
             @"m":@"m",
             @"tv":@"tv",
             @"dsc":@"dsc",
             @"zdf":@"zdf",
             @"bt":@"bt",
             @"st":@"st",
             @"buy":@"buy",
             @"nbuy":@"nbuy",
             @"sale":@"sale",
             };
}


+ (NSValueTransformer *)buyJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            RedRootBSListModel * tagItem = [MTLJSONAdapter modelOfClass:[RedRootBSListModel class] fromJSONDictionary:obj error:nil];
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
            RedRootBSListModel * tagItem = [MTLJSONAdapter modelOfClass:[RedRootBSListModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}


@end

@implementation RedRootBSListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"n":@"n",
             @"s":@"s",
             @"b":@"b",
             };
}

@end


