//
//  TaoQLNGHistoryListAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/6/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TaoQLNGHistoryListAPI : APIRequest

@property (nonatomic, strong) NSString *page;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) NSString *ids;

@end
