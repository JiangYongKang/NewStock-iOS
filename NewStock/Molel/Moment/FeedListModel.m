//
//  FeedListModel.m
//  NewStock
//
//  Created by 王迪 on 2016/12/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FeedListModel.h"


@implementation FeedListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tm" : @"tm",
             @"ids": @"id",
             @"tt" : @"tt",
             @"c"  : @"c",
             @"u"  : @"u",
             @"ss" : @"ss",
             @"ctm": @"ctm",
             @"istop": @"istop",
             @"tag": @"tag",
             @"lkd": @"lkd",
             @"imgs": @"imgs",
             @"url":@"funcUrl",
             @"sl":@"sl",
             @"sr":@"sr.n",
             @"ty":@"ty",
             @"pid":@"pid",
             };
}

+ (NSValueTransformer *)slJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            FeedListSLModel * tagItem = [MTLJSONAdapter modelOfClass:[FeedListSLModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

+ (NSValueTransformer *)uJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[FeedListUserModel class]];
}

+ (NSValueTransformer *)ssJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[FeedListFootModel class]];
}

+ (NSValueTransformer *)ctmJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[FeedListCtmModel class]];
}

@end

@implementation FeedListCtmModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"stag_code" : @"stag_code",
             @"ams" : @"ams",
             };
}

@end

@implementation FeedListUserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n"   : @"n",
             @"aty" : @"aty",
             @"ico" : @"ico",
             @"uid"  : @"uid",
             @"fld"  : @"fld",
             @"tag"  : @"tag",
             };
}

+ (NSValueTransformer *)uJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[FeedListUserModel class]];
}

+ (NSValueTransformer *)icoJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[FeedListIconModel class]];
}

@end

@implementation FeedListIconModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"origin"   : @"origin",
             };
}

@end


@implementation FeedListFootModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"clk" : @"clk",
             @"cs"  : @"cs",
             @"lkd" : @"lkd",
             };
}

@end

@implementation FeedListSLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"s":@"s",
             @"n":@"n",
             @"m":@"m",
             @"c":@"c",
             };
}

@end

