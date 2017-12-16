//
//  MomentListAPI.h
//  NewStock
//
//  Created by 王迪 on 2016/12/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface MomentListAPI : APIListRequest

@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *res_code;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *order;

- (instancetype)initWithCount:(NSString *)count res_code:(NSString *)res_code page:(NSString *)page order:(NSString *)order fromNum:(long)fromNum toNum:(long)toNum ;

@end
