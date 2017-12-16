//
//  IndexInfoModel.h
//  NewStock
//
//  Created by Willey on 16/8/3.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "Mantle.h"

@interface IndexInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * consecutivePresentPrice;
@property (nonatomic, strong) NSString * consecutivePresentPriceTime;
@property (nonatomic, strong) NSString * hand;
@property (nonatomic, strong) NSString * marketCd;
@property (nonatomic, strong) NSString * pricePrecision;
@property (nonatomic, strong) NSString * stockUD;
@property (nonatomic, strong) NSString * symbol;
@property (nonatomic, strong) NSString * symbolName;
@property (nonatomic, strong) NSString * symbolTyp;
@property (nonatomic, strong) NSString * symbolView;
@property (nonatomic, strong) NSString * tradeIncrease;


@end