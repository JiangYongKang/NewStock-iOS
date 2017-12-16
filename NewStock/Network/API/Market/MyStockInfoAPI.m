//
//  MyStockInfoAPI.m
//  NewStock
//
//  Created by Willey on 16/8/15.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MyStockInfoAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "StockCodesModel.h"

@implementation MyStockInfoAPI
{
    NSMutableArray *_myStockArray;
}

- (id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        _myStockArray = [[NSMutableArray alloc] init];
        [_myStockArray addObjectsFromArray:array];
    }
    return self;
}

- (void)setMyStockArray:(NSArray *)array {
    [_myStockArray removeAllObjects];
    [_myStockArray addObjectsFromArray:array];
}

- (NSString *)requestUrl {
    return API_INDEX_INFO;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_myStockArray count]; i ++) {
        StockCodeInfo *model = [_myStockArray objectAtIndex:i];
        NSDictionary *dic;
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:model.t,@"symbolTyp",
               model.s,@"symbol",
               model.m,@"marketCd",
               nil];
        [array addObject:dic];
    }
    
    return  array;
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
