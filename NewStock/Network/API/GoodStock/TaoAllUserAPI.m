//
//  TaoAllUserAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/3/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoAllUserAPI.h"
#import "Defination.h"


@implementation TaoAllUserAPI {
    NSString *_lastModified;
}

- (id)initWithLastModified:(NSString *)lastModified {
    self = [super init];
    if (self) {
        _lastModified = lastModified;
    }
    return self;
}

- (NSInteger)cacheTimeInSeconds {
    return -1;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:API_TAO_PPL_ALL,_lastModified];
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
