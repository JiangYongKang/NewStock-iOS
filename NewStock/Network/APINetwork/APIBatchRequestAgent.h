//
//  APIBatchRequestAgent.h
//


#import <Foundation/Foundation.h>
#import "APIBatchRequest.h"

@interface APIBatchRequestAgent : NSObject

+ (APIBatchRequestAgent *)sharedInstance;

- (void)addBatchRequest:(APIBatchRequest *)request;

- (void)removeBatchRequest:(APIBatchRequest *)request;

@end
