//
//  TaoTuiJianModel.m
//  NewStock
//
//  Created by 王迪 on 2017/3/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoTuiJianModel.h"

@implementation TaoTuiJianModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"s":@"s",
             @"t":@"t",
             @"m":@"m",
             @"close":@"close",
             @"zdf":@"zdf",
             @"rs":@"rs",
             };
}

@end
