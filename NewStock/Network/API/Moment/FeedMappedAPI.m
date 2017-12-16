//
//  FeedMappedAPI.m
//  NewStock
//
//  Created by Willey on 16/9/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FeedMappedAPI.h"
#import "Defination.h"

@implementation FeedMappedAPI


- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_FEED_MAPPED;
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"res_code":self.res_code,
                          @"sid":self.sid,
                          @"tt":self.tt
                          };
    
    return dic;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
