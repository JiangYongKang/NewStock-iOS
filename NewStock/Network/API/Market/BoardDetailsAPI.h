//
//  BoardDetailsAPI.h
//  NewStock
//
//  Created by Willey on 16/8/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"
#import "APIListRequest.h"

@interface BoardDetailsAPI : APIListRequest
- (id)initWithSectorSymbolTyp:(NSString *)sectorSymbolTyp
                 sectorSymbol:(NSString *)sectorSymbol
               sectorMarketCd:(NSString *)sectorMarketCd
                       fromNo:(long )fromNo
                         toNo:(long )toNo
                  sortTermKbn:(NSString *)sortTermKbn
                 sortOrderKbn:(NSString *)sortOrderKbn;
@end
