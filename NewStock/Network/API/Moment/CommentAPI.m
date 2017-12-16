//
//  CommentAPI.m
//  NewStock
//
//  Created by Willey on 16/9/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "CommentAPI.h"
#import "Defination.h"

@implementation CommentAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_POST_COMMENT;
}

- (id)requestArgument {
    NSDictionary *ctmDic = @{
                             @"ams":self.ams.length ? self.ams : @"N",
                             };
//    NSDictionary *dic = @{
//                          @"uid":self.uid,
//                          @"c":self.c,
//                          @"fid":self.fid,
//                          @"ctm":ctmDic
//                          };
    //return dic;

    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    [muDic setObject:self.uid forKey:@"uid"];
    [muDic setObject:self.c forKey:@"c"];
    [muDic setObject:self.fid forKey:@"fid"];
    [muDic setObject:ctmDic forKey:@"ctm"];
    
    if (self.rpid)[muDic setObject:self.rpid forKey:@"rpid"];
    if (self.rpuid)[muDic setObject:self.rpuid forKey:@"rpuid"];
    return muDic;
    
}

//添加公共的请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

@end
