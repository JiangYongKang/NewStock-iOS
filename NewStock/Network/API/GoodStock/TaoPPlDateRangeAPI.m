//
//  TaoPPlDateRangeAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/3/7.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoPPlDateRangeAPI.h"
#import "Defination.h"

@implementation TaoPPlDateRangeAPI

- (NSString *)requestUrl {
    return API_TAO_PPL_RANGE;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    if (self.n.length) {
        return @{
                 @"n":self.n,
                 @"count":self.count,
                 };
    }
    return @{
             @"t":self.t,
             @"s":self.s,
             @"m":self.m,
             @"count":self.count,
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}



@end
