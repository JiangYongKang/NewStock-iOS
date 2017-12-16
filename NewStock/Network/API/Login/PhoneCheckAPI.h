//
//  PhoneCheckAPI.h
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface PhoneCheckAPI : APIRequest

@property (nonatomic, strong) NSString *suid;
@property (nonatomic, strong) NSString *sr;

@end
