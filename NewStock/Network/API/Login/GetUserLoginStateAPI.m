//
//  GetUserLoginStateAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/3/29.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "GetUserLoginStateAPI.h"
#import "Defination.h"

@implementation GetUserLoginStateAPI

- (NSString *)requestUrl {
    return API_GET_USER_LOGIN_STATE;
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
