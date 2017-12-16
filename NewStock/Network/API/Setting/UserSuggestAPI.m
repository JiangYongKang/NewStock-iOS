//
//  UserSuggestAPI.m
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UserSuggestAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation UserSuggestAPI


- (id)initWithUserId:(NSString *)userId
             content:(NSString *)content
{
    self = [super init];
    if (self) {
        _userId = userId;
        _content = content;
    }
    return self;
}

- (NSString *)requestUrl {
    return USER_SUGGEST;
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
             @"c": _content,
             @"tel": _tel
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
