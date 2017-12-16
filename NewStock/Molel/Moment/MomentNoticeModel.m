//
//  MomentNoticeModel.m
//  NewStock
//
//  Created by 王迪 on 2017/3/31.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentNoticeModel.h"

@implementation MomentNoticeModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             
             @"ids":@"id",
             @"fid":@"fid",
             @"st":@"st",
             @"tm":@"tm",
             @"c":@"c",
             @"dsc":@"dsc",
             @"n":@"ru.n",
             @"url":@"url",
             @"uid":@"ru.uid",
             @"origin":@"ru.ico.origin",
             };
}

@end
