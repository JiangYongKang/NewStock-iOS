//
//  StockAnnounceListAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/6/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface StockAnnounceListAPI : APIRequest

@property (nonatomic, strong) NSArray *myStockArray;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *count;

@end
