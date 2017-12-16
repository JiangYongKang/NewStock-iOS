//
//  TaoSearchHotWordAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/2/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchHotWordAPI.h"

@implementation TaoSearchHotWordAPI

- (NSString *)requestUrl {
    return API_TAO_SEARCH_HOT;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"code":self.code,
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
