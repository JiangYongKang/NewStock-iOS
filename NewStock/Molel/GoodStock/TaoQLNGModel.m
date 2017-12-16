//
//  TaoQLNGModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGModel.h"

@implementation TaoQLNGModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tt":@"tt",
             @"tm":@"tm",
             @"comment":@"comment",
             @"desc":@"desc",
             @"list":@"list",
             @"star":@"star",
             @"three":@"three",
             @"five":@"five",
             @"win":@"win",
             @"url":@"url",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoQLNGStockModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoQLNGStockModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

+ (NSValueTransformer *)commentJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TaoQLNGUserModel class]];
}

@end

@implementation TaoQLNGStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"s":@"s",
             @"n":@"n",
             @"m":@"m",
             @"zx":@"zx",
             @"zdf":@"zdf",
             @"ip":@"ip",
             @"maxzdf":@"maxzdf",
             };
}

@end

@implementation TaoQLNGUserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"c":@"c",
             @"icon":@"icon",
             @"name":@"name",
             @"uid":@"uid",
             };
}

@end
