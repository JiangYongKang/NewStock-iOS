//
//  PostFeedPicAPI.h
//  NewStock
//
//  Created by 王迪 on 2016/11/25.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIListRequest.h"

@interface PostFeedPicAPI : APIRequest

@property (nonatomic) NSArray <UIImage *>*imageArray;

@property (nonatomic, copy) NSString *ty;

@end
