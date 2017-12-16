//
//  StockPerformModel.m
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockPerformModel.h"

@implementation StockPerformModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"s":@"s",
             @"n":@"n",
             @"m":@"m",
             @"tm":@"tm",
             @"pf":@"pf",
             @"tzf":@"tzf",
             @"zx":@"zx",
             @"pr":@"pr",
             };
}

@end
