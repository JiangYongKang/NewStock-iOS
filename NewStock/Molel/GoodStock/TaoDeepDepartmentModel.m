//
//  TaoDeepDepartmentModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoDeepDepartmentModel.h"

@implementation TaoDeepDepartmentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"n":@"n",
             @"buy":@"buy",
             @"sales":@"sales",
             @"count":@"count",
             };
}

@end
