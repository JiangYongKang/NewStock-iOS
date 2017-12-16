//
//  DgzqMessageAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/7.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "DgzqMessageAPI.h"
#import "Defination.h"

@implementation DgzqMessageAPI

- (NSString *)requestUrl {
    return API_DGZQ_MESSAGE;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    return @{
             @"message": self.message,
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
