//
//  UserVertifyAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/4/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "UserVertifyAPI.h"
#import "Defination.h"

@implementation UserVertifyAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_USER_VERFITY;
}

- (id)requestArgument {
    return @{
             @"idn":self.idn,
             @"idf":self.idf,
             @"idb":self.idb,
             @"idu":self.idu,
             @"rn":self.rn,
             @"an":self.an,
             @"rs":self.rs,
             @"aspic":self.aspic.count == 0 ? [NSArray array] : self.aspic,
             };
}


@end
