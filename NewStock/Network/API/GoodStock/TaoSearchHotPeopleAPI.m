//
//  TaoSearchHotPeopleAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/3/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchHotPeopleAPI.h"
#import "Defination.h"

@implementation TaoSearchHotPeopleAPI

- (NSString *)requestUrl {
    return API_TAO_SEARCH_HOT_PPL;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"code":self.code.length ? self.code : @"",
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
