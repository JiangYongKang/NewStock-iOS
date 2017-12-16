//
//  Y-KlineModel.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineModel.h"
#import "Y_KLineGroupModel.h"
#import "Y_StockChartGlobalVariable.h"
#import "SystemUtil.h"

@interface Y_KLineModel ()

@property (nonatomic, copy) NSNumber *maxLC;

@property (nonatomic, copy) NSNumber *absLC;

@end

@implementation Y_KLineModel

- (NSNumber *)RSV_9 {
    if (!_RSV_9) {
        if(self.NineClocksMinPrice == self.NineClocksMaxPrice) {
            _RSV_9 = @100;
        } else {
            _RSV_9 = @((self.Close.floatValue - self.NineClocksMinPrice.floatValue) * 100 / (self.NineClocksMaxPrice.floatValue - self.NineClocksMinPrice.floatValue));
        }
    }
    return _RSV_9;
}

- (NSNumber *)KDJ_K {
    if (!_KDJ_K) {
        _KDJ_K = @((self.RSV_9.floatValue + 2 * (self.PreviousKlineModel.KDJ_K ? self.PreviousKlineModel.KDJ_K.floatValue : 50) )/3);
    }
    return _KDJ_K;
}

- (NSNumber *)KDJ_D {
    if(!_KDJ_D) {
        _KDJ_D = @((self.KDJ_K.floatValue + 2 * (self.PreviousKlineModel.KDJ_D ? self.PreviousKlineModel.KDJ_D.floatValue : 50))/3);
    }
    return _KDJ_D;
}

- (NSNumber *)KDJ_J {
    if(!_KDJ_J) {
        _KDJ_J = @(3*self.KDJ_K.floatValue - 2*self.KDJ_D.floatValue);
    }
    return _KDJ_J;
}

- (NSNumber *)MA7 {
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA7) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 4) {
                if (index > 4) {
                    _MA7 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 5].SumOfLastClose.floatValue) / 5);
                } else {
                    _MA7 = @(self.SumOfLastClose.floatValue / 5);
                }
            }
        }
    } else {
        return self.EMA7;
    }
    return _MA7;
}

- (NSNumber *)Volume_MA7 {
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA7) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 6) {
                if (index > 6) {
                    _Volume_MA7 = @((self.SumOfLastVolume.floatValue - self.ParentGroupModel.models[index - 7].SumOfLastVolume.floatValue) / 7);
                } else {
                    _Volume_MA7 = @(self.SumOfLastVolume.floatValue / 7);
                }
            }
        }
    } else {
        return self.Volume_EMA7;
    }
    return _Volume_MA7;
}

- (NSNumber *)Volume_EMA7 {
    if(!_Volume_EMA7) {
        _Volume_EMA7 = @((self.Volume + 3 * self.PreviousKlineModel.Volume_EMA7.floatValue)/4);
    }
    return _Volume_EMA7;
}
//// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
- (NSNumber *)EMA7 {
    if(!_EMA7) {
        _EMA7 = @((self.Close.floatValue + 3 * self.PreviousKlineModel.EMA7.floatValue)/4);
    }
    return _EMA7;
}

- (NSNumber *)EMA30 {
    if(!_EMA30) {
        _EMA30 = @((2 * self.Close.floatValue + 29 * self.PreviousKlineModel.EMA30.floatValue)/31);
    }
    return _EMA30;
}

- (NSNumber *)EMA12 {
    if(!_EMA12) {
        _EMA12 = @((2 * self.Close.floatValue + 11 * self.PreviousKlineModel.EMA12.floatValue)/13);
    }
    return _EMA12;
}

- (NSNumber *)EMA26 {
    if (!_EMA26) {
        _EMA26 = @((2 * self.Close.floatValue + 25 * self.PreviousKlineModel.EMA26.floatValue)/27);
    }
    return _EMA26;
}

- (NSNumber *)MA30 {
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA30) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 29) {
                if (index > 29) {
                    _MA30 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 30].SumOfLastClose.floatValue) / 30);
                } else {
                    _MA30 = @(self.SumOfLastClose.floatValue / 30);
                }
            }
        }
    } else {
        return self.EMA30;
    }
    return _MA30;
}

