//
//  GetUserSettingAPI.m
//  NewStock
//
//  Created by Willey on 16/9/6.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "GetUserSettingAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation GetUserSettingAPI


- (NSString *)requestUrl {
    return USER_SET_LIST;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    return @{
             @"uid": _userId,
             @"pres_code": _pres_code
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
