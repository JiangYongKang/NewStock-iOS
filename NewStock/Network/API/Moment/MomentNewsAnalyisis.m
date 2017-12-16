//
//  MomentNewsAnalyisis.m
//  NewStock
//
//  Created by 王迪 on 2017/5/25.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentNewsAnalyisis.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation MomentNewsAnalyisis

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    
    NSDictionary *dic = @{
                          @"page":self.page,
                          @"count":self.count,
                          @"flag":@"0",
                          };
    
    NSString *s = [SystemUtil DataTOjsonString:dic];
    s = [s stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *u = [NSString stringWithFormat:@"%@?param=%@",API_MOMENT_NEWS_ANALYIST,s];
    NSString *url = [u stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}

- (id)requestArgument {
    return nil;
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type" : @"application/json;charset=UTF-8"};
}

@end