- (NSNumber *)Volume_MA30 {
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA30) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 29) {
                if (index > 29) {
                    _Volume_MA30 = @((self.SumOfLastVolume.floatValue - self.ParentGroupModel.models[index - 30].SumOfLastVolume.floatValue) / 30);
                } else {
                    _Volume_MA30 = @(self.SumOfLastVolume.floatValue / 30);
                }
            }
        }
    } else {
        return self.Volume_EMA30;
    }
    return _Volume_MA30;
}

- (NSNumber *)Volume_EMA30 {
    if(!_Volume_EMA30) {
        _Volume_EMA30 = @((2 * self.Volume + 29 * self.PreviousKlineModel.Volume_EMA30.floatValue)/31);
    }
    return _Volume_EMA30;
}

- (NSNumber *)MA12 {
    if (!_MA12) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 9) {
            if (index > 9) {
                _MA12 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 10].SumOfLastClose.floatValue) / 10);
            } else {
                _MA12 = @(self.SumOfLastClose.floatValue / 10);
            }
        }
    }
    return _MA12;
}

- (NSNumber *)MA26 {
    if (!_MA26) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            if (index > 19) {
                _MA26 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 20].SumOfLastClose.floatValue) / 20);
            } else {
                _MA26 = @(self.SumOfLastClose.floatValue / 20);
            }
        } else {
            return @0;
        }
    }
    return _MA26;
}

- (NSNumber *)SumOfLastClose {
    if(!_SumOfLastClose) {
        _SumOfLastClose = @(self.PreviousKlineModel.SumOfLastClose.floatValue + self.Close.floatValue);
    }
    return _SumOfLastClose;
}

- (NSNumber *)SumOfLastVolume {
    if(!_SumOfLastVolume) {
        _SumOfLastVolume = @(self.PreviousKlineModel.SumOfLastVolume.floatValue + self.Volume);
    }
    return _SumOfLastVolume;
}

- (NSNumber *)SumOfLastBOLLVART1 {
    if (!_SumOfLastBOLLVART1) {
        _SumOfLastBOLLVART1 = @(self.PreviousKlineModel.SumOfLastBOLLVART1.floatValue + self.BOLL_VART1.floatValue);
    }
    return _SumOfLastBOLLVART1;
}

- (NSNumber *)NineClocksMinPrice {
    if (!_NineClocksMinPrice) {
        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
        {
            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
        } else {
            _NineClocksMinPrice = @0;
        }
    }
    return _NineClocksMinPrice;
}

- (NSNumber *)NineClocksMaxPrice {
    if (!_NineClocksMaxPrice) {
        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
        {
            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
        } else {
            _NineClocksMaxPrice = @0;
        }
    }
    return _NineClocksMaxPrice;
}

#pragma mark add 

- (NSNumber *)absLC {
    if (!_absLC) {
        _absLC = @(ABS(self.Close.floatValue - self.PreClose.floatValue));
    }
    return _absLC;
}

- (NSNumber *)maxLC {
    if (!_maxLC) {
        _maxLC = @(MAX(self.Close.floatValue - self.PreClose.floatValue, 0));
    }
    return _maxLC;
}

////DIF=EMA（12）-EMA（26）         DIF的值即为红绿柱；
//
////今日的DEA值=前一日DEA*8/10+今日DIF*2/10.

- (NSNumber *)DIF {
    if(!_DIF) {
        _DIF = @(self.EMA12.floatValue - self.EMA26.floatValue);
    }
    return _DIF;
}

//已验证
- (NSNumber *)DEA {
    if(!_DEA) {
        _DEA = @(self.PreviousKlineModel.DEA.floatValue * 0.8 + 0.2*self.DIF.floatValue);
    }
    return _DEA;
}

//已验证
- (NSNumber *)MACD {
    if(!_MACD) {
        _MACD = @(2*(self.DIF.floatValue - self.DEA.floatValue));
    }
    return _MACD;
}

//RSI
- (NSNumber *)RSI_6 {
    if (!_RSI_6) {
        _RSI_6 = @(100 * self.RSI_6_max.floatValue / self.RSI_6_abs.floatValue);
    }
    return _RSI_6;
}

- (NSNumber *)RSI_12 {
    if (!_RSI_12) {
        _RSI_12 = @(100 * self.RSI_12_max.floatValue / self.RSI_12_abs.floatValue);
    }
    return _RSI_12;
}

