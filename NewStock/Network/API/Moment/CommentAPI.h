//
//  CommentAPI.h
//  NewStock
//
//  Created by Willey on 16/9/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface CommentAPI : APIListRequest
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *c;

@property (nonatomic, strong) NSString *fid;

@property (nonatomic, strong) NSString *rpid;
@property (nonatomic, strong) NSString *rpuid;

//@property (nonatomic, strong) NSString *rpid;

@property (nonatomic, strong) NSString *ams;

@end
