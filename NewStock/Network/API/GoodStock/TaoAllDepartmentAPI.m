//
//  TaoAllDepartmentAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/2/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoAllDepartmentAPI.h"
#import "Defination.h"

@implementation TaoAllDepartmentAPI
{
    NSString *_lastModified;
}

- (id)initWithLastModified:(NSString *)lastModified {
    self = [super init];
    if (self) {
        _lastModified = lastModified;
    }
    return self;
}

- (NSInteger)cacheTimeInSeconds {
    return -1;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_DEPARTMENT_ALL,_lastModified];
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
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
    
    return @{@"gzip": @"Accept-Encoding"};
    
}

@end
