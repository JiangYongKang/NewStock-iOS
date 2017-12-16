//
//  UserFollowedAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/1/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "UserFollowedAPI.h"
#import "GetUserDynamicAPI.h"
#import "Defination.h"
#import "SystemUtil.h"


@implementation UserFollowedAPI

- (instancetype)initWithSt:(NSString *)st fuid:(NSString *)fuid {
    if (self = [super init]) {
        self.st = st;
        self.fuid = fuid;
    }
    return self;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_USER_FOLLOWED;
}

- (id)requestArgument {
    NSDictionary *dict = @{
                           @"st":self.st,
                           @"fuid":self.fuid,
                           };
    NSArray *arr = [NSArray arrayWithObject:dict];
    return arr;
}



@end
