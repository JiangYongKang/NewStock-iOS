//
//  LunchAPPUpdateAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "LunchAPPUpdateAPI.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

@implementation LunchAPPUpdateAPI
//"{\"v\":" + "\"" + version + "\"" + "," + "\"md5\":" + "\"" + md5 + "\"" + "," + "\"os\":" + "\"android\"" + "}"
- (NSString *)requestUrl {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appid = APP_ID;
    NSString *os = @"iOS";
    NSDictionary *dict = @{
                       @"v":[NSString stringWithFormat:@"v%@",appVersion],
                       @"md5":appid
                       };
    NSString *str = [SystemUtil DataTOjsonString:dict];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@?param=%@",API_LUNCH_UPDATE_APP,urlStr];
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

- (id)jsonValidator {
    return nil;
}

- (NSInteger)cacheTimeInSeconds {
    return 5;
}

@end
