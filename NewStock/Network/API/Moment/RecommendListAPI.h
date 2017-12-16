//
//  RecommendListAPI.h
//  NewStock
//
//  Created by 王迪 on 2016/12/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface RecommendListAPI : APIListRequest

@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *res_code;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *flag;

- (instancetype)initWithCount:(NSString *)count res_code:(NSString *)res_code page:(NSString *)page ;

@end
