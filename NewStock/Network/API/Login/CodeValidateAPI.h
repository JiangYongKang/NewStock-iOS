//
//  CodeValidateAPI.h
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface CodeValidateAPI : APIRequest

@property (nonatomic, strong) NSString *ph;
@property (nonatomic, strong) NSString *rty;
@property (nonatomic, strong) NSString *vd;

@end
