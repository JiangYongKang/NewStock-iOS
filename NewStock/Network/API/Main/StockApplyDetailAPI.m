//
//  StockApplyDetailAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/29.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockApplyDetailAPI.h"
#import "Defination.h"

@implementation StockApplyDetailAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_STOCK_APPLY_DETAIL,self.s];
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
