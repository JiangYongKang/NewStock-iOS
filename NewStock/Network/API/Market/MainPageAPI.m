//
//  MainPageAPI.m
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MainPageAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation MainPageAPI

- (NSString *)requestUrl {
    return API_MAIN_PAGE;
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

- (NSInteger)cacheTimeInSeconds {
    return 5;
}
@end
