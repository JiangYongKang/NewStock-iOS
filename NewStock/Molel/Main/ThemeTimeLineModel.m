//
//  ThemeTimeLineModel.m
//  NewStock
//
//  Created by 王迪 on 2017/5/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ThemeTimeLineModel.h"

@implementation ThemeTimeLineModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tt":@"title",
             @"list":@"list",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * tagsArray = [NSMutableArray array];
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MainThemeModel * tagItem = [MTLJSONAdapter modelOfClass:[MainThemeModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        return tagsArray;
    }];
}

@end