- (NSNumber *)RSI_24 {
    if (!_RSI_24) {
        _RSI_24 = @(100 * self.RSI_24_max.floatValue / self.RSI_24_abs.floatValue);
    }
    return _RSI_24;
}

- (NSNumber *)RSI_6_max {
    if (!_RSI_6_max) {
        _RSI_6_max = [self SMA:self.maxLC.floatValue :6.0 :self.PreviousKlineModel.RSI_6_max.floatValue :1];
    }
    return _RSI_6_max;
}

- (NSNumber *)RSI_6_abs {
    if (!_RSI_6_abs) {
        _RSI_6_abs = [self SMA:self.absLC.floatValue :6.0 :self.PreviousKlineModel.RSI_6_abs.floatValue :1];
    }
    return _RSI_6_abs;
}

- (NSNumber *)RSI_12_max {
    if (!_RSI_12_max) {
        _RSI_12_max = [self SMA:self.maxLC.floatValue :12.0 :self.PreviousKlineModel.RSI_12_max.floatValue :1];
    }
    return _RSI_12_max;
}

- (NSNumber *)RSI_12_abs {
    if (!_RSI_12_abs) {
        _RSI_12_abs = [self SMA:self.absLC.floatValue :12.0 :self.PreviousKlineModel.RSI_12_abs.floatValue :1];
    }
    return _RSI_12_abs;
}

- (NSNumber *)RSI_24_max {
    if (!_RSI_24_max) {
        _RSI_24_max = [self SMA:self.maxLC.floatValue :24.0 :self.PreviousKlineModel.RSI_24_max.floatValue :1];
    }
    return _RSI_24_max;
}

- (NSNumber *)RSI_24_abs {
    if (!_RSI_24_abs) {
        _RSI_24_abs = [self SMA:self.absLC.floatValue :24.0 :self.PreviousKlineModel.RSI_24_abs.floatValue :1];
    }
    return _RSI_24_abs;
}

//BOLL

- (NSNumber *)BOLL_VART1 {
    if (!_BOLL_VART1) {
        double vart1 = pow((self.Close.floatValue - self.MA26.floatValue), 2);
        _BOLL_VART1 = [NSNumber numberWithDouble:vart1];
    }
    return _BOLL_VART1;
}

- (NSNumber *)BOLL_VART2 {
    if (!_BOLL_VART2) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            if (index > 19) {
                _BOLL_VART2 = @((self.SumOfLastBOLLVART1.floatValue - self.ParentGroupModel.models[index - 20].SumOfLastBOLLVART1.floatValue) / 20);
            } else {
                _BOLL_VART2 = @(self.SumOfLastBOLLVART1.floatValue / 20);
            }
        } else {
            return @0;
        }
    }
    return _BOLL_VART2;
}

- (NSNumber *)BOLL_VART3 {
    if (!_BOLL_VART3) {
        _BOLL_VART3 = @(sqrt(self.BOLL_VART2.doubleValue));
    }
    return _BOLL_VART3;
}

- (NSNumber *)BOLL_MID {
    if (!_BOLL_MID) {
        _BOLL_MID = self.MA26;
    }
    return _BOLL_MID;
}

- (NSNumber *)BOLL_UPPER {
    if (!_BOLL_UPPER) {
        _BOLL_UPPER = @(self.BOLL_MID.floatValue + 2 * self.BOLL_VART3.floatValue);
    }
    return _BOLL_UPPER;
}

- (NSNumber *)BOLL_DOWN {
    if (!_BOLL_DOWN) {
        _BOLL_DOWN = @(self.BOLL_MID.floatValue - 2 * self.BOLL_VART3.floatValue);
    }
    return _BOLL_DOWN;
}

