//
//  DeleteUserDynamic.m
//  NewStock
//
//  Created by 王迪 on 2017/1/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "DeleteUserDynamicAPI.h"
#import "Defination.h"
#import "SystemUtil.h"


@implementation DeleteUserDynamicAPI



- (instancetype)initWithid:(NSString *)ids {
    if (self = [super init]) {
        self.ids = ids;
    }
    return self;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_ACCOUNT_DELETE_DYNAMIC;
}

- (id)requestArgument {
    NSDictionary *dict = @{
                           @"id":self.ids,
                           };
    return dict;
}

@end
