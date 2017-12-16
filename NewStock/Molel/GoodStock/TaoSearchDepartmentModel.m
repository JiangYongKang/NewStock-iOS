//
//  TaoSearchDepartmentModel.m
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchDepartmentModel.h"

@implementation TaoSearchDepartmentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"list":@"list",
             @"mop":@"mop",
             @"mnb":@"mnb",
             };
}

+ (NSValueTransformer *)mopJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TaoSearchDepartmentListModel class]];
}

+ (NSValueTransformer *)mnbJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TaoSearchDepartmentListModel class]];
}


+ (NSValueTransformer *)listJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TaoSearchDepartmentListModel * tagItem = [MTLJSONAdapter modelOfClass:[TaoSearchDepartmentListModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation TaoSearchDepartmentListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"s":@"s",
             @"t":@"t",
             @"m":@"m",
             @"sty":@"sty",
             @"stn":@"stn",
             @"zdf":@"zdf",
             @"num":@"num",
             @"tm":@"tm",
             };
}

@end



