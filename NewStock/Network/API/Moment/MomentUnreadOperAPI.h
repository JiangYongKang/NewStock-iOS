//
//  MomentUnreadOperAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/3/30.
//  Copyright © 2017年 Willey. All rights reserved.


#import "APIRequest.h"

@interface MomentUnreadOperAPI : APIRequest

@property (nonatomic, copy) NSString *ids;

@property (nonatomic, strong) NSString *st;

@end
