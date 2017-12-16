//
//  AddMyStockAPI.m
//  NewStock
//
//  Created by Willey on 16/9/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "AddMyStockAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"

@implementation AddMyStockAPI

- (NSString *)requestUrl {
    return API_ADD_MY_STOCK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.t,@"t",self.s,@"s",self.m,@"m", nil];
    NSArray *arr = [NSArray arrayWithObject:dict];
    return  arr;
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
