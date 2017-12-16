//
//  MomentUnreadOperAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/3/30.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentUnreadOperAPI.h"
#import "Defination.h"

@implementation MomentUnreadOperAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_MOMENT_UNREAD_OPERATION;
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"id":self.ids,
                          @"st":self.st,
                          };
    
    return dic;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
