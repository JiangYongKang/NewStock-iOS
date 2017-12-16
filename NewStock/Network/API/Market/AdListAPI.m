//
//  AdListAPI.m
//  NewStock
//
//  Created by Willey on 16/8/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "AdListAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation AdListAPI
- (NSString *)requestUrl {
    
    NSDictionary *dic =  @{
                           @"res_code": @"P_FM0500",
                           @"pos": @"top",
                           @"page": @1,
                           @"count": @5
                           };
    
    NSString *str = [SystemUtil DataTOjsonString:dic];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    return [NSString stringWithFormat:@"%@?param=%@",API_AD_LIST, urlStr];
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

- (NSInteger)cacheTimeInSeconds {
    return 5;
}
@end
