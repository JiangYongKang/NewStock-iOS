//
//  ThirdLoginAPI.m
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ThirdLoginAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation ThirdLoginAPI

- (NSString *)requestUrl {
    return API_THIRD_LOGIN;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(self.suid)[dic setObject:self.suid forKey:@"suid"];
    if(self.sr)[dic setObject:self.sr forKey:@"sr"];
    if(self.ph)[dic setObject:self.ph forKey:@"ph"];
    if(self.n)[dic setObject:self.n forKey:@"n"];
    if(self.img)[dic setObject:self.img forKey:@"img"];
    if(self.vd)[dic setObject:self.vd forKey:@"vd"];
    
//    NSDictionary *dic = @{
//                          @"suid":self.suid,
//                          @"sr":self.sr,
//                          @"ph":self.ph,
//                          @"n":self.n,
//                          @"img":self.img,
//                          @"vd":self.vd
//                          };
    
    return dic;
}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
