//
//  TaoQLNGListModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoQLNGStockListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *zx;
@property (nonatomic, strong) NSString *zdf;
@property (nonatomic, strong) NSString *highestChg;
@property (nonatomic, strong) NSString *inPrice;

@end

@interface TaoQLNGListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *tm;
@property (nonatomic, strong) NSArray *list;

@end
