//
//  ShareAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/1/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface ShareAPI : APIRequest

@property (nonatomic, strong) UIImage *file;

@property (nonatomic, strong) NSString *img;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *tt;

@property (nonatomic, strong) NSString *c;

@property (nonatomic, strong) NSString *ty;

@property (nonatomic, strong) NSString *sid;

@property (nonatomic, strong) NSString *res_code;

@property (nonatomic, strong) NSString *to;

- (instancetype)initWithImg:(NSString *)img url:(NSString *)url tt:(NSString *)tt c:(NSString *)c ty:(NSString *)ty sid:(NSString *)sid res_code:(NSString *)res_code to:(NSString *)to;


@end
