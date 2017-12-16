//
//  MessageAPI.h
//  NewStock
//
//  Created by Willey on 16/10/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface MessageAPI : APIListRequest
@property (nonatomic, strong) NSString *mId;
@property (nonatomic, strong) NSString *rl;

@end
