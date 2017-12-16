//
//  IdleFundAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "IdleFundAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"


@implementation IdleFundAPI


- (NSString *)requestUrl {
    return API_IDLEFUND_STOCK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"page" : self.page,
             @"count" : self.count,
             @"code" : self.code,
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
