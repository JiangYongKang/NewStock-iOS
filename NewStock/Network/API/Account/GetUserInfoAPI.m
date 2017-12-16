//
//  GetUserInfoAPI.m
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "GetUserInfoAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation GetUserInfoAPI


- (NSString *)requestUrl {
    NSDictionary *dic =  @{ @"id": self.userId };
    
    NSString *str = [SystemUtil DataTOjsonString:dic];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [NSString stringWithFormat:@"%@?param=%@",API_ACCOUNT_GET_USERINFO, urlStr];
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}


- (id)requestArgument {
    return nil;
}


//- (NSInteger)cacheTimeInSeconds {
//
//    return 10;
//}

@end