- (Y_KLineModel *)PreviousKlineModel {
    if (!_PreviousKlineModel) {
        _PreviousKlineModel = [Y_KLineModel new];
        _PreviousKlineModel.DIF = @(0);
        _PreviousKlineModel.DEA = @(0);
        _PreviousKlineModel.MACD = @(0);
        _PreviousKlineModel.MA7 = @(0);
        _PreviousKlineModel.MA12 = @(0);
        _PreviousKlineModel.MA26 = @(0);
        _PreviousKlineModel.MA30 = @(0);
        _PreviousKlineModel.EMA7 = @(0);
        _PreviousKlineModel.EMA12 = @(0);
        _PreviousKlineModel.EMA26 = @(0);
        _PreviousKlineModel.EMA30 = @(0);
        _PreviousKlineModel.Volume_MA7 = @(0);
        _PreviousKlineModel.Volume_MA30 = @(0);
        _PreviousKlineModel.Volume_EMA7 = @(0);
        _PreviousKlineModel.Volume_EMA30 = @(0);
        _PreviousKlineModel.SumOfLastClose = @(0);
        _PreviousKlineModel.SumOfLastVolume = @(0);
        _PreviousKlineModel.SumOfLastBOLLVART1 = @(0);
        _PreviousKlineModel.KDJ_K = @(50);
        _PreviousKlineModel.KDJ_D = @(50);
        _PreviousKlineModel.RSI_6 = @0;
        _PreviousKlineModel.RSI_12 = @0;
        _PreviousKlineModel.RSI_24 = @0;
        _PreviousKlineModel.maxLC = @0;
        _PreviousKlineModel.absLC = @0;
        _PreviousKlineModel.BOLL_VART1 = @0;
        _PreviousKlineModel.BOLL_VART2 = @0;
        _PreviousKlineModel.BOLL_VART3 = @0;
        _PreviousKlineModel.BOLL_MID = @0;
        _PreviousKlineModel.BOLL_UPPER = @0;
        _PreviousKlineModel.BOLL_DOWN = @0;
    }
    return _PreviousKlineModel;
}

- (Y_KLineGroupModel *)ParentGroupModel {
    if(!_ParentGroupModel) {
        _ParentGroupModel = [Y_KLineGroupModel new];
    }
    return _ParentGroupModel;
}

