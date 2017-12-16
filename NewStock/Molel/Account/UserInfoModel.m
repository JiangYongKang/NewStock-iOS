//
//  UserInfoModel.m
//  NewStock
//
//  Created by Willey on 16/8/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId" : @"id",
             @"n" : @"n",
             @"rn" : @"rn",
             @"st" : @"st",
             @"ico" : @"ico",
             @"origin" : @"ico.origin",
             @"h240" : @"ico.h240",
             @"ph" : @"ph",
             @"lv" : @"lv",
             @"lt" : @"lt",
             @"sc" : @"sc",
             @"aty" : @"aty",
             @"tsc": @"tsc",
             @"su" : @"su",
//             @"suid" : @"su.suid",
//             @"sr" : @"su.sr",
             @"ss" : @"ss",
             @"fs" : @"ss.fs",
             @"fds" : @"ss.fds",
             @"fl" : @"ss.fl",
             @"ams" : @"ss.ams",
             @"cs" : @"ss.cs",
             @"fv" : @"ss.fv",
             @"lk" : @"ss.lk",
             @"lkd": @"ss.lkd",
             @"token" : @"token"
             };
}
@end


