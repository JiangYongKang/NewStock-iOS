//
//  GetUserSettingAPI.h
//  NewStock
//
//  Created by Willey on 16/9/6.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface GetUserSettingAPI : APIRequest


@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *pres_code;

@end
