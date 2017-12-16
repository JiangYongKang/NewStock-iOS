//
//  StockNoticeInfoModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/28.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StockNoticeInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *ins;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *np;
@property (nonatomic, strong) NSString *outs;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *sp;
@property (nonatomic, strong) NSString *st;
@property (nonatomic, strong) NSString *szdf;
@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *zdf;

@end
