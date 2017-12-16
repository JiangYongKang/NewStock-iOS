//
//  TaoDeepListAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TaoDeepListAPI : APIRequest

@property (nonatomic, strong) NSString *code;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSString *option;

@end
