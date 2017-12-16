//
//  APIUrlArgumentsFilter.m
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIUrlArgumentsFilter.h"
#import "APINetworkPrivate.h"

@implementation APIUrlArgumentsFilter {
    NSDictionary *_arguments;
}

+ (APIUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(APIBaseRequest *)request {
    return [APINetworkPrivate urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}

@end
