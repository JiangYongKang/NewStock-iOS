//
//  MessageModel.m
//  NewStock
//
//  Created by Willey on 16/10/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel



+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"c" : @"c",
             @"ico" : @"ico",
             @"mId" : @"id",
             @"tm" : @"tm",
             @"tt" : @"tt",
             @"ty" : @"ty",
             @"url" : @"url"
             };
}

@end
