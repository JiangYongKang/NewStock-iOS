//
//  GetVerificationCodeAPI.m
//  NewStock
//
//  Created by Willey on 16/8/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "GetVerificationCodeAPI.h"
#import "Defination.h"
#import "SystemUtil.h"


@implementation GetVerificationCodeAPI

- (NSString *)requestUrl {
    return API_ACCOUNT_SEND_MSG;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    NSString *rty;
    
    switch (self.type) {
        case VERIFICATION_CODE_LOGIN: {
            rty = @"login";
            break;
        }
        case VERIFICATION_CODE_REGISTER: {
            rty = @"register";
            break;
        }
        case VERIFICATION_CODE_RETPWD: {
            rty = @"retpwd";
            break;
        }
        case VERIFICATION_CODE_UPDPH: {
            rty = @"updph";
            break;
        }
        case VERIFICATION_CODE_BIND: {
            rty = @"bind";
            break;
        }
    }
    return @{
             @"ph": _userName,
             @"rty": rty
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