//对Model数组进行排序，初始化每个Model的最新9Clock的最低价和最高价
- (void)rangeLastNinePriceByArray:(NSArray<Y_KLineModel *> *)models condition:(NSComparisonResult)cond {
    if([models count] < 8)
    {
        return;
    }
    
    switch (cond) {
            //最高价
        case NSOrderedAscending:
        {
//            第一个循环结束后，ClockFirstValue为最小值
            for (NSInteger j = 7; j >= 1; j--)
            {
                NSNumber *emMaxValue = @0;
                
                NSInteger em = j;
                
                while ( em >= 0 )
                {
                    if([emMaxValue compare:models[em].High] == cond)
                    {
                        emMaxValue = models[em].High;
                    }
                    em--;
                }
                //NSLog(@"%f",emMaxValue.floatValue);
                models[j].NineClocksMaxPrice = emMaxValue;
            }
            //第一个循环结束后，ClockFirstValue为最小值
            for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
            {
                NSNumber *emMaxValue = @0;
                
                NSInteger em = j;
                
                while ( em >= i )
                {
                    if([emMaxValue compare:models[em].High] == cond)
                    {
                        emMaxValue = models[em].High;
                    }
                    em--;
                }
                //NSLog(@"%f",emMaxValue.floatValue);

                models[j].NineClocksMaxPrice = emMaxValue;
            }
        }
            break;
        case NSOrderedDescending:
        {
            //第一个循环结束后，ClockFirstValue为最小值
            
            for (NSInteger j = 7; j >= 1; j--)
            {
                NSNumber *emMinValue = @(10000000000);
                
                NSInteger em = j;
                
                while ( em >= 0 )
                {
                    if([emMinValue compare:models[em].Low] == cond)
                    {
                        emMinValue = models[em].Low;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
            
            for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
            {
                NSNumber *emMinValue = @(10000000000);
                
                NSInteger em = j;
                
                while ( em >= i )
                {
                    if([emMinValue compare:models[em].Low] == cond)
                    {
                        emMinValue = models[em].Low;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
        }
            break;
        default:
            break;
    }
}
//SMA函数
- (NSNumber *)SMA:(CGFloat)data :(CGFloat)period :(CGFloat)prevData :(CGFloat)share {
    return @(((data * share) + (period - share) * prevData) / period);
}

- (void)initWithArray:(NSArray *)arr; {
    NSAssert(arr.count == 6, @"数组长度不足");

    if (self) {
        _Date = arr[0];
        _Open = @([arr[1] floatValue]);
        _High = @([arr[2] floatValue]);
        _Low = @([arr[3] floatValue]);  
        _Close = @([arr[4] floatValue]);

        _Volume = [arr[5] floatValue];
        self.SumOfLastClose = @(_Close.floatValue + self.PreviousKlineModel.SumOfLastClose.floatValue);
        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.floatValue);
//        NSLog(@"%@======%@======%@------%@",_Close,self.MA7,self.MA30,_SumOfLastClose);
    }
}

- (void)initWithDictionary:(NSDictionary *)dic {
    if (self) {
        _Date = [dic objectForKey:@"createChartTime"];
        _Open = [dic objectForKey:@"open"];
        _High = [dic objectForKey:@"high"];
        _Low = [dic objectForKey:@"low"];
        _Close = [dic objectForKey:@"close"];
        
        _PreClose = [dic objectForKey:@"prevClose"];
        
        _AverPrice = [dic objectForKey:@"averagePrice"];
        
        if(![SystemUtil isNotNSnull:_AverPrice])_AverPrice = @(0);
        if(![SystemUtil isNotNSnull:_Close])_Close = @(0);
        if(![SystemUtil isNotNSnull:_PreClose])_PreClose = @(0);
        
        _Volume = [[dic objectForKey:@"volume"] floatValue];
        self.SumOfLastClose = @(_Close.floatValue + self.PreviousKlineModel.SumOfLastClose.floatValue);
        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.floatValue);
        //        NSLog(@"%@======%@======%@------%@",_Close,self.MA7,self.MA30,_SumOfLastClose);
        
    }
}

- (void)initFirstModel {
//    _SumOfLastClose = _Close;
//    _SumOfLastVolume = @(_Volume);
    _KDJ_K = @(55.27);
    _KDJ_D = @(55.27);
    _KDJ_J = @(55.27);
    _MA7 = _Close;
    _MA12 = _Close;
    _MA26 = _Close;
    _MA30 = _Close;
    _EMA7 = _Close;
    _EMA12 = _Close;
    _EMA26 = _Close;
    _EMA30 = _Close;
    _maxLC = _Close;
    _absLC = _Close;
    _RSI_6 = @0;
    _RSI_12 = @0;
    _RSI_24 = @0;
    _RSI_6_max = @0;
    _RSI_6_abs = @0;
    _RSI_12_max = @0;
    _RSI_12_abs = @0;
    _RSI_24_max = @0;
    _RSI_24_abs = @0;
    _BOLL_VART1 = @0;
    _BOLL_VART2 = @0;
    _BOLL_VART3 = @0;
    _BOLL_UPPER = @0;
    _BOLL_MID = @0;
    _BOLL_DOWN = @0;
    _NineClocksMinPrice = _Low;
    _NineClocksMaxPrice = _High;
    [self DIF];
    [self DEA];
    [self MACD];
    [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
    [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
    [self RSV_9];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    [self RSI_6];
    [self RSI_12];
    [self RSI_24];
    [self RSI_6_max];
    [self RSI_6_abs];
    [self RSI_12_max];
    [self RSI_12_abs];
    [self RSI_24_max];
    [self RSI_24_abs];
    [self BOLL_VART1];
    [self BOLL_VART2];
    [self BOLL_VART3];
    [self BOLL_MID];
    [self BOLL_UPPER];
    [self BOLL_DOWN];
}

- (void)initData {
    [self MA7];
    [self MA12];
    [self MA26];
    [self MA30];
    [self EMA7];
    [self EMA12];
    [self EMA26];
    [self EMA30];
    
    [self DIF];
    [self DEA];
    [self MACD];
    [self NineClocksMaxPrice];
    [self NineClocksMinPrice];
    [self RSV_9];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    [self RSI_6];
    [self RSI_12];
    [self RSI_24];
    [self RSI_6_max];
    [self RSI_6_abs];
    [self RSI_12_max];
    [self RSI_12_abs];
    [self RSI_24_max];
    [self RSI_24_abs];
    [self BOLL_VART1];
    [self BOLL_VART2];
    [self BOLL_VART3];
    [self BOLL_MID];
    [self BOLL_UPPER];
    [self BOLL_DOWN];
}

@end
