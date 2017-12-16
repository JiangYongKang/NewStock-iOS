//
//  APIBatchRequest.m
//


#import "APIBatchRequest.h"
#import "APINetworkPrivate.h"
#import "APIBatchRequestAgent.h"

@interface APIBatchRequest() <APIRequestDelegate>

@property (nonatomic) NSInteger finishedCount;

@end

@implementation APIBatchRequest

- (id)initWithRequestArray:(NSArray *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _finishedCount = 0;
        for (APIRequest * req in _requestArray) {
            if (![req isKindOfClass:[APIRequest class]]) {
                APILog(@"Error, request item must be APIRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    if (_finishedCount > 0) {
        APILog(@"Error! Batch request has already started.");
        return;
    }
    _failedRequest = nil;
    [[APIBatchRequestAgent sharedInstance] addBatchRequest:self];
    [self toggleAccessoriesWillStartCallBack];
    for (APIRequest * req in _requestArray) {
        req.delegate = self;
        [req start];
    }
}

- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    _delegate = nil;
    [self clearRequest];
    [self toggleAccessoriesDidStopCallBack];
    [[APIBatchRequestAgent sharedInstance] removeBatchRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(APIBatchRequest *batchRequest))success
                                    failure:(void (^)(APIBatchRequest *batchRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(APIBatchRequest *batchRequest))success
                              failure:(void (^)(APIBatchRequest *batchRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (BOOL)isDataFromCache {
    BOOL result = YES;
    for (APIRequest *request in _requestArray) {
        if (!request.isDataFromCache) {
            result = NO;
        }
    }
    return result;
}


- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate

- (void)requestFinished:(APIRequest *)request {
    _finishedCount++;
    if (_finishedCount == _requestArray.count) {
        [self toggleAccessoriesWillStopCallBack];
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
        [self clearCompletionBlock];
        [self toggleAccessoriesDidStopCallBack];
        [[APIBatchRequestAgent sharedInstance] removeBatchRequest:self];
    }
}

- (void)requestFailed:(APIRequest *)request {
    _failedRequest = request;
    [self toggleAccessoriesWillStopCallBack];
    // Stop
    for (APIRequest *req in _requestArray) {
        [req stop];
    }
    // Callback
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self);
    }
    // Clear
    [self clearCompletionBlock];
    
    [self toggleAccessoriesDidStopCallBack];
    [[APIBatchRequestAgent sharedInstance] removeBatchRequest:self];
}

- (void)clearRequest {
    for (APIRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<APIRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

@end
