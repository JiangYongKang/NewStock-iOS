//
//  TaoPoolListModel.h
//  NewStock
//
//  Created by 王迪 on 2017/6/20.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>


@interface TaoPoolListStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *zx;
@property (nonatomic, strong) NSString *zdf;

@end

@interface TaoPoolListModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSArray *list;

@end
