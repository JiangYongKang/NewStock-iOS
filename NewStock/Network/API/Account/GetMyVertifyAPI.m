//
//  GetMyVertifyAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/4/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "GetMyVertifyAPI.h"
#import "Defination.h"

@implementation GetMyVertifyAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_USER_VERTIFY_MY;
}

- (id)requestArgument {
    return nil;
}

@end
