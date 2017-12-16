//
//  TaoSearchPPlModel.m
//  NewStock
//
//  Created by 王迪 on 2017/3/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchPPlModel.h"

@implementation TaoSearchPPlModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dsc":@"dsc",
             @"list":@"list",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoSearchPPlListModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoSearchPPlListModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}
@end

@implementation TaoSearchPPlListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"bd":@"bd",
             @"cn":@"cn",
             @"m":@"m",
             @"n":@"n",
             @"s":@"s",
             @"sum":@"sum",
             @"t":@"t",
             };
}

@end
