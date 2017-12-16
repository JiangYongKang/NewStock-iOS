//
//  TaoQLNGCommentListAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TaoQLNGCommentListAPI : APIRequest

@property (nonatomic, strong) NSString *ids;

@property (nonatomic, strong) NSString *page;

@property (nonatomic, strong) NSString *count;

@end
