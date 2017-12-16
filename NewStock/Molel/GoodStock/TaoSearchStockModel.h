//
//  TaoSearchStockModel.h
//  NewStock
//
//  Created by 王迪 on 2017/2/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TaoSearchStockModel : MTLModel <MTLJSONSerializing>

@property (nonatomic ,copy) NSString *tm;
@property (nonatomic ,copy) NSString *zx;
@property (nonatomic ,copy) NSString *zxzdf;
@property (nonatomic ,copy) NSString *close;
@property (nonatomic ,copy) NSString *zdf;
@property (nonatomic ,copy) NSString *tvmt;
@property (nonatomic ,copy) NSString *tvlt;

@property (nonatomic ,strong) NSArray *list;

@end

@interface TaoSearchStockModelList : MTLModel <MTLJSONSerializing>

@property (nonatomic ,copy) NSString *n;
@property (nonatomic ,copy) NSString *t;
@property (nonatomic ,copy) NSString *ct;
@property (nonatomic ,copy) NSString *bt;
@property (nonatomic ,copy) NSString *st;
@property (nonatomic ,copy) NSString *nbuy;

@property (nonatomic ,strong) NSArray *buy;
@property (nonatomic ,strong) NSArray *sale;

@end

@interface TaoSearchStockBSModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *n;
@property (nonatomic, copy) NSString *b;
@property (nonatomic, copy) NSString *s;

@end

