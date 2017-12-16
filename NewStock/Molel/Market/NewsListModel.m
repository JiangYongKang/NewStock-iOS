//
//  NewsListModel.m
//  NewStock
//
//  Created by Willey on 16/8/17.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "NewsListModel.h"

@implementation NewsListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"m" : @"m",
             @"n" : @"n",
             @"nid" : @"nid",
             @"s" : @"s",
             @"t" : @"t",
             @"tm" : @"tm",
             @"tt" : @"tt"
             };
}
@end
