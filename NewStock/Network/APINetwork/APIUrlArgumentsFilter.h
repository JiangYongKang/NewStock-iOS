//
//  APIUrlArgumentsFilter.h
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APINetworkConfig.h"
#import "APIBaseRequest.h"

/// 给url追加arguments，用于全局参数，比如AppVersion, ApiVersion等
@interface APIUrlArgumentsFilter : NSObject <APIUrlFilterProtocol>

+ (APIUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(APIBaseRequest *)request;

@end
