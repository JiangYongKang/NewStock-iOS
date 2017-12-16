//
//  KLineInfoAPI.m
//  NewStock
//
//  Created by Willey on 16/7/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "KLineInfoAPI.h"
#import "Defination.h"

@implementation KLineInfoAPI
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

- (void)setChartTyp:(NSString *)chartTyp
{
    _chartTyp = chartTyp;
}

- (NSString *)requestUrl {
    //return API_KLINE_INFO;
    NSLog(@"%@",[NSString stringWithFormat:API_KLINE_INFO, _symbolTyp,_symbol,_marketCd,_chartTyp]);
    return [NSString stringWithFormat:API_KLINE_INFO, _symbolTyp,_symbol,_marketCd,_chartTyp];
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
