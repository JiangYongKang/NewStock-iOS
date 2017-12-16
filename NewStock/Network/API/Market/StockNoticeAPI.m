//
//  StockNoticeAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/20.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockNoticeAPI.h"
#import "Defination.h"

@implementation StockNoticeAPI

- (NSString *)requestUrl {
    return API_USER_ALERTED;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"s":self.s,
             @"t":self.t,
             @"m":self.m,
             @"in":self.ins,
             @"out":self.outs,
             @"zdf":self.zdf,
             @"st":self.st,
             };
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}



@end
