//
//  FavouritesFeedAPI.h
//  NewStock
//
//  Created by Willey on 16/9/30.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface FavouritesFeedAPI : APIRequest
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *opty;
@end
