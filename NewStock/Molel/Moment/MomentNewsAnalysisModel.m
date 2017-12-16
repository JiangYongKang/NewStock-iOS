//
//  MomentNewsAnalysisModel.m
//  NewStock
//
//  Created by 王迪 on 2017/5/25.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentNewsAnalysisModel.h"

@implementation MomentNewsAnalysisModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"ids":@"id",
             @"tm":@"tm",
             @"tt":@"tt",
             @"sy":@"sy",
             @"pic":@"pic",
             @"fid":@"fid",
             @"sl":@"sl",
             @"ss":@"ss",
             @"lkd":@"lkd",
             };
}

+ (NSValueTransformer *)slJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MomentNewsAnalysisStockModel * tagItem = [MTLJSONAdapter modelOfClass:[MomentNewsAnalysisStockModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}
@end

@implementation MomentNewsAnalysisStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"m":@"m",
             @"s":@"s",
             @"n":@"n",
             @"zdf":@"zdf",
             };
}

@end
