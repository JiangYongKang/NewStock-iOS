//
//  GetMyScoreAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/4/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "GetMyScoreAPI.h"
#import "Defination.h"

@implementation GetMyScoreAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_GET_MY_SCORE;
}

- (id)requestArgument {
    return nil;
}

@end
