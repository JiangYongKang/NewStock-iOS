//
//  StockPerformModel.h
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StockPerformModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *m;
@property (nonatomic, copy) NSString *tm;
@property (nonatomic, copy) NSString *pr;
@property (nonatomic, copy) NSString *zx;
@property (nonatomic, copy) NSString *tzf;
@property (nonatomic, copy) NSString *pf;

@end
