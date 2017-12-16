//
//  TaoSearchDepartmentAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchDepartmentAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"


@implementation TaoSearchDepartmentAPI

- (NSString *)requestUrl {
    return API_TAO_SEARCH_DEPARTMENT;
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
             @"sd":self.sd,
             @"ed":self.ed,
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
