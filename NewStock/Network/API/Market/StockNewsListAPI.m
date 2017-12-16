//
//  StockNewsListAPI.m
//  NewStock
//
//  Created by Willey on 16/8/15.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockNewsListAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "StockCodesModel.h"
#import "MarketConfig.h"

@implementation StockNewsListAPI
{
    NSMutableArray *_myStockArray;
}

- (id)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _myStockArray = [[NSMutableArray alloc] init];
        [_myStockArray addObjectsFromArray:array];
        
        self.pageIndex = 1;
        self.pageNum = PAGE_COUNT;
    }
    return self;
}

- (void)setMyStockArray:(NSArray *)array
{
    [_myStockArray removeAllObjects];
    [_myStockArray addObjectsFromArray:array];
    
}

- (void)loadNestPage
{
    self.pageIndex += 1;
    [self start];
}

- (NSString *)requestUrl {
    
    return API_STOCK_NEWS_LIST;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_myStockArray count]; i++)
    {
        StockCodeInfo *model = [_myStockArray objectAtIndex:i];
        NSDictionary *dic;
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:model.t,@"t",
               model.s,@"s",
               model.m,@"m",
               nil];
        [array addObject:dic];
    }
    
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%ld",(long)self.pageIndex],
                          @"count":[NSString stringWithFormat:@"%ld",(long)self.pageNum],
                          @"list":array};
    //NSString *str = [SystemUtil DataTOjsonString:array];

    
//    NSString *str1 = [SystemUtil DataTOjsonString:dic];
//    NSDictionary *dic1 = @{@"param":str1};
    return  dic;
    
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
