//
//  MyVertifyInfoModel.m
//  NewStock
//
//  Created by 王迪 on 2017/4/19.
//  Copyright © 2017年 Willey. All rights reserved.
//
/*
 @property (nonatomic, copy) NSString *idn;
 @property (nonatomic, copy) NSString *rn;
 @property (nonatomic, copy) NSString *rs;
 @property (nonatomic, copy) NSString *rmsg;
 @property (nonatomic, copy) NSString *st;
 @property (nonatomic, copy) NSString *ph;
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, copy) NSString *ico;

 */
#import "MyVertifyInfoModel.h"

@implementation MyVertifyInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"idn":@"idn",
             @"rmsg":@"rmsg",
             @"rn":@"rn",
             @"rs":@"rs",
             @"st":@"st",
             @"ph":@"ph",
             @"name":@"u.n",
             @"ico":@"u.ico.origin",
             };
}

@end
