//
//  IndexInfoAPI.m
//  NewStock
//
//  Created by Willey on 16/7/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "IndexInfoAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation IndexInfoAPI
{
    NSString *_symbolTyp;
    NSString *_symbol;
    NSString *_marketCd;
}

- (id)initWithSymbolTyp:(NSString *)symbolTyp
                 symbol:(NSString *)symbol
               marketCd:(NSString *)marketCd

{
    self = [super init];
    if (self) {
        _symbolTyp = symbolTyp;
        _symbol = symbol;
        _marketCd = marketCd;
    }
    return self;
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
    
    //return nil;
    
   // NSDictionary *dic = @{@"query":@"[{\"symbolTyp\":1,\"symbol\":\"000001\",\"marketCd\":1},{\"symbolTyp\":1,\"symbol\":\"399001\",\"marketCd\":2}]"};
    
//    NSDictionary *dic = @{@"query":
//                              @[
//                                  @{
//                                      @"symbolTyp": @1,
//                                      @"symbol": @"000001",
//                                      @"marketCd": @1
//                                      },
//                                  @{
//                                      @"symbolTyp": @1,
//                                      @"symbol": @"399001",
//                                      @"marketCd": @2
//                                      }
//                                  ]
//                          };
    
    NSArray *dic1 =@[
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"000001",//上证
                                                                @"marketCd": @1
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"399001",//深证
                                                                @"marketCd": @2
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"399006",//创业板指
                                                                @"marketCd": @2
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"000300",//沪深300
                                                                @"marketCd": @1
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"000016",//上证50
                                                                @"marketCd": @1
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"000905",//中证500
                                                                @"marketCd": @1
                                                                },
                                                    
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"HSI",//恒生
                                                                @"marketCd": @5
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"IXIC",//纳斯达克
                                                                @"marketCd": @7
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"DJI",//道琼斯
                                                                @"marketCd": @6
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"SPX500",//标普500
                                                                @"marketCd": @6
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"N225",//日经225
                                                                @"marketCd": @9
                                                                },
                                                            @{
                                                                @"symbolTyp": @1,
                                                                @"symbol": @"FTSE100",//富时100
                                                                @"marketCd": @8
                                                                }
                                                            ]
                                                    ;
    //NSString *str = [SystemUtil DataTOjsonString:dic1];
    //NSDictionary *dic = @{@"query":str};
    //    NSError *error;
    //    NSString *jsonString = nil;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                         error:&error];
    //    if (! jsonData) {
    //        NSLog(@"Got an error: %@", error);
    //    } else {
    //        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    }

    
//    NSDictionary *dic =  @{@"query":
//                 @[
//                     @{
//                         @"symbolTyp": @"1",
//                         @"symbol": @"000001",
//                         @"marketCd": @"1"
//                         },
//                     @{
//                         @"symbolTyp": @"1",
//                         @"symbol": @"399001",
//                         @"marketCd": @"2"
//                         }
//                     ]
//             };
    //return  dic;
    return dic1;
}


- (id)jsonValidator {
    return nil;
}


- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}
@end
