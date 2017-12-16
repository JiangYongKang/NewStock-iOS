//
//  TaoQLNGHistoryListAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGHistoryListAPI.h"
#import "Defination.h"

@implementation TaoQLNGHistoryListAPI


- (NSString *)requestUrl {
    return API_TAO_QLNG_LIST;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"id":self.ids,
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
