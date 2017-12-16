//
//  PostFeedAPI.m
//  NewStock
//
//  Created by Willey on 16/9/20.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PostFeedAPI.h"
#import "Defination.h"

@implementation PostFeedAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_POST_FEED;
}

- (id)requestArgument {
    NSDictionary *ctmDic = @{
                             @"res_code":self.res_code,// @"S_FORUM",
                             @"sid":@"",
                             @"stag_code":self.stag_code,
                             @"ams":self.ams
                             };

    NSDictionary *dic;
    if (self.fid) {
        dic = @{
                @"uid":self.uid,
                @"id":self.fid,
                @"ty":@0,
                @"st":self.st,
                @"tt":self.tt,
                @"ctm":ctmDic,
                @"c":self.c,
                @"imgs":self.imgs != nil ? self.imgs : @[],
                };
    }
    else
    {
        dic = @{
                @"uid":self.uid,
                @"ty":@0,
                @"st":self.st,
                @"tt":self.tt,
                @"pid":self.pid.length ? self.pid : @"",
                @"ctm":ctmDic,
                @"c":self.c,
                @"imgs":self.imgs != nil ? self.imgs : @[],
                };
    }
    return dic;
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
