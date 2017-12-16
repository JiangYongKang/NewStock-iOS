//
//  TaoSearchStockAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchStockAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"

@implementation TaoSearchStockAPI


- (NSString *)requestUrl {
    return API_TAO_SEARCH_STOCK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"d":self.d,
             @"s":self.s,
             @"t":self.t,
             @"m":self.m,
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
