//
//  PostFeedPicAPI.m
//  NewStock
//
//  Created by 王迪 on 2016/11/25.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PostFeedPicAPI.h"
#import "Defination.h"

@implementation PostFeedPicAPI

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return _imageArray.count > 1 ? API_UPLOAD_IMGS : API_UPLOAD_IMG;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        
        if (_imageArray.count == 1) {
            NSData *data = UIImageJPEGRepresentation(self.imageArray.firstObject, 0.9);
            NSString *name = @"file";
            NSString *formKey = @"file";
            NSString *type = @"image/jpeg";
            [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        }else {
        
            for (int i = 0; i < _imageArray.count; i ++) {
                NSData *data = UIImageJPEGRepresentation(self.imageArray[i], 0.9);
                NSString *name = @"files";
                NSString *formKey = @"files";
                NSString *type = @"image/jpeg";
                [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
            }

        }
        
    };
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"ty":self.ty.length == 0 ? @"forum" : self.ty
                          };
    
    return dic;
}

//添加公共的请求头
//- (NSDictionary *)requestHeaderFieldValueDictionary {
//    return @{@"Content-Type": @"application/json;charset=UTF-8"};
//}

@end
