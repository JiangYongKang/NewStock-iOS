//
//  BoardDetailsAPI.m
//  NewStock
//
//  Created by Willey on 16/8/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BoardDetailsAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation BoardDetailsAPI
{
    NSString *_sectorSymbolTyp;
    NSString *_sectorSymbol;
    NSString *_sectorMarketCd;
    NSString *_fromNo;
    NSString *_toNo;
    NSString *_sortTermKbn;
    NSString *_sortOrderKbn;
}

- (id)initWithSectorSymbolTyp:(NSString *)sectorSymbolTyp
                 sectorSymbol:(NSString *)sectorSymbol
               sectorMarketCd:(NSString *)sectorMarketCd
                       fromNo:(long )fromNo
                         toNo:(long )toNo
                  sortTermKbn:(NSString *)sortTermKbn
                 sortOrderKbn:(NSString *)sortOrderKbn
{
    self = [super init];
    if (self) {
        _sectorSymbolTyp = sectorSymbolTyp;
        _sectorSymbol = sectorSymbol;
        _sectorMarketCd = sectorMarketCd;
        self.fromNo = fromNo;
        self.toNo = toNo;
        
        self.pageNum = toNo;
        
        _sortTermKbn = sortTermKbn;
        _sortOrderKbn = sortOrderKbn;
    }
    return self;
}

- (NSString *)requestUrl {
    return API_BOARD_DETAIL_RANK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    
    
    return @{
             @"sectorSymbolTyp": _sectorSymbolTyp,
             @"sectorSymbol": _sectorSymbol,
             @"sectorMarketCd": _sectorMarketCd,
             @"fromNo": [NSString stringWithFormat:@"%ld",(long)self.fromNo],
             @"toNo":[NSString stringWithFormat:@"%ld",(long)self.toNo],
             @"sortTermKbn":_sortTermKbn,
             @"sortOrderKbn":_sortOrderKbn
             };
    return nil;
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}
@end
