//
//  APINetworkConfig.h
//


#import <Foundation/Foundation.h>
#import "APIBaseRequest.h"

@class AFSecurityPolicy;

@protocol APIUrlFilterProtocol <NSObject>
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(APIBaseRequest *)request;
@end

@protocol APICacheDirPathFilterProtocol <NSObject>
- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(APIBaseRequest *)request;
@end

@interface APINetworkConfig : NSObject

+ (APINetworkConfig *)sharedInstance;

@property (strong, nonatomic) NSString *baseUrl;
@property (strong, nonatomic) NSString *cdnUrl;
@property (strong, nonatomic, readonly) NSArray *urlFilters;
@property (strong, nonatomic) NSDictionary *headerDictionary;
@property (strong, nonatomic, readonly) NSArray *cacheDirPathFilters;
@property (strong, nonatomic) AFSecurityPolicy *securityPolicy;

- (void)addUrlFilter:(id<APIUrlFilterProtocol>)filter;
- (void)addCacheDirPathFilter:(id <APICacheDirPathFilterProtocol>)filter;

@end
