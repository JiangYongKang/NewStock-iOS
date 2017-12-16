//
//  MomentNewsAnalyisis.h
//  NewStock
//
//  Created by 王迪 on 2017/5/25.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface MomentNewsAnalyisis : APIRequest

@property (nonatomic, copy) NSString *page;

@property (nonatomic, copy) NSString *count;

@end
