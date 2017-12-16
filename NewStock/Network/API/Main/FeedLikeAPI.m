//
//  FeedLikeAPI.m
//  NewStock
//
//  Created by Willey on 16/12/1.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FeedLikeAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation FeedLikeAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_FEED_LIKE;
}

- (id)requestArgument {
    
    NSDictionary *dic = @{@"id":self.fId,@"opty":@"Y"};

    return  dic;
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

//- (NSString *)requestUrl {
//    
//    NSDictionary *param = @{@"id":self.fId,@"opty":@"Y"};
//    
//    NSString *str = [SystemUtil DataTOjsonString:param];
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    NSString *url = [NSString stringWithFormat:@"%@?param=%@",API_FEED_LIKE,str];
//    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    return urlStr;
//    
//    
//}

@end
