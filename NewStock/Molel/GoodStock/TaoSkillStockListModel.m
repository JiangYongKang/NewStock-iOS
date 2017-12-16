//
//  TaoSkillStockListModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSkillStockListModel.h"

@implementation TaoSkillStockListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title":@"title",
             @"desc":@"desc",
             @"star":@"star",
             @"imgUrls":@"imgUrls",
             @"tm":@"tm",
             @"list":@"list",
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoSkillStockListArrayModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoSkillStockListArrayModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation TaoSkillStockListArrayModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"s":@"s",
             @"n":@"n",
             @"m":@"m",
             @"zx":@"zx",
             @"zdf":@"zdf",
             };
}

@end
