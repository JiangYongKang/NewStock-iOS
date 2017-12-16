//
//  IndexInfoAPI.h
//  NewStock
//
//  Created by Willey on 16/7/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"
#import "APIListRequest.h"

@interface IndexInfoAPI : APIListRequest//APIRequest

- (id)initWithSymbolTyp:(NSString *)symbolTyp
                 symbol:(NSString *)symbol
               marketCd:(NSString *)marketCd;
@end
