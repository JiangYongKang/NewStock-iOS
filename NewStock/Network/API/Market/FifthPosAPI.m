//
//  FifthPosAPI.m
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FifthPosAPI.h"
#import "Defination.h"

@implementation FifthPosAPI
{
    NSString *_symbolTyp;
    NSString *_symbol;
    NSString *_marketCd;
    NSString *_chartTyp;
}

- (id)initWithSymbolTyp:(NSString *)symbolTyp
                 symbol:(NSString *)symbol
               marketCd:(NSString *)marketCd
               chartTyp:(NSString *)chartTyp

{
    self = [super init];
    if (self) {
        _symbolTyp = symbolTyp;
        _symbol = symbol;
        _marketCd = marketCd;
        _chartTyp = chartTyp;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_STOCK_FIFTH_POSITION, _symbolTyp,_symbol,_marketCd];
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
