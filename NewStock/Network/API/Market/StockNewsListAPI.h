//
//  StockNewsListAPI.h
//  NewStock
//
//  Created by Willey on 16/8/15.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface StockNewsListAPI : APIRequest

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger totalNum;

- (id)initWithArray:(NSArray *)array;
- (void)setMyStockArray:(NSArray *)array;

- (void)loadNestPage;

@end
