//
//  TaoCXZYModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/21.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoCXZYStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *zx;
@property (nonatomic, strong) NSString *zdf;

@property (nonatomic, strong) NSString *cln;
@property (nonatomic, strong) NSString *odn;

@property (nonatomic, strong) NSString *tr;
@property (nonatomic, strong) NSString *cbon;
@property (nonatomic, strong) NSString *open;

@property (nonatomic, strong) NSString *r;
@property (nonatomic, strong) NSString *oln;
@property (nonatomic, strong) NSString *llt;

@property (nonatomic, strong) NSString *dn;

@end

@interface TaoCXZYModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *dsc;
@property (nonatomic, strong) NSString *list;

@end
