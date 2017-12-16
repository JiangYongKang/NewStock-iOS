//
//  TaoQLNGListModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGListModel.h"

@implementation TaoQLNGListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tm":@"tm",
             @"list":@"list",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoQLNGStockListModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoQLNGStockListModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}



@end


@implementation TaoQLNGStockListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"s":@"s",
             @"n":@"n",
             @"m":@"m",
             @"zx":@"zx",
             @"zdf":@"zdf",
             @"highestChg":@"highestChg",
             @"inPrice":@"inPrice",
             };
}

@end
