//
//  ResetMyStockAPI.m
//  NewStock
//
//  Created by Willey on 16/9/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ResetMyStockAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"
#import "StockCodesModel.h"

@implementation ResetMyStockAPI
{
    NSMutableArray *_stockArray;
}

- (id)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _stockArray = [[NSMutableArray alloc] init];
        [_stockArray addObjectsFromArray:array];
    }
    return self;
}
- (void)setMyStockArray:(NSArray *)array
{
    [_stockArray removeAllObjects];
    [_stockArray addObjectsFromArray:array];
}

- (NSString *)requestUrl {
    return API_RESET_MY_STOCK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger i = _stockArray.count - 1; i >= 0; i --)
        {
            StockCodeInfo *model = [_stockArray objectAtIndex:i];
            NSDictionary *dic;
            dic = [[NSDictionary alloc] initWithObjectsAndKeys:model.t,@"t",
                   model.s,@"s",
                   model.m,@"m",
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
