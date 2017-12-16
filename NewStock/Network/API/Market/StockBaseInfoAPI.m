//
//  StockBaseInfoAPI.m
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockBaseInfoAPI.h"
#import "Defination.h"

@implementation StockBaseInfoAPI
{
    NSString *_symbolTyp;
    NSString *_symbol;
    NSString *_marketCd;
}

- (id)initWithSymbolTyp:(NSString *)symbolTyp
                 symbol:(NSString *)symbol
               marketCd:(NSString *)marketCd
{
    self = [super init];
    if (self) {
        _symbolTyp = symbolTyp;
        _symbol = symbol;
        _marketCd = marketCd;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_STOCK_BASE_INFO, _symbolTyp,_symbol,_marketCd];
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
