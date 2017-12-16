//
//  FeedChildListAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/5/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "FeedChildListAPI.h"
#import "Defination.h"

@implementation FeedChildListAPI

- (instancetype)initWithCount:(NSString *)count res_code:(NSString *)res_code page:(NSString *)page order:(NSString *)order fromNum:(long)fromNum toNum:(long)toNum {
    if (self = [super init]) {
        self.count = count;
        self.res_code = res_code;
        self.page = page;
        self.order = order;
        self.fromNo = fromNum;
        self.toNo = toNum;
        self.pageNum = toNum;
    }
    return self;
}

- (NSString *)requestUrl {
    return API_FEED_CHILD_LIST;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    NSDictionary *dic = @{
                          @"count":self.count,
                          @"res_code":self.res_code,
                          @"page":self.page,
                          @"order":self.order,
                          @"pid":self.pid,
                          };
    return dic;
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
