//
//  StockApplyModel.h
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StockApplyModelList : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *tm;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *pr;
@property (nonatomic, copy) NSString *pe;
@property (nonatomic, copy) NSString *mx;
@property (nonatomic, copy) NSString *lr;

@end

@interface StockApplyModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *tm;
@property (nonatomic, copy) NSString *wk;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, strong) NSArray *list;

@end
