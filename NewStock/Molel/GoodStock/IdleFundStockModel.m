//
//  IdleFundStockModel.m
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "IdleFundStockModel.h"

@implementation IdleFundStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"icon":@"icon",
             @"dsc":@"dsc",
             @"list":@"list",
             @"title":@"title",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            IdleFundStockListModel * tagItem = [MTLJSONAdapter modelOfClass:[IdleFundStockListModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}



@end

@implementation IdleFundStockListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"s":@"s",
             @"t":@"t",
             @"m":@"m",
             @"zx":@"zx",
             @"zdf":@"zdf",
             };
}

@end
