//
//  RankListAPI.m
//  NewStock
//
//  Created by Willey on 16/7/29.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RankListAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation RankListAPI
{
    NSString *_rankName;
    NSString *_upDown;
    
}

- (id)initWithRankName:(NSString *)rankName
                upDown:(NSString *)upDown
                fromNo:(long)fromNo
                  toNo:(long)toNo
{
    self = [super init];
    if (self) {
        _rankName = rankName;
        _upDown = upDown;
        self.fromNo = fromNo;
        self.toNo = toNo;
        
        self.pageNum = toNo;
    }
    return self;
}

- (NSString *)requestUrl {
    return API_MARKET_RANK;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSArray *dic1 =@[
                     @{
                         @"symbolTyp": @3,
                         @"marketCd": @1
                         },
                     @{
                         @"symbolTyp": @3,
                         @"marketCd": @2
                         },
                     @{
                         @"symbolTyp": @5,
                         @"marketCd": @2
                         },
                     @{
                         @"symbolTyp": @6,
                         @"marketCd": @2
                         },
                     ];
    
    return @{
             @"rankName": _rankName,
             @"upDown": _upDown,
             @"fromNo": [NSString stringWithFormat:@"%ld",(long)self.fromNo],
             @"toNo":[NSString stringWithFormat:@"%ld",(long)self.toNo],
             @"typeList":dic1,
             @"todayFlg":@1,
             @"category":@10
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
