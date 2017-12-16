//
//  IndexListAPI.m
//  NewStock
//
//  Created by Willey on 16/8/11.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "IndexListAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation IndexListAPI

- (NSString *)requestUrl {
    return API_INDEX_DETAILS;
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
