//
//  MainTalkNewsAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/4/21.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainTalkNewsAPI.h"
#import "Defination.h"

@implementation MainTalkNewsAPI

- (NSString *)requestUrl {
    return API_TALK_NEWS;
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

- (id)jsonValidator {
    return nil;
}


@end
