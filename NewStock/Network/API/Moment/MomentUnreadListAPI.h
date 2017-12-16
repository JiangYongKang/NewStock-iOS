//
//  MomentUnreadListAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/3/30.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface MomentUnreadListAPI : APIRequest

@property (nonatomic, copy) NSString *res_code;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *count;

@end
