//
//  StockApplyAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/5/2.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockApplyAPI.h"
#import "Defination.h"

@implementation StockApplyAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_STOCK_APPLY,self.st];
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
