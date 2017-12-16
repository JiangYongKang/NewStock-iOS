//
//  BoardListAPI.h
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"
#import "APIListRequest.h"

@interface BoardListAPI : APIListRequest

- (id)initWithCategory:(NSString *)category
                upDown:(NSString *)upDown
                fromNo:(long )fromNo
                  toNo:(long )toNo;

@end
