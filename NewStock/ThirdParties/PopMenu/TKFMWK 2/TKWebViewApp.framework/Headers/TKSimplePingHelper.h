//
//  SimplePingHelper.h
//  PingTester
//
//  Created by Chris Hulbert on 18/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKSimplePing.h"

@interface TKSimplePingHelper : NSObject <TKSimplePingDelegate>

+ (void)ping:(NSString*)address target:(id)target sel:(SEL)sel userInfo:(id)userInfo;

+ (void)ping:(NSString*)address sendData:(NSData *)data target:(id)target sel:(SEL)sel userInfo:(id)userInfo;

+ (void)ping:(NSString*)address sendSize:(int)size target:(id)target sel:(SEL)sel userInfo:(id)userInfo;

@end
