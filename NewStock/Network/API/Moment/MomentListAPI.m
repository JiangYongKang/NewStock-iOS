//
//  MomentListAPI.m
//  NewStock
//
//  Created by 王迪 on 2016/12/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MomentListAPI.h"
#import "Defination.h"

@implementation MomentListAPI

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
    return API_FEED_LIST;
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
                          @"order":self.order
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
