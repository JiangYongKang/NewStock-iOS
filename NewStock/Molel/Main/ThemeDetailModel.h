//
//  ThemeDetailModel.h
//  NewStock
//
//  Created by 王迪 on 2017/5/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ThemeDetailStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *zdf;
@property (nonatomic, strong) NSString *zx;

@end

@interface ThemeDetailTmlModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *tt;
@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) NSString *rmd;
@property (nonatomic, strong) NSArray *sl;

@end

@interface ThemeDetailSctModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *zdf;

@end

@interface ThemeDetailModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *tt;
@property (nonatomic, strong) NSString *dsc;
@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *rmd;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSArray *sct;
@property (nonatomic, strong) NSArray *sl;
@property (nonatomic, strong) NSArray *tml;

@end
