//
//  FeedMappedAPI.h
//  NewStock
//
//  Created by Willey on 16/9/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface FeedMappedAPI : APIListRequest

@property (nonatomic, strong) NSString *res_code;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, copy) NSString *tt;

@end
