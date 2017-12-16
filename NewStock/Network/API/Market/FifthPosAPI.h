//
//  FifthPosAPI.h
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface FifthPosAPI : APIRequest
- (id)initWithSymbolTyp:(NSString *)symbolTyp
                 symbol:(NSString *)symbol
               marketCd:(NSString *)marketCd
               chartTyp:(NSString *)chartTyp;
@end
