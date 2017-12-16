//
//  DrawLotsAPI.m
//  NewStock
//
//  Created by Willey on 16/11/14.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "DrawLotsAPI.h"
#import "Defination.h"

@implementation DrawLotsAPI


- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_DRAW_LOTS;
}

- (id)requestArgument {
    return nil;
}

//添加公共的请求头
//- (NSDictionary *)requestHeaderFieldValueDictionary {
//    return @{@"Content-Type": @"application/json;charset=UTF-8"};
//}


@end
