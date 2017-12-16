//
//  ThirdLoginAPI.h
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface ThirdLoginAPI : APIRequest

@property (nonatomic, strong) NSString *suid;
@property (nonatomic, strong) NSString *sr;
@property (nonatomic, strong) NSString *ph;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *vd;
@end
