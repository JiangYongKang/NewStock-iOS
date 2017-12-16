//
//  SharedInstance.h
//  NewStock
//
//  Created by 王迪 on 2017/1/18.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareAPI.h"
#import "ARCSingletonTemplate.h"


@interface SharedInstance : NSObject

SYNTHESIZE_SINGLETON_FOR_HEADER(SharedInstance)

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *tt;

@property (nonatomic, copy) NSString *c;

@property (nonatomic, copy) NSString *res_code;

@property (nonatomic, copy) NSString *sid;

@property (nonatomic, strong) UIImage *image;


- (void)shareWithImg:(NSString *)img file:(UIImage *)file url:(NSString *)url c:(NSString *)c tt:(NSString *)tt ty:(NSString *)ty sid:(NSString *)sid res_code:(NSString *)res_code to:(NSString *)to ;


- (void)shareWithImage:(BOOL)onlyImg ;





@end
