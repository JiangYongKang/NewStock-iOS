//
//  SymbolnewsAPI.m
//  NewStock
//
//  Created by Willey on 16/8/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "SymbolnewsAPI.h"
#import "Defination.h"

@implementation SymbolnewsAPI
{
    NSString *_symbol;
    NSString *_symbolTyp;
    NSString *_marketCd;
    NSString *_newsType;
    NSString *_fromNo;
    NSString *_toNo;
}

- (id)initWithSymbol:(NSString *)symbol
           symbolTyp:(NSString *)symbolTyp
            marketCd:(NSString *)marketCd
            newsType:(NSString *)newsType
              fromNo:(NSString *)fromNo
                toNo:(NSString *)toNo
{
    self = [super init];
    if (self) {
        _symbol = symbol;
        _symbolTyp = symbolTyp;
        _marketCd = marketCd;
        _newsType = newsType;
        _toNo = toNo;
        _fromNo = fromNo;
    }
    return self;
}

- (NSString *)requestUrl {
    return API_SYMBOL_NEWS_INFO;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"symbol": _symbol,
             @"symbolTyp": _symbolTyp,
             @"marketCd": _marketCd,
             @"newsType": _newsType,
             @"fromNo":_fromNo,
             @"toNo":_toNo,
             };
}

- (id)jsonValidator {
    return nil;
}

@end
