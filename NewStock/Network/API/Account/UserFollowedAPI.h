//
//  UserFollowedAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/1/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface UserFollowedAPI : APIRequest

@property (nonatomic, copy) NSString *st;

@property (nonatomic, copy) NSString *fuid;

- (instancetype)initWithSt:(NSString *)st fuid:(NSString *)fuid ;

@end
