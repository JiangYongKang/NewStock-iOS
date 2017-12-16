//
//  TaoDBSQAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/6/21.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TaoDBSQAPI : APIRequest

@property (nonatomic, strong) NSString *page;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) NSString *code;

@end
