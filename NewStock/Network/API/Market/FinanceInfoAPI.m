//
//  FinanceInfoAPI.m
//  NewStock
//
//  Created by Willey on 16/7/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FinanceInfoAPI.h"
#import "Defination.h"

@implementation FinanceInfoAPI
{
    NSString *_symbol;
    NSString *_marketCd;
}

- (id)initWithSymbol:(NSString *)symbol
            marketCd:(NSString *)marketCd
{
    self = [super init];
    if (self) {
        _symbol = symbol;
        _marketCd = marketCd;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_FINANCE_INFO,_symbol,_marketCd];
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

@end
