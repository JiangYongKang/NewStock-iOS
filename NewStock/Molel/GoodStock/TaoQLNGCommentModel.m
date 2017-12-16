//
//  TaoQLNGCommentModel.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGCommentModel.h"

@implementation TaoQLNGCommentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"icon":@"u.ico.origin",
             @"name":@"u.n",
             @"tm":@"tm",
             @"c":@"c",
             @"uid":@"u.uid",
             };
}

@end
