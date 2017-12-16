//
//  RegisterAPI.h
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface RegisterAPI : APIRequest

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *pwd;

@end
