//
//  TaoNoticeStartMessage.m
//  NewStock
//
//  Created by 王迪 on 2017/6/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoNoticeStartMessage.h"
#import "Defination.h"


@implementation TaoNoticeStartMessage

- (NSString *)requestUrl {
    return API_TAO_START_MESSAGE;
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
