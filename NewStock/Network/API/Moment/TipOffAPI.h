//
//  TipOffAPI.h
//  NewStock
//
//  Created by Willey on 16/9/26.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TipOffAPI : APIRequest

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *contentId;
@property (nonatomic, strong) NSString *ty;
@property (nonatomic, strong) NSString *cty;

@end
