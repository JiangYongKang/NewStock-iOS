//
//  APIListRequest.h
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface APIListRequest : APIRequest

@property (nonatomic, assign) NSInteger fromNo;
@property (nonatomic, assign) NSInteger toNo;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger totalNum;

- (void)loadFirstPage;
- (void)loadNestPage;
- (void)loadLastPage;
@end
