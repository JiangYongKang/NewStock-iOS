//
//  MyStockInfoAPI.h
//  NewStock
//
//  Created by Willey on 16/8/15.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface MyStockInfoAPI : APIRequest

- (id)initWithArray:(NSArray *)array;
- (void)setMyStockArray:(NSArray *)array;
@end
