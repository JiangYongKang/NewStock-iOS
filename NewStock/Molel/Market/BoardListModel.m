//
//  BoardListModel.m
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BoardListModel.h"

@implementation BoardListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"symbol" : @"symbol",
             @"symbolTyp" : @"symbolTyp",
             @"marketCd" : @"marketCd",
             @"industryName" : @"industryName",
             @"industryUp" : @"industryUp",
             @"riseCount" : @"riseCount",
             @"keepCount" : @"keepCount",
             @"fallCount" : @"fallCount",
             
             @"leadingStock" : @"leadingStock",
             @"leadingStockName" : @"d"
             };
}
@end
