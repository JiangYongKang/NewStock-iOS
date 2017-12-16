//
//  GetVerificationCodeAPI.h
//  NewStock
//
//  Created by Willey on 16/8/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

typedef NS_ENUM(NSInteger, VERIFICATION_CODE_TYPE) {
    VERIFICATION_CODE_LOGIN,
    VERIFICATION_CODE_REGISTER,
    VERIFICATION_CODE_RETPWD,
    VERIFICATION_CODE_UPDPH,
    VERIFICATION_CODE_BIND
};

@interface GetVerificationCodeAPI : APIRequest

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) VERIFICATION_CODE_TYPE type;

@end
