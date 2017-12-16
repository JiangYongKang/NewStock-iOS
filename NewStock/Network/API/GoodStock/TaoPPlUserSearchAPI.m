//
//  TaoPPlUserSearchAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/3/7.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoPPlUserSearchAPI.h"
#import "Defination.h"

@implementation TaoPPlUserSearchAPI


- (NSString *)requestUrl {
    return API_TAO_PPL_SEARCH_USER;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"n":self.n,
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
