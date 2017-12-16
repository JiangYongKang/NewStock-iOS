//
//  StockCodesModel.m
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockCodesModel.h"

@implementation StockCodesModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"modified" : @"modified",
             @"lastModified" : @"lastModified",
             @"gxCodeList" : @"gxCodeList"
             };
}

+ (NSValueTransformer *)gxCodeListTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            StockCodeInfo * tagItem = [MTLJSONAdapter modelOfClass:[StockCodeInfo class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
            NSLog(@"%@",tagItem.s);
        }];
             
        return tagsArray;
    }];
}

@end








#pragma StockCodeInfo

@implementation StockCodeInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t" : @"t",
             @"s" : @"s",
             @"m" : @"m",
             @"n" : @"n",
             @"p" : @"p",
             @"d" : @"d",
             @"h" : @"h",
             @"r" : @"r",
             @"th" : @"th"
             };
}

@end
