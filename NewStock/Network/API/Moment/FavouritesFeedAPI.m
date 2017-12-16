//
//  FavouritesFeedAPI.m
//  NewStock
//
//  Created by Willey on 16/9/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FavouritesFeedAPI.h"
#import "Defination.h"

@implementation FavouritesFeedAPI


- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_FAVOURITES_FEED;
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          
                          @"id":self.fid,
                          @"opty":self.opty
                          };
    
    return dic;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}
@end
