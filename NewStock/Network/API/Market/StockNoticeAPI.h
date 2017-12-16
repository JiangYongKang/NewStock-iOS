//
//  StockNoticeAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/6/20.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface StockNoticeAPI : APIRequest

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *ins;
@property (nonatomic, strong) NSString *outs;
@property (nonatomic, strong) NSString *zdf;
@property (nonatomic, strong) NSString *st;

@end
