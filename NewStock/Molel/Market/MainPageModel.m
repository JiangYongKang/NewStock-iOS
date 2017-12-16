//
//  MainPageModel.m
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MainPageModel.h"

@implementation MainThemeStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"s":@"s",
             @"m":@"m",
             @"t":@"t",
             @"zdf":@"zdf",
             };
}

@end

@implementation MainThemeModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"ids":@"id",
             @"n":@"n",
             @"tt":@"tt",
             @"tm":@"tm",
             @"star":@"star",
             @"url":@"url",
             @"sl":@"sl",
             @"rmd":@"rmd",
             };
}

+ (NSValueTransformer *)slJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * tagsArray = [NSMutableArray array];
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MainThemeStockModel * tagItem = [MTLJSONAdapter modelOfClass:[MainThemeStockModel class] fromJSONDictionary:obj error:nil];
            [tagsArray addObject:tagItem];
        }];
        return tagsArray;
    }];
}

@end


@implementation NewStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"count":@"count",
             @"funcUrl":@"funcUrl",
             @"funcTitle":@"funcTitle",
             };
}

@end

@implementation ModuleMenuModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"name",
             @"url" : @"url",
             @"desc" : @"desc"
             };
}

@end


//
@implementation StrategyListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"strategyId" : @"id",
             @"name" : @"name",
             @"category" : @"category",
             @"source" : @"source",
             @"srcIdOfStrat" : @"srcIdOfStrat",
             @"desc" : @"desc",
             @"earningsYield" : @"earningsYield",
             @"imageList" : @"imageList"
             };
}

+ (NSValueTransformer *)imageListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ImageListModel * tagItem = [MTLJSONAdapter modelOfClass:[ImageListModel class] fromJSONDictionary:obj error:nil];
            NSLog(@"%@",tagItem.h640);
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation ImageListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"h240" : @"h240",
             @"h640" : @"h640",
             @"origin" : @"origin",
             @"format" : @"format"
             };
}
@end


//
@implementation NewsModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"newsId" : @"id",
             @"pic" : @"pic",
             @"sy" : @"sy",
             @"tm" : @"tm",
             @"tt" : @"tt"
             };
}

@end

//
@implementation ForumModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"c" : @"c",
             @"ctm" : @"ctm",
             @"funcUrl" : @"funcUrl",
             @"forumId" : @"forumId",
             @"fid" : @"id",
             @"st" : @"st",
             @"tm" : @"tm",
             @"tt" : @"tt",
             @"ty" : @"ty",
             @"cs" : @"ss.cs",
             @"fd" : @"ss.fd",
             @"clk": @"ss.clk",
             @"lkd": @"ss.lkd",
             @"hlkd" : @"lkd",
             @"stag_code" : @"stag_code",
             @"imgs" : @"imgs",
             @"seq"  : @"seq",
             @"uaty"  : @"u.aty",
             @"uico"  : @"u.ico.origin",
             @"un"  : @"u.n",
             @"uid"  : @"u.uid",
             };
  
}
+ (NSValueTransformer *)imgsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ImageListModel * tagItem = [MTLJSONAdapter modelOfClass:[ImageListModel class] fromJSONDictionary:obj error:nil];
            NSLog(@"%@",tagItem.h640);
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

//
@implementation TopicListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"topicId" : @"id",
             @"u" : @"u",
             @"ty" : @"ty",
             @"st" : @"st",
             @"tt" : @"tt",
             @"ctm" : @"ctm",
             @"c" : @"c",
             @"loc" : @"loc",
             @"mty" : @"mty",
             @"tm" : @"tm",
             @"imgs" : @"imgs"

             };
}

@end




//ReportListModel
@implementation ReportListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tt" : @"tt",
             @"c" : @"c",
             @"cs" : @"ss.cs",
             @"fd" : @"ss.fd",
             @"lkd" : @"ss.lkd",
             @"tm" : @"tm",
             @"funcUrl":@"funcUrl",
             @"uName" : @"u.n",
             @"uIco" : @"u.ico.origin",
             @"imgs" : @"imgs"
             };
}
+ (NSValueTransformer *)imgsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        
        NSMutableArray * tagsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ImageListModel * tagItem = [MTLJSONAdapter modelOfClass:[ImageListModel class] fromJSONDictionary:obj error:nil];
            NSLog(@"%@",tagItem.h640);
            [tagsArray addObject:tagItem];
        }];
        
        return tagsArray;
    }];
}

@end

@implementation LinksModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"ico":@"ico",
             @"n":@"n",
             @"url":@"url",
             };
}

@end


