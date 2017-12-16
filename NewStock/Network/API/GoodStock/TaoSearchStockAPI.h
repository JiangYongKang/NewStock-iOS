//
//  TaoSearchStockAPI.h
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface TaoSearchStockAPI : APIRequest

@property (nonatomic, copy) NSString *d;

@property (nonatomic, copy) NSString *s;

@property (nonatomic, strong)NSNumber *t;

@property (nonatomic, strong)NSNumber *m;

@end
