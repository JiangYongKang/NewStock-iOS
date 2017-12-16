//
//  APIChainRequestAgent.m
//


#import "APIChainRequestAgent.h"

@interface APIChainRequestAgent()

@property (strong, nonatomic) NSMutableArray *requestArray;

@end

@implementation APIChainRequestAgent

+ (APIChainRequestAgent *)sharedInstance {
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

- (void)addChainRequest:(APIChainRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeChainRequest:(APIChainRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
