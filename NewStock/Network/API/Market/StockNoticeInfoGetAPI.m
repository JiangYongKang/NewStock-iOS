//
//  StockNoticeInfoGetAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/28.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockNoticeInfoGetAPI.h"
#import "Defination.h"


@implementation StockNoticeInfoGetAPI


- (NSString *)requestUrl {
    return API_USER_ALER;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"s":self.s,
             @"t":self.t,
             @"m":self.m,
             };
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
