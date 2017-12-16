//
//  GetUserDynamicAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/1/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "GetUserDynamicAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation GetUserDynamicAPI

- (instancetype)initWithPage:(NSString *)page count:(NSString *)count {
    if (self = [super init]) {
        self.page = page;
        self.count = count;
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
    return API_ACCOUNT_GET_USER_DYNAMIC;
}

- (id)requestArgument {
    NSDictionary *dict = @{
                           @"page":self.page,
                           @"count":self.count,
                           @"res_code":@"S_FORUM",
                           @"ty":@"fl",
                           };
    return dict;
}


@end
