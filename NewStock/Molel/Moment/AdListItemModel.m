//
//  AdListItemModel.m
//  NewStock
//
//  Created by Willey on 16/8/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "AdListItemModel.h"

@implementation AdListItemModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"adId" : @"id",
             @"img" : @"img",
             @"tt" : @"tt",
             @"ty" : @"ty",
             @"url" : @"url"
             };
}

@end
