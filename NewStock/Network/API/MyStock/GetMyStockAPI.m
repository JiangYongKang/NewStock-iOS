//
//  GetMyStockAPI.m
//  NewStock
//
//  Created by Willey on 16/9/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "GetMyStockAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"

@implementation GetMyStockAPI

- (NSString *)requestUrl {
    return API_MY_STOCK_ALL;
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
