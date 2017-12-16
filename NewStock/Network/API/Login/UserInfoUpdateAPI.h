//
//  UserInfoUpdateAPI.h
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface UserInfoUpdateAPI : APIRequest

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *ph;
@property (nonatomic, strong) NSString *vd;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *npwd;
@property (nonatomic, strong) NSDictionary *ico;

@end
