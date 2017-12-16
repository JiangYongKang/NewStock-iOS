//
//  APIListRequest.m
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@implementation APIListRequest

- (void)loadFirstPage {
    self.fromNo = 1;
    self.toNo = self.pageNum;
    
    [self start];
}

- (void)loadNestPage {
    long curIndex = self.toNo+1;
    long toIndex = self.toNo+self.pageNum;
    self.fromNo = curIndex;
    self.toNo = toIndex;
    [self start];
}

- (void)loadLastPage {
    
}


@end
