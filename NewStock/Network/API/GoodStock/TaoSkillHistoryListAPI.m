//
//  TaoSkillHistoryListAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/6/28.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSkillHistoryListAPI.h"
#import "Defination.h"


@implementation TaoSkillHistoryListAPI


- (NSString *)requestUrl {
    return API_TAO_SKILLL_HISTORY_LIST;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"id":self.ids,
             @"page":self.page,
             @"count":self.count,
             };
}

- (id)jsonValidator {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}



@end
