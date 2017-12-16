//
//  RankListAPI.h
//  NewStock
//
//  Created by Willey on 16/7/29.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"
#import "APIListRequest.h"

@interface RankListAPI : APIListRequest

- (id)initWithRankName:(NSString *)rankName
                upDown:(NSString *)upDown
                fromNo:(long )fromNo
                  toNo:(long )toNo;


@end
