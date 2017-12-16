//
//  RegisterAPI.m
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RegisterAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation RegisterAPI



- (NSString *)requestUrl {
    return API_ACCOUNT_REGISITER;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {

  NSDictionary *dic = @{
           @"ph":self.userName,
           @"vd":self.code,
           @"pwd":self.pwd
           };
    
    //NSString *str = [SystemUtil DataTOjsonString:dic];
    NSLog(@"%@",dic);
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
