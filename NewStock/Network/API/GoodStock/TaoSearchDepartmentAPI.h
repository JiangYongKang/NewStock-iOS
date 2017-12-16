//
//  TaoSearchDepartmentAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TaoSearchDepartmentAPI : APIRequest

@property (nonatomic, copy) NSString *n;

@property (nonatomic, copy) NSString *sd;

@property (nonatomic, copy) NSString *ed;

@property (nonatomic, strong) NSNumber *count;

@end
