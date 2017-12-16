//
//  TaoDateList.m
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoDateList.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"

@implementation TaoDateList

- (NSString *)requestUrl {
    return API_TAO_DATE_LIST;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    if (self.code.length) {
        return @{
                 @"code":self.code,
                 @"count":self.count,
                 };
    } else {
    
        return @{
                 @"t":self.t,
                 @"s":self.s,
                 @"m":self.m,
                 @"count":self.count,
                 };
    }

}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
