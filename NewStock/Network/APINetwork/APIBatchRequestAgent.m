//
//  APIBatchRequestAgent.m
//


#import "APIBatchRequestAgent.h"

@interface APIBatchRequestAgent()

@property (strong, nonatomic) NSMutableArray *requestArray;

@end

@implementation APIBatchRequestAgent

+ (APIBatchRequestAgent *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addBatchRequest:(APIBatchRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeBatchRequest:(APIBatchRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
