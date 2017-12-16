//
//  LoginAPI.m
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "LoginAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation LoginAPI


- (NSString *)requestUrl {
    return API_ACCOUNT_LOGIN;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    return @{
             @"act": _userName,
             @"pwd": _pwd
             };
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}
@end
