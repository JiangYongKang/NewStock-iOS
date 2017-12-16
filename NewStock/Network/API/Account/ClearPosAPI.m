//
//  ClearPosAPI.m
//  NewStock
//
//  Created by Willey on 16/10/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ClearPosAPI.h"

#import "Defination.h"
#import "SystemUtil.h"

@implementation ClearPosAPI


- (NSString *)requestUrl {
//    NSDictionary *dic =  @{ @"id": self.userId };
//    
//    NSString *str = [SystemUtil DataTOjsonString:dic];
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    return [NSString stringWithFormat:@"%@?param=%@",API_CLEAR_POS, urlStr];
    
    return API_CLEAR_POS;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}


- (id)requestArgument {
    return nil;
}



@end
