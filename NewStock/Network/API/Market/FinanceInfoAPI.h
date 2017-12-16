//
//  FinanceInfoAPI.h
//  NewStock
//
//  Created by Willey on 16/7/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface FinanceInfoAPI : APIRequest

- (id)initWithSymbol:(NSString *)symbol
            marketCd:(NSString *)marketCd;

@end
