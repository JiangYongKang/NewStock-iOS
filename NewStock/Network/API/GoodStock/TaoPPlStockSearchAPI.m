//
//  TaoPPlStockSearchAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/3/7.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoPPlStockSearchAPI.h"
#import "Defination.h"

@implementation TaoPPlStockSearchAPI

- (NSString *)requestUrl {
    return API_TAO_PPL_SEARCH_STOCK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"t":self.t,
             @"s":self.s,
             @"m":self.m,
             @"count":self.count,
             @"sd":self.sd,
             @"ed":self.ed,
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
