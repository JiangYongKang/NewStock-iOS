//
//  PostFeedAPI.h
//  NewStock
//
//  Created by Willey on 16/9/20.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface PostFeedAPI : APIListRequest

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *tt;
@property (nonatomic, strong) NSString *c;
@property (nonatomic, strong) NSNumber *st;
@property (nonatomic, strong) NSString *pid;

@property (nonatomic, strong) NSString *stag_code;
@property (nonatomic, strong) NSString *res_code;
@property (nonatomic, strong) NSString *ams;

@property (nonatomic, strong) NSArray *imgs;

@end
