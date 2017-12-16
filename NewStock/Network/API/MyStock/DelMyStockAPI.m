//
//  DelMyStockAPI.m
//  NewStock
//
//  Created by Willey on 16/9/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "DelMyStockAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "MarketConfig.h"

@implementation DelMyStockAPI

- (NSString *)requestUrl {
    return API_DEL_MY_STOCK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    if (self.modelArray.count) {
        NSMutableArray *nmArr = [NSMutableArray array];
        
        for (StockCodeInfo *model in self.modelArray) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:model.t,@"t",model.s,@"s",model.m,@"m", nil];
            [nmArr addObject:dict];
        }
        
        return  nmArr.copy;
    }else {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.t,@"t",self.s,@"s",self.m,@"m", nil];
        NSArray *arr = [NSArray arrayWithObject:dict];
        return  arr;
    }
    
}


- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
