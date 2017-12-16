//
//  StockApplyDetailModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/29.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StockApplyDetailModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *sd;
@property (nonatomic, strong) NSString *pd;
@property (nonatomic, strong) NSString *lr;
@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) NSString *pr;
@property (nonatomic, strong) NSString *pe;
@property (nonatomic, strong) NSString *iv;
@property (nonatomic, strong) NSString *mx;
@property (nonatomic, strong) NSString *iiv;
@property (nonatomic, strong) NSString *tl;
@property (nonatomic, strong) NSString *desc;

@end

@interface StockApplyDetailValueModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

@end
