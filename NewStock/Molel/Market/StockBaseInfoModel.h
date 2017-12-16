//
//  StockBaseInfoModel.h
//  NewStock
//
//  Created by Willey on 16/8/12.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StockBaseInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString * symbolName;//股票名称
@property (nonatomic, strong) NSString * symbolTyp;
@property (nonatomic, strong) NSString * symbol;
@property (nonatomic, strong) NSString * pricePrecision;//股票价格精度
@property (nonatomic, strong) NSString * consecutivePresentPrice;//现价
@property (nonatomic, strong) NSString * consecutivePresentPriceTime;//现价时刻
@property (nonatomic, strong) NSString * hand;//单位
@property (nonatomic, strong) NSString * tradeIncrease;//涨幅
@property (nonatomic, strong) NSString * stockUD;//涨跌
@property (nonatomic, strong) NSString * high;//最高
@property (nonatomic, strong) NSString * low;//最低
@property (nonatomic, strong) NSString * volumePrice;//成交额
@property (nonatomic, strong) NSString * open;//今开
@property (nonatomic, strong) NSString * prevClose;//昨收
@property (nonatomic, strong) NSString * highLimited;
@property (nonatomic, strong) NSString * lowLimited;
@property (nonatomic, strong) NSString * turnover;//换手率
@property (nonatomic, strong) NSString * averagePrice;//均价
@property (nonatomic, strong) NSString * consecutiveVolume;//总量
@property (nonatomic, strong) NSString * volumeRatio;//委比
@property (nonatomic, strong) NSString * quantityRatio;//量比
@property (nonatomic, strong) NSString * sellTotal;//内盘
@property (nonatomic, strong) NSString * buyTotal;//外盘
@property (nonatomic, strong) NSString * baseDate;//基准日
@property (nonatomic, strong) NSString * amplitude;//振幅%
@property (nonatomic, strong) NSString * min5UpDpwn;//5分钟涨跌幅
@property (nonatomic, strong) NSString * industryUp;//行业涨幅
@property (nonatomic, strong) NSString * sectorMketVal;//板块市值
@property (nonatomic, strong) NSString * riseCount;//上涨家数
@property (nonatomic, strong) NSString * keepCount;//平盘家数
@property (nonatomic, strong) NSString * fallCount;//下跌家数
@property (nonatomic, strong) NSString * tradeHaltCnt;//停盘家数
@property (nonatomic, strong) NSString * zsCnt;//总数家数

@property (nonatomic, strong) NSString * sectorTurnover;//板块换手率

@property (nonatomic, strong) NSString * leadingStock;//领涨股(股票区分：股票代码：市场代码：领涨股涨跌幅)

@property (nonatomic, strong) NSString * earning;//市盈(动)

@property (nonatomic, strong) NSString * pbRatio;//市净率

@property (nonatomic, strong) NSString * industryName;//板块名称

@property (nonatomic, strong) NSString * zgb;//总股本

@property (nonatomic, strong) NSString * ltg;//流通股

@property (nonatomic, strong) NSString * netAsset;//净资

@property (nonatomic, strong) NSString * marketVal;//流通市值

@property (nonatomic, strong) NSString * totalMarketVal;//总市值

@end



