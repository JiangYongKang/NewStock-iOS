//
//  ThemeTimeLineAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/5/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ThemeTimeLineAPI.h"
#import "Defination.h"

@implementation ThemeTimeLineAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_THEME_TIMELINE;
}

- (id)requestArgument {
    return @{
             @"page":self.page,
             @"count":self.count,
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
