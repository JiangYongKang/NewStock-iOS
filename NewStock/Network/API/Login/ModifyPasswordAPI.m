//
//  ModifyPasswordAPI.m
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ModifyPasswordAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation ModifyPasswordAPI

- (NSString *)requestUrl {
    return API_ACCOUNT_UPDATE_PW;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(self.ph)[dic setObject:self.ph forKey:@"ph"];
    if(self.pwd)[dic setObject:self.pwd forKey:@"pwd"];
    if(self.vd)[dic setObject:self.vd forKey:@"vd"];
    
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
