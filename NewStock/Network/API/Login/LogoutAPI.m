//
//  LogoutAPI.m
//  NewStock
//
//  Created by 王迪 on 2016/12/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "LogoutAPI.h"
#import "Defination.h"


@implementation LogoutAPI


- (NSString *)requestUrl {
    return API_ACCOUNT_LOGOUT;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return nil;
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
