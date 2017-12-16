//
//  UploadImageAPI.m
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UploadImageAPI.h"
#import "Defination.h"

@implementation UploadImageAPI
- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_ACCOUNT_UPLOAD_IMG;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self.image, 0.9);
        NSString *name = @"file";
        NSString *formKey = @"file";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"ty":@"ico"
                          };
    
    return dic;
}

//添加公共的请求头
//- (NSDictionary *)requestHeaderFieldValueDictionary {
//    return @{@"Content-Type": @"application/json;charset=UTF-8"};
//}
@end
