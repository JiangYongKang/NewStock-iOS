//
//  RecommendListAPI.m
//  NewStock
//
//  Created by 王迪 on 2016/12/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RecommendListAPI.h"
#import "Defination.h"


@implementation RecommendListAPI


- (instancetype)initWithCount:(NSString *)count res_code:(NSString *)res_code page:(NSString *)page {
    if (self = [super init]) {
        self.count = count;
        self.res_code = res_code;
        self.page = page;
    }
    return self;
}

- (NSString *)requestUrl {
    return API_RECOMMENDED_LIST;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    NSDictionary *dic;
    if (self.flag.length) {
        dic = @{
                @"count":self.count,
                @"res_code":self.res_code,
                @"page":self.page,
                @"flag":self.flag,
                };
    }else {
        dic = @{
                @"count":self.count,
                @"res_code":self.res_code,
                @"page":self.page,
                };
    }
    
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
