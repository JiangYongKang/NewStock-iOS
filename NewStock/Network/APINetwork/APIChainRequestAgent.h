//
//  APIChainRequestAgent.h
//


#import <Foundation/Foundation.h>
#import "APIChainRequest.h"

/// ChainRequestAgent is used for caching & keeping current request.
@interface APIChainRequestAgent : NSObject

+ (APIChainRequestAgent *)sharedInstance;

- (void)addChainRequest:(APIChainRequest *)request;

- (void)removeChainRequest:(APIChainRequest *)request;

@end
