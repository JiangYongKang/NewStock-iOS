//
//  StockCodesAPI.m
//  NewStock
//
//  Created by Willey on 16/8/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockCodesAPI.h"
#import "Defination.h"

@implementation StockCodesAPI
{
    NSString *_lastModified;
}

- (id)initWithLastModified:(NSString *)lastModified
{
    self = [super init];
    if (self) {
        _lastModified = lastModified;
    }
    return self;
}

- (NSInteger)cacheTimeInSeconds {
    return -1;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_STOCK_CODES_INFO,_lastModified];
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

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    
    return @{@"gzip": @"Accept-Encoding"};

}


@end
