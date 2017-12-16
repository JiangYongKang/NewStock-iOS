//
//  StockListModel.h
//  NewStock
//
//  Created by Willey on 16/8/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StockListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString * symbol;
@property (nonatomic, strong) NSString * symbolTyp;
@property (nonatomic, strong) NSString * marketCd;
@property (nonatomic, strong) NSString * consecutivePresentPrice;
@property (nonatomic, strong) NSString * presentPrice;
@property (nonatomic, strong) NSString * tradeIncrease;
@property (nonatomic, strong) NSString * stockUD;
@property (nonatomic, strong) NSString * symbolName;
@property (nonatomic, strong) NSString * min5UpDown;
@property (nonatomic, strong) NSString * sectorTurnover;

@property (nonatomic, strong) NSString * consecutiveVolume;
@property (nonatomic, strong) NSString * turnover;
@property (nonatomic, strong) NSString * volumePrice;



@property (nonatomic, strong) NSString * riseCount;
@property (nonatomic, strong) NSString * fallCount;
@property (nonatomic, strong) NSString * keepCount;

@end
