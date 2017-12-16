//
//  SetUserSettingAPI.h
//  NewStock
//
//  Created by Willey on 16/10/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface SetUserSettingAPI : APIRequest

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *res_code;
@property (nonatomic, strong) NSString *cv;
@property (nonatomic, strong) NSString *sv;
@property (nonatomic, strong) NSString *ev;

@end
