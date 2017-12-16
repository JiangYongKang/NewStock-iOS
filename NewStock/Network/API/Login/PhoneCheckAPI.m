//
//  PhoneCheckAPI.m
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PhoneCheckAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation PhoneCheckAPI


- (NSString *)requestUrl {
    return API_PHONE_CHECK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"suid":self.suid,
                          @"sr":self.sr
                          };
    
    return dic;
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
