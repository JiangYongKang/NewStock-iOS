//
//  IdleFundClassifyAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "IdleFundClassifyAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"


@implementation IdleFundClassifyAPI


- (NSString *)requestUrl {
    return API_IDLEFUND_CLASSIFY;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{@"pcode" : self.pcode};
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
