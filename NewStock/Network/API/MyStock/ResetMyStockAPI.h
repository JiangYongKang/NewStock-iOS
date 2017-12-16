//
//  ResetMyStockAPI.h
//  NewStock
//
//  Created by Willey on 16/9/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface ResetMyStockAPI : APIRequest

- (id)initWithArray:(NSArray *)array;
- (void)setMyStockArray:(NSArray *)array;

@end
