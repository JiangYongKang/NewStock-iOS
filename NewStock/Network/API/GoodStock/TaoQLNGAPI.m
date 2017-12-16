//
//  TaoQLNGAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGAPI.h"
#import "Defination.h"

@implementation TaoQLNGAPI

- (NSString *)requestUrl {
    return API_TAO_QLNG;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"id":self.ids
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
