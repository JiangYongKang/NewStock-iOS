//
//  MessageAPI.m
//  NewStock
//
//  Created by Willey on 16/10/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MessageAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation MessageAPI

- (NSString *)requestUrl {
    
    NSDictionary *param = @{@"id":@"",@"rl":@"gt",@"page":@1,@"count":@100};
    
    NSString *str = [SystemUtil DataTOjsonString:param];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *url = [NSString stringWithFormat:@"%@?param=%@",API_MAIN_MESSAGE,str];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return urlStr;
    

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
