//
//  MyScoreModel.m
//  NewStock
//
//  Created by 王迪 on 2017/4/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyScoreModel.h"

@implementation MyScoreModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"u.n",
             @"ico":@"u.ico.origin",
             @"sc":@"sc",
             @"exd":@"exd",
             @"tsc":@"tsc",
             @"utsc":@"utsc",
             @"day":@"day.list",
             @"listInit":@"init.list",
             };
}


+ (NSValueTransformer *)dayJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MyScoreDayModel * tagItem = [MTLJSONAdapter modelOfClass:[MyScoreDayModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

+ (NSValueTransformer *)listInitJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MyScoreListModel * tagItem = [MTLJSONAdapter modelOfClass:[MyScoreListModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}


@end


@implementation MyScoreDayModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"o":@"o",
             @"s":@"s",
             @"n":@"n",
             @"sc":@"sc",
             @"p":@"p",
             @"t":@"t",
             @"url":@"url",
             };
}

@end

@implementation MyScoreListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"o":@"o",
             @"s":@"s",
             @"n":@"n",
             @"sc":@"sc",
             @"t":@"t",
             @"url":@"url",
             };
}

@end
