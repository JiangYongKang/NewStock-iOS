//
//  UserDynamicModel.m
//  NewStock
//
//  Created by 王迪 on 2017/1/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "UserDynamicModel.h"

@implementation UserDynamicModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n" : @"n",
             @"userName":@"u.n",
             @"aty":@"u.aty",
             @"origin":@"u.ico.origin",
             @"sn":@"sn",
             @"tm":@"tm",
             @"sty":@"sty",
             @"ids":@"id",
             @"ty" :@"ty",
             @"uid":@"u.uid",
             @"listArray":@"list"
             };
}

+ (NSValueTransformer *)listArrayJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;

        NSMutableArray * tagsArray = [NSMutableArray array];

        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserDynamicList * tagItem = [MTLJSONAdapter modelOfClass:[UserDynamicList class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end




@implementation UserDynamicList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sty":@"sty",
             @"url":@"url",
             @"tt" :@"tt",
             @"sy" :@"sy",
             };
}


@end
