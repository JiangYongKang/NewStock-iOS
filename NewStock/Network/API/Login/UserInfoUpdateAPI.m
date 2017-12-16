//
//  UserInfoUpdateAPI.m
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UserInfoUpdateAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation UserInfoUpdateAPI



- (NSString *)requestUrl {
    return API_ACCOUNT_UPDATE_USERINFO;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(self.uid)[dic setObject:self.uid forKey:@"uid"];
    if(self.n)[dic setObject:self.n forKey:@"n"];
    if(self.ph)[dic setObject:self.ph forKey:@"ph"];
    if(self.vd)[dic setObject:self.vd forKey:@"vd"];
    if(self.pwd)[dic setObject:self.pwd forKey:@"pwd"];
    if(self.npwd)[dic setObject:self.npwd forKey:@"npwd"];
    if(self.ico)[dic setObject:self.ico forKey:@"ico"];

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
