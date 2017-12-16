//
//  SetUserSettingAPI.m
//  NewStock
//
//  Created by Willey on 16/10/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "SetUserSettingAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation SetUserSettingAPI


- (NSString *)requestUrl {
    return USER_SET_UPDATE;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}
- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    if (self.userId)[muDic setObject:self.userId forKey:@"uid"];
    if (self.res_code)[muDic setObject:self.res_code forKey:@"res_code"];
    
    if (self.cv)[muDic setObject:self.cv forKey:@"cv"];
    if (self.sv)[muDic setObject:self.sv forKey:@"sv"];
    if (self.ev)[muDic setObject:self.ev forKey:@"ev"];
    
    //return muDic;
    return [[NSArray alloc] initWithObjects:muDic, nil];

}

- (id)jsonValidator {
    return nil;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
