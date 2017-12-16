//
//  GetDefaultIcon.m
//  NewStock
//
//  Created by 王迪 on 2016/12/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "GetDefaultIconAPI.h"
#import "Defination.h"


@implementation GetDefaultIcon

- (APIRequestMethod)requestMethod {
    return APIRequestMethodGet;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_ACCOUNT_GET_DEFAULT_USERICON;
}

- (id)requestArgument {
    return nil;
}


@end
