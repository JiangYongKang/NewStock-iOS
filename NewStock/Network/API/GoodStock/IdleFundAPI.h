//
//  IdleFundAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface IdleFundAPI : APIRequest

@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *code;

@end
