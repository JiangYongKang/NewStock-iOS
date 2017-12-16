//
//  NativeUrlRedirectAction.h
//  NewStock
//
//  Created by 王迪 on 2017/3/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCSingletonTemplate.h"

@interface NativeUrlRedirectAction : NSObject

SYNTHESIZE_SINGLETON_FOR_HEADER(NativeUrlRedirectAction)

- (void)redictNativeUrl:(NSString *)url;

+ (void)nativePushToStock:(NSString *)n s:(NSString *)s t:(NSString *)t m:(NSString *)m;

+ (void)nativePushToTigetStock:(NSString *)n s:(NSString *)s t:(NSString *)t m:(NSString *)m d:(NSString *)d ;

+ (void)nativePushtoTigerDepartment:(NSString *)name startDate:(NSString *)startDate endDate:(NSString *)endDate ;

+ (void)nativePushToUserPage:(NSString *)ids ;

@end
