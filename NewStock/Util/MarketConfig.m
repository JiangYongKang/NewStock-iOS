//
//  MarketConfig.m
//  NewStock
//
//  Created by Willey on 16/7/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MarketConfig.h"
#import "SystemUtil.h"
#import "Defination.h"
#import "Reachability.h"


@implementation MarketConfig

+ (NSString *)getUrlWithPath:(NSString *)path Param:(NSDictionary *)param {
    NSString *str = [SystemUtil DataTOjsonString:param];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [NSString stringWithFormat:@"%@%@?param=%@",API_URL,path,str];
}

+ (NSString *)getUrlWithPath:(NSString *)path {
    if ([path hasPrefix:@"./"]) {
        NSString *str = [path stringByReplacingOccurrencesOfString:@"./" withString:API_URL];
        return str;
    } else if ([path hasPrefix:@"http:"]) {
        return path;
    } else {
        return path;
    }
    
}

+ (float)getRefreshTime {
    float marketRefreshTime = [[SystemUtil getCache:@"marketRefreshTime"] floatValue];

    if (marketRefreshTime>0) {
        return marketRefreshTime;
    } else {
        return DEFAULT_REFRESH_TIME;
    }
}

+ (void)setRefreshTime:(float)f {
    [SystemUtil putCache:@"marketRefreshTime" value:[NSString stringWithFormat:@"%f",f]];
}

+ (float)getAppRefreshTime {
    //判断是否wifi环境
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (status == ReachableViaWiFi) {
        return DEFAULT_WIFI_REFRESH_TIME;
    }else {
        return [MarketConfig getRefreshTime];
    }
}

@end
