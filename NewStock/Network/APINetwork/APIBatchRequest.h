//
//  APIBatchRequest.h
//


#import <Foundation/Foundation.h>
#import "APIRequest.h"

@class APIBatchRequest;
@protocol APIBatchRequestDelegate <NSObject>

@optional

- (void)batchRequestFinished:(APIBatchRequest *)batchRequest;

- (void)batchRequestFailed:(APIBatchRequest *)batchRequest;

@end

@interface APIBatchRequest : NSObject

@property (strong, nonatomic, readonly) NSArray *requestArray;

@property (weak, nonatomic) id<APIBatchRequestDelegate> delegate;

@property (nonatomic, copy) void (^successCompletionBlock)(APIBatchRequest *);

@property (nonatomic, copy) void (^failureCompletionBlock)(APIBatchRequest *);

@property (nonatomic) NSInteger tag;

@property (nonatomic, strong) NSMutableArray *requestAccessories;

@property (nonatomic, strong, readonly) APIRequest *failedRequest;

- (id)initWithRequestArray:(NSArray *)requestArray;

- (void)start;

- (void)stop;

/// block回调
- (void)startWithCompletionBlockWithSuccess:(void (^)(APIBatchRequest *batchRequest))success
                                    failure:(void (^)(APIBatchRequest *batchRequest))failure;

- (void)setCompletionBlockWithSuccess:(void (^)(APIBatchRequest *batchRequest))success
                              failure:(void (^)(APIBatchRequest *batchRequest))failure;

/// 把block置nil来打破循环引用
- (void)clearCompletionBlock;

/// Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<APIRequestAccessory>)accessory;

/// 是否当前的数据从缓存获得
- (BOOL)isDataFromCache;

@end
