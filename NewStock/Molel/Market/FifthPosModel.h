//
//  FifthPosModel.h
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FifthPosModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * buyCount1;
@property (nonatomic, strong) NSString * buyCount2;
@property (nonatomic, strong) NSString * buyCount3;
@property (nonatomic, strong) NSString * buyCount4;
@property (nonatomic, strong) NSString * buyCount5;
@property (nonatomic, strong) NSString * buyPrice1;
@property (nonatomic, strong) NSString * buyPrice2;
@property (nonatomic, strong) NSString * buyPrice3;
@property (nonatomic, strong) NSString * buyPrice4;
@property (nonatomic, strong) NSString * buyPrice5;

@property (nonatomic, strong) NSString * hand;
@property (nonatomic, strong) NSString * marketCd;
@property (nonatomic, strong) NSString * prevClose;
@property (nonatomic, strong) NSString * pricePrecision;

@property (nonatomic, strong) NSString * sellCount1;
@property (nonatomic, strong) NSString * sellCount2;
@property (nonatomic, strong) NSString * sellCount3;
@property (nonatomic, strong) NSString * sellCount4;
@property (nonatomic, strong) NSString * sellCount5;
@property (nonatomic, strong) NSString * sellPrice1;
@property (nonatomic, strong) NSString * sellPrice2;
@property (nonatomic, strong) NSString * sellPrice3;
@property (nonatomic, strong) NSString * sellPrice4;
@property (nonatomic, strong) NSString * sellPrice5;

@property (nonatomic, strong) NSString * symbol;
@property (nonatomic, strong) NSString * symbolTyp;

@end
