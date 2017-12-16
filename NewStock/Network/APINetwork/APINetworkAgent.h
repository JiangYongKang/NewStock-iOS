//
//  APINetworkAgent.h
//


#import <Foundation/Foundation.h>
#import "APIBaseRequest.h"

@interface APINetworkAgent : NSObject

+ (APINetworkAgent *)sharedInstance;

- (void)addRequest:(APIBaseRequest *)request;

- (void)cancelRequest:(APIBaseRequest *)request;

- (void)cancelAllRequests;

/// 根据request和networkConfig构建url
- (NSString *)buildRequestUrl:(APIBaseRequest *)request;

@end
