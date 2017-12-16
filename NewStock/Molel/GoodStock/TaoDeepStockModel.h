//
//  TaoDeepStockModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoDeepStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *zdf;
@property (nonatomic, strong) NSString *buy;
@property (nonatomic, strong) NSString *cys;
@property (nonatomic, strong) NSString *price;

@end
