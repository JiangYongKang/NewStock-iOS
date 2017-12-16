//
//  DrawLotsModel.m
//  NewStock
//
//  Created by Willey on 16/11/14.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "DrawLotsModel.h"

@implementation DrawLotsModel



+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"mId" : @"id",
             @"no" : @"no",
             @"n" : @"n",
             @"vc" : @"vc",
             @"rn" : @"rn",
             @"funcUrl" : @"funcUrl",
             @"had" : @"had",
             @"contentArr" : @"c"
             };
}

+ (NSValueTransformer *)contentArrJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSArray * jsonArray = value;
        NSMutableArray * attrArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [attrArray addObject:obj];
                }];
        
        return attrArray;
        
    }];
}

@end
