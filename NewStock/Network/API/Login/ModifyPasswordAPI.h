//
//  ModifyPasswordAPI.h
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface ModifyPasswordAPI : APIRequest

@property (nonatomic, strong) NSString *ph;
@property (nonatomic, strong) NSString *vd;
@property (nonatomic, strong) NSString *pwd;

@end
