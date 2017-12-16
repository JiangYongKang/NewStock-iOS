//
//  FeedChildListAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/5/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface FeedChildListAPI : APIListRequest

@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *res_code;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *pid;

- (instancetype)initWithCount:(NSString *)count res_code:(NSString *)res_code page:(NSString *)page order:(NSString *)order fromNum:(long)fromNum toNum:(long)toNum ;

@end
