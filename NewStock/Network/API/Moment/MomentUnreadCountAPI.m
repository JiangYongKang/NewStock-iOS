//
//  MomentUnreadCountAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/3/30.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentUnreadCountAPI.h"
#import "Defination.h"

@implementation MomentUnreadCountAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_MOMENT_UNREAD_COUNT;
}

- (id)requestArgument {
    NSDictionary *dic = @{
                          @"res_code" : self.res_code,
                          };
    
    return dic;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
