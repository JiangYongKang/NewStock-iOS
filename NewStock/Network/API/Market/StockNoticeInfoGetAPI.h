//
//  StockNoticeInfoGetAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/6/28.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface StockNoticeInfoGetAPI : APIRequest

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *m;

@end
