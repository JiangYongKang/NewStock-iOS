//
//  UploadPositionAPI.m
//  NewStock
//
//  Created by Willey on 16/8/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UploadPositionAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation UploadPositionAPI


- (NSString *)requestUrl {
    return API_INPUT_POSITION;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"symbolTyp":self.symbolTyp,
                          @"marketCd":self.marketCd,
                          @"symbol":self.symbol,
                          @"qty":self.qty,//@100,//
                          @"inPrice":self.inPrice//@16.4,//
                          };
    
    return dic;
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
