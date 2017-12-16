//
//  ThemeTimeLineAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/5/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface ThemeTimeLineAPI : APIRequest

@property (nonatomic, strong) NSString *page;

@property (nonatomic, strong) NSString *count;

@end
