//
//  TaoDeepStockModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoDeepStockModel.h"

@implementation TaoDeepStockModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"t":@"t",
             @"s":@"s",
             @"n":@"n",
             @"m":@"m",
             @"zdf":@"zdf",
             @"buy":@"buy",
             @"price":@"price",
             @"cys":@"cys",
             };
}

@end
