//
//  SymbolnewsAPI.h
//  NewStock
//
//  Created by Willey on 16/8/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface SymbolnewsAPI : APIRequest

- (id)initWithSymbol:(NSString *)symbol
           symbolTyp:(NSString *)symbolTyp
            marketCd:(NSString *)marketCd
            newsType:(NSString *)newsType
              fromNo:(NSString *)fromNo
                toNo:(NSString *)toNo;
@end
