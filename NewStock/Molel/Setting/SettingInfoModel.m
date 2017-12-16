//
//  SettingInfoModel.m
//  NewStock
//
//  Created by Willey on 16/9/6.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "SettingInfoModel.h"

@implementation SettingInfoModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cv" : @"cv",
             @"ev" : @"ev",
             @"n" : @"n",
             @"pres_code" : @"pres_code",
             @"res_code" : @"res_code",
             @"sv" : @"sv",
             @"uid" : @"uid"
             };
}

@end
