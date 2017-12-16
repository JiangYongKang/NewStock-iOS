//
//  TipOffAPI.m
//  NewStock
//
//  Created by Willey on 16/9/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "TipOffAPI.h"
#import "Defination.h"

@implementation TipOffAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_SPAM_REPORT;
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"uid":self.uid,
                          @"id":self.contentId,
                          @"ty":self.ty,
                          @"cty":self.cty,
                          };
    
    return dic;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
