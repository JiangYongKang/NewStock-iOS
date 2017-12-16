//
//  TaoQLNGModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoQLNGUserModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *c;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *uid;

@end

@interface TaoQLNGStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *zx;
@property (nonatomic, strong) NSString *zdf;
@property (nonatomic, strong) NSString *maxzdf;
@property (nonatomic, strong) NSString *ip;

@end

@interface TaoQLNGModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *tt;
@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) TaoQLNGUserModel *comment;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *three;
@property (nonatomic, strong) NSString *five;
@property (nonatomic, strong) NSString *win;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray *list;

@end
