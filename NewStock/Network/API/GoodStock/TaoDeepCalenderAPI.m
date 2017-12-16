//
//  TaoDeepCalenderAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoDeepCalenderAPI.h"
#import "Defination.h"

@implementation TaoDeepCalenderAPI

- (NSString *)requestUrl {
    return API_TAO_DEEPTIGER_CALENDER_LIST;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return nil;
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
