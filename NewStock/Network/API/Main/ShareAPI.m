//
//  ShareAPI.m
//  NewStock
//
//  Created by 王迪 on 2017/1/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ShareAPI.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation ShareAPI

- (instancetype)initWithImg:(NSString *)img url:(NSString *)url tt:(NSString *)tt c:(NSString *)c ty:(NSString *)ty sid:(NSString *)sid res_code:(NSString *)res_code to:(NSString *)to {

    if (self = [super init]) {
        self.img = img.length ? img : @"";
        self.url = url.length ? url : @"";
        self.tt = tt.length ? tt : @"";
        self.c = c.length ? c : @"";
        self.ty = ty.length ? ty : @"";
        self.sid = sid.length ? sid : @"";
        self.to = to.length ? to : @"";
        self.res_code = res_code.length ? res_code : @"";
    }
    return self;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (APIRequestSerializerType)requestSerializerType {
    return APIRequestSerializerTypeJSON;
}

- (NSString *)requestUrl {
    return API_SHARE;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self.file, 0.9);
        NSString *name = @"file";
        NSString *formKey = @"file";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (id)requestArgument {
    
    NSDictionary *dic = @{
                          @"ty" :self.ty,
                          @"img":self.img,
                          @"url":self.url,
                          @"tt" :self.tt,
                          @"ty" :self.ty,
                          @"c"  :self.c,
                          @"sid":self.sid,
                          @"to" :self.to,
                     @"res_code":self.res_code,
                          };
    
    return dic;
}


@end
