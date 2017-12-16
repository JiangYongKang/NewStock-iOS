//
//  DelMyStockAPI.h
//  NewStock
//
//  Created by Willey on 16/9/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"
#import "StockCodesModel.h"

@interface DelMyStockAPI : APIRequest

@property (nonatomic, strong) NSArray <StockCodeInfo *>*modelArray;

@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *m;

@end
