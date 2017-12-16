//
//  BoardListAPI.m
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BoardListAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation BoardListAPI
{
    NSString *_category;
}

- (id)initWithCategory:(NSString *)category
                upDown:(NSString *)upDown
                fromNo:(long )fromNo
                  toNo:(long )toNo
{
    self = [super init];
    if (self) {
        _category = category;
        
        self.fromNo = fromNo;
        self.toNo = toNo;
        
        self.pageNum = toNo;
    }
    return self;
}

- (NSString *)requestUrl {
    return API_BOARD_LIST_RANK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    NSArray *array =@[
                      @{
                          @"symbolTyp": @88,
                          @"marketCd": @88
                          }
                      ];
    return @{
             @"rankName": @"01",
             @"upDown": @"0",
             @"fromNo": [NSString stringWithFormat:@"%ld",(long)self.fromNo],
             @"toNo":[NSString stringWithFormat:@"%ld",(long)self.toNo],
             @"typeList":array,
             @"todayFlg":@1,
             @"category":_category
             };
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {    
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
