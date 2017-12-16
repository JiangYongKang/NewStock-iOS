//
//  CustomUrlProtocol.m
//  NewStock
//
//  Created by 王迪 on 2017/4/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "CustomUrlProtocol.h"
#import "Defination.h"
#import "DgzqMessageAPI.h"

@interface CustomUrlProtocol () <APIRequestDelegate>

@property (nonatomic, strong) DgzqMessageAPI *messageAPI;

@end

@implementation CustomUrlProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
        return NO;
    }
    //只处理http和https请求
    NSString *scheme = [[request URL] scheme];
    if ( ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
          [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame)) {
        //看看是否已经处理过了，防止无限循环
        NSString *path = request.URL.absoluteString;
        if (![path hasPrefix:API_URL]) {
            NSLog(@"###########   东莞    ##########%@",path);
            dispatch_async(dispatch_get_main_queue(), ^{
                CustomUrlProtocol *obj = [self new];
                
                NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                if (!body.length) {
                    body = @"";
                }
                
                NSString *headerStr = [obj convertToString:request.allHTTPHeaderFields];
                if (!headerStr.length) {
                    headerStr = @"";
                }
                
                NSMutableDictionary *nmDict = [NSMutableDictionary dictionary];
                [nmDict setValue:path forKey:@"url"];
                [nmDict setValue:headerStr forKey:@"header"];
                [nmDict setValue:body forKey:@"param"];
                
                NSString *dictStr = [obj convertToString:nmDict];
                [obj postToSer:dictStr];
                
            });
        }
        // 可以做一些网络请求的需要的事情(如:带cookie等等)
    }
    return YES;
}

//This method returns a canonical version of the given request.
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

//Compares two requests for equivalence with regard to caching.
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

//Starts protocol-specific loading of a request.
- (void)startLoading {
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //打标签，防止无限循环
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableReqeust];
    self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
}

//tops protocol-specific loading of a request.
- (void)stopLoading {
    [self.connection cancel];
    self.connection = nil;
}

#pragma mark - NSURLConnectionDelegate
/// 网络请求返回数据
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *)response;

    NSString *path = response.URL.absoluteString;
    if (![path hasPrefix:API_URL]) {
        dispatch_async(dispatch_get_main_queue(), ^{

            NSString *headerStr = [self convertToString:[httpresponse allHeaderFields]];
            if (!headerStr.length) {
                headerStr = @"";
            }
            
            NSMutableDictionary *nmDict = [NSMutableDictionary dictionary];
            [nmDict setValue:connection.currentRequest.URL.absoluteString forKey:@"url"];
            [nmDict setValue:headerStr forKey:@"header"];
            
            NSString *dictStr = [self convertToString:nmDict];
            [[CustomUrlProtocol new] postToSer:dictStr];
        });
    }
    
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *path = connection.currentRequest.URL.absoluteString;
    if (![path containsString:API_URL]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!body.length) {
                body = @"";
            }
            NSString *bodyStr = [self convertToString:@{@"body":body,@"url":path}];
            [[CustomUrlProtocol new] postToSer:bodyStr];
        });
    };
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

#pragma mark function

- (NSString *)convertToString:(NSDictionary *)dic {
    NSString *jsonStr = @"";
    if (dic == nil) {
        return jsonStr;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    if (data) {
        jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return jsonStr;
}

#pragma mark 

- (void)postToSer:(NSString *)message {
    self.messageAPI.message = message;
    [self.messageAPI start];
}

- (DgzqMessageAPI *)messageAPI {
    if (_messageAPI == nil) {
        _messageAPI = [DgzqMessageAPI new];
        _messageAPI.delegate = self;
    }
    return _messageAPI;
}

@end
