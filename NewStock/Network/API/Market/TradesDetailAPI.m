//
//  TradesDetailAPI.m
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "TradesDetailAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation TradesDetailAPI
{
    NSString *_symbolTyp;
    NSString *_symbol;
    NSString *_marketCd;
}

- (id)initWithSymbolTyp:(NSString *)symbolTyp
                 symbol:(NSString *)symbol
               marketCd:(NSString *)marketCd {
    self = [super init];
    if (self) {
        _symbolTyp = symbolTyp;
        _symbol = symbol;
        _marketCd = marketCd;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_STOCK_TRADES, _symbolTyp,_symbol,_marketCd];
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    //return nil;
    
        NSDictionary *dic1 = @{@"fromNo":@1,
                            @"toNo":@20
                              };
    NSString *str = [SystemUtil DataTOjsonString:dic1];

    NSDictionary *dic = @{@"query":str};
    return dic;

}

- (id)jsonValidator {
    return nil;
}

@end
