//
//  StockAnnounceListAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockAnnounceListAPI.h"
#import "Defination.h"
#import "SystemUtil.h"
#import "StockCodesModel.h"

@implementation StockAnnounceListAPI

- (NSString *)requestUrl {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.myStockArray.count; i ++) {
        StockCodeInfo *model = [_myStockArray objectAtIndex:i];
        NSDictionary *dic;
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:model.t,@"t",
               model.s,@"s",
               model.m,@"m",
               nil];
        [array addObject:dic];
    }
    
//    NSString *str = [SystemUtil DataTOjsonString:array];
//    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    NSDictionary *dic = @{@"page":self.page,
                          @"count":self.count,
                          @"list":array};
    NSString *str1 = [SystemUtil DataTOjsonString:dic];
    str1 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    str1 = [str1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    NSString *url = [NSString stringWithFormat:@"%@?param=%@",API_STOCK_ANNOUNCE_LIST,str1];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    url = [url stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return url;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}


@end
