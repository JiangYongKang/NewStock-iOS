//
//  UnReadAPI.m
//  NewStock
//
//  Created by Willey on 16/10/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UnReadAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation UnReadAPI

- (NSString *)requestUrl {
    
    NSDictionary *param = @{@"id":self.mId,@"rl":@"gt"};
    
    NSString *str = [SystemUtil DataTOjsonString:param];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *url = [NSString stringWithFormat:@"%@?param=%@",API_MAIN_MESSAGE_UNREAD,str];
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
