//
//  CodeValidateAPI.m
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "CodeValidateAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation CodeValidateAPI


- (NSString *)requestUrl {
    return API_ACCOUNT_VALIDATE;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"ph":self.ph,
                          @"rty":self.rty,
                          @"vd":self.vd
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
