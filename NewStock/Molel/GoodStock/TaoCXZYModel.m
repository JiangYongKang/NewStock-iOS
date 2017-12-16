//
//  TaoCXZYModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/21.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoCXZYModel.h"

@implementation TaoCXZYModel

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
            TaoCXZYStockModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoCXZYStockModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end


@implementation TaoCXZYStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cln":@"cln",
             @"m":@"m",
             @"n":@"n",
             @"odn":@"odn",
             @"s":@"s",
             @"t":@"t",
             @"zdf":@"zdf",
             @"zx":@"zx",
             @"open":@"open",
             @"tr":@"tr",
             @"cbon":@"cbon",
             @"oln":@"oln",
             @"r":@"r",
             @"llt":@"llt",
             @"dn":@"dn",
             };
}

@end
