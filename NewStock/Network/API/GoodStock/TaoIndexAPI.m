//
//  TaoIndexAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoIndexAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"

@implementation TaoIndexAPI

- (NSString *)requestUrl {
    return API_TAO_INDEX;
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
