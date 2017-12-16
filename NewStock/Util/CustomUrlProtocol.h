//
//  CustomUrlProtocol.h
//  NewStock
//
//  Created by 王迪 on 2017/4/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const URLProtocolHandledKey =   @"URLProtocolHandledKey";

@interface CustomUrlProtocol : NSURLProtocol <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;

@end
