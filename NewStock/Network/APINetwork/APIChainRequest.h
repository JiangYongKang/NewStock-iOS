//
//  APIChainRequest.h
//


#import <Foundation/Foundation.h>
#import "APIBaseRequest.h"

@class APIChainRequest;
@protocol APIChainRequestDelegate <NSObject>

@optional

- (void)chainRequestFinished:(APIChainRequest *)chainRequest;

- (void)chainRequestFailed:(APIChainRequest *)chainRequest failedBaseRequest:(APIBaseRequest*)request;

@end

typedef void (^ChainCallback)(APIChainRequest *chainRequest, APIBaseRequest *baseRequest);

@interface APIChainRequest : NSObject

@property (weak, nonatomic) id<APIChainRequestDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *requestAccessories;

/// start chain request
- (void)start;

/// stop chain request
- (void)stop;

- (void)addRequest:(APIBaseRequest *)request callback:(ChainCallback)callback;

- (NSArray *)requestArray;

/// Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<APIRequestAccessory>)accessory;

@end
