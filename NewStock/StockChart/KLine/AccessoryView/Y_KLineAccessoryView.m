//
//  Y_KLineAccessoryView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineAccessoryView.h"
#import "Y_KLineModel.h"

#import "UIColor+Y_StockChart.h"
#import "Y_KLineAccessory.h"
#import "Y_KLineVolumePositionModel.h"
#import "Y_KLinePositionModel.h"
#import "Y_MALine.h"
#import "Y_KLine.h"
@interface Y_KLineAccessoryView()

/**
 *  需要绘制的Volume_MACD位置模型数组
 */
@property (nonatomic, strong) NSArray *needDrawKLineAccessoryPositionModels;

/**
 *  Volume_DIF位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_DIFPositions;

/**
 *  Volume_DEA位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_DEAPositions;

/**
 *  KDJ_K位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_KPositions;

/**
 *  KDJ_D位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_DPositions;

/**
 *  KDJ_J位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_JPositions;

/**
 *  RSI_6位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_RSI_6Positions;

/**
 *  RSI_12位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_RSI_12Positions;

/**
 *  RSI_24位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_RSI_24Positions;

/**
 *  BOLL_UP位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_BOLL_UPPositions;

/**
 *  BOLL_DN位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_BOLL_DNPositions;

/**
 *  BOLL_MID位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_BOLL_MIDPositions;

@end

@implementation Y_KLineAccessoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor backgroundColor];
        self.Accessory_DIFPositions = @[].mutableCopy;
        self.Accessory_DEAPositions = @[].mutableCopy;
        self.Accessory_KDJ_KPositions = @[].mutableCopy;
        self.Accessory_KDJ_DPositions = @[].mutableCopy;
        self.Accessory_KDJ_JPositions = @[].mutableCopy;
        self.Accessory_RSI_6Positions = @[].mutableCopy;
        self.Accessory_RSI_12Positions = @[].mutableCopy;
        self.Accessory_RSI_24Positions = @[].mutableCopy;
        self.Accessory_BOLL_UPPositions = @[].mutableCopy;
        self.Accessory_BOLL_MIDPositions = @[].mutableCopy;
        self.Accessory_BOLL_DNPositions = @[].mutableCopy;
    }
    return self;
}

#pragma mark drawRect方法
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if(!self.needDrawKLineAccessoryPositionModels)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /**
     *  副图，需要区分是MACD线还是KDJ线，进而选择不同的数据源和绘制方法
     */
    if(self.targetLineStatus == Y_StockChartTargetLineStatusMACD)
    {
        /**
         MACD
         */
        Y_KLineAccessory *kLineAccessory = [[Y_KLineAccessory alloc]initWithContext:context];
        [self.needDrawKLineAccessoryPositionModels enumerateObjectsUsingBlock:^(Y_KLineVolumePositionModel * _Nonnull volumePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            kLineAccessory.positionModel = volumePositionModel;
            kLineAccessory.kLineModel = self.needDrawKLineModels[idx];
            kLineAccessory.lineColor = self.kLineColors[idx];
            [kLineAccessory draw];
        }];
        
        Y_MALine *MALine = [[Y_MALine alloc] initWithContext:context];
        MALine.maxY = Y_StockChartKLineMainViewMaxY;

        //画DIF线
        MALine.MAType = Y_MA7Type;
        MALine.MAPositions = self.Accessory_DIFPositions;
        [MALine draw];
        
        //画DEA线
        MALine.MAType = Y_MA30Type;
        MALine.MAPositions = self.Accessory_DEAPositions;
        [MALine draw];
    } else if (self.targetLineStatus == Y_StockChartTargetLineStatusKDJ) {
        /**
        KDJ
         */
        Y_MALine *MALine = [[Y_MALine alloc] initWithContext:context];
        MALine.maxY = Y_StockChartKLineMainViewMaxY;

        //画KDJ_K线
        MALine.MAType = Y_MA7Type;
        MALine.MAPositions = self.Accessory_KDJ_KPositions;
        [MALine draw];
        
        //画KDJ_D线
        MALine.MAType = Y_MA30Type;
        MALine.MAPositions = self.Accessory_KDJ_DPositions;
        [MALine draw];
        
        //画KDJ_J线
        MALine.MAType = -1;
        MALine.MAPositions = self.Accessory_KDJ_JPositions;
        [MALine draw];
    } else if (self.targetLineStatus == Y_StockChartTargetLineStatusRSI) {
        /**
         RSI
         */
        Y_MALine *MALine = [[Y_MALine alloc]initWithContext:context];
        MALine.maxY = Y_StockChartKLineMainViewMaxY;
        
        //画RSI_6线
        MALine.MAType = Y_MA7Type;
        MALine.MAPositions = self.Accessory_RSI_6Positions;
        [MALine draw];
        
        //画RSI_12线
        MALine.MAType = Y_MA30Type;
        MALine.MAPositions = self.Accessory_RSI_12Positions;
        [MALine draw];
        
        //画RSI_24线
        MALine.MAType = -1;
        MALine.MAPositions = self.Accessory_RSI_24Positions;
        [MALine draw];
    } else if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
        /**
         BOLL
         */
        
        Y_MALine *MALine = [[Y_MALine alloc] initWithContext:context];
        MALine.maxY = Y_StockChartKLineMainViewMaxY;
        
        Y_KLine *kLine = [[Y_KLine alloc] initWithContext:context];
        kLine.maxY = Y_StockChartKLineMainViewMaxY;
        
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull kLinePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            kLine.kLinePositionModel = kLinePositionModel;
            kLine.kLineModel = self.needDrawKLineModels[idx];
            [kLine draw];
        }];
        
        //画BOLL_UP线
        MALine.MAType = Y_MA7Type;
        MALine.MAPositions = self.Accessory_BOLL_UPPositions;
        [MALine draw];
        
        //画BOLL_MID线
        MALine.MAType = Y_MA30Type;
        MALine.MAPositions = self.Accessory_BOLL_MIDPositions;
        [MALine draw];
        
        //画BOLL_DOWN线
        MALine.MAType = Y_MA26Type;
        MALine.MAPositions = self.Accessory_BOLL_DNPositions;
        [MALine draw];
    }
    
}

#pragma mark - 公有方法
#pragma mark 绘制volume方法
- (void)draw {
    NSInteger kLineModelcount = self.needDrawKLineModels.count;
    NSInteger kLinePositionModelCount = self.needDrawKLinePositionModels.count;
    NSInteger kLineColorCount = self.kLineColors.count;
    NSAssert(self.needDrawKLineModels && self.needDrawKLinePositionModels && self.kLineColors && kLineColorCount == kLineModelcount && kLinePositionModelCount == kLineModelcount, @"数据异常，无法绘制Volume");
    self.needDrawKLineAccessoryPositionModels = [self private_convertToKLinePositionModelWithKLineModels:self.needDrawKLineModels];
    [self setNeedsDisplay];
}

#pragma mark - 私有方法
#pragma mark 根据KLineModel转换成Position数组
- (NSArray *)private_convertToKLinePositionModelWithKLineModels:(NSArray *)kLineModels {
    CGFloat minY = Y_StockChartKLineAccessoryViewMinY;
    CGFloat maxY = Y_StockChartKLineAccessoryViewMaxY;
    
    __block CGFloat minValue = CGFLOAT_MAX;
    __block CGFloat maxValue = CGFLOAT_MIN;
    
    NSMutableArray *volumePositionModels = @[].mutableCopy;

    if(self.targetLineStatus == Y_StockChartTargetLineStatusMACD)
    {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.DIF)
            {
                if(model.DIF.floatValue < minValue) {
                    minValue = model.DIF.floatValue;
                }
                if(model.DIF.floatValue > maxValue) {
                    maxValue = model.DIF.floatValue;
                }
            }
            
            if(model.DEA)
            {
                if (minValue > model.DEA.floatValue) {
                    minValue = model.DEA.floatValue;
                }
                if (maxValue < model.DEA.floatValue) {
                    maxValue = model.DEA.floatValue;
                }
            }
            if(model.MACD)
            {
                if (minValue > model.MACD.floatValue) {
                    minValue = model.MACD.floatValue;
                }
                if (maxValue < model.MACD.floatValue) {
                    maxValue = model.MACD.floatValue;
                }
            }
        }];
        
        CGFloat unitValue = (maxValue - minValue) / (maxY - minY);
        
        [self.Accessory_DIFPositions removeAllObjects];
        [self.Accessory_DEAPositions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            CGFloat yPosition = - (model.MACD.floatValue - 0) / unitValue + Y_StockChartKLineAccessoryViewMiddleY;
            
//            CGFloat yPosition = ABS(minY + (model.MACD.floatValue - minValue)/unitValue);
//            if(ABS(yPosition - Y_StockChartKLineVolumeViewMaxY) < 0.5)
//            {
//                yPosition = Y_StockChartKLineVolumeViewMaxY - 1;
//            }
            
            CGPoint startPoint = CGPointMake(xPosition, yPosition);
            
            CGPoint endPoint = CGPointMake(xPosition,Y_StockChartKLineAccessoryViewMiddleY);
            Y_KLineVolumePositionModel *volumePositionModel = [Y_KLineVolumePositionModel modelWithStartPoint:startPoint endPoint:endPoint];
            [volumePositionModels addObject:volumePositionModel];
            
            //MA坐标转换
            CGFloat DIFY = maxY;
            CGFloat DEAY = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.DIF)
                {
                    DIFY = - (model.DIF.floatValue - 0) / unitValue + Y_StockChartKLineAccessoryViewMiddleY;
                    //DIFY = maxY - (model.DIF.floatValue - minValue)/unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.DEA)
                {
                    DEAY = -(model.DEA.floatValue - 0)/unitValue + Y_StockChartKLineAccessoryViewMiddleY;
                    //DEAY = maxY - (model.DEA.floatValue - minValue)/unitValue;

                }
            }
            
            NSAssert(!isnan(DIFY) && !isnan(DEAY), @"出现NAN值");
            
            CGPoint DIFPoint = CGPointMake(xPosition, DIFY);
            CGPoint DEAPoint = CGPointMake(xPosition, DEAY);
            
            if(model.DIF)
            {
                [self.Accessory_DIFPositions addObject: [NSValue valueWithCGPoint: DIFPoint]];
            }
            if(model.DEA)
            {
                [self.Accessory_DEAPositions addObject: [NSValue valueWithCGPoint: DEAPoint]];
            }
        }];
    }
    else if (self.targetLineStatus == Y_StockChartTargetLineStatusKDJ)
    {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.KDJ_K)
            {
                if (minValue > model.KDJ_K.floatValue) {
                    minValue = model.KDJ_K.floatValue;
                }
                if (maxValue < model.KDJ_K.floatValue) {
                    maxValue = model.KDJ_K.floatValue;
                }
            }
            
            if(model.KDJ_D)
            {
                if (minValue > model.KDJ_D.floatValue) {
                    minValue = model.KDJ_D.floatValue;
                }
                if (maxValue < model.KDJ_D.floatValue) {
                    maxValue = model.KDJ_D.floatValue;
                }
            }
            
            if(model.KDJ_J)
            {
                if (minValue > model.KDJ_J.floatValue) {
                    minValue = model.KDJ_J.floatValue;
                }
                if (maxValue < model.KDJ_J.floatValue) {
                    maxValue = model.KDJ_J.floatValue;
                }
            }
        }];
        
        CGFloat unitValue = (maxValue - minValue) / (maxY - minY);
        
        [self.Accessory_KDJ_KPositions removeAllObjects];
        [self.Accessory_KDJ_DPositions removeAllObjects];
        [self.Accessory_KDJ_JPositions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            //MA坐标转换
            CGFloat KDJ_K_Y = maxY;
            CGFloat KDJ_D_Y = maxY;
            CGFloat KDJ_J_Y = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_K)
                {
                    KDJ_K_Y = maxY - (model.KDJ_K.floatValue - minValue)/unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_D)
                {
                    KDJ_D_Y = maxY - (model.KDJ_D.floatValue - minValue)/unitValue;
                }
            }
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_J)
                {
                    KDJ_J_Y = maxY - (model.KDJ_J.floatValue - minValue)/unitValue;
                }
            }
            
            NSAssert(!isnan(KDJ_K_Y) && !isnan(KDJ_D_Y) && !isnan(KDJ_J_Y), @"出现NAN值");
            
            CGPoint KDJ_KPoint = CGPointMake(xPosition, KDJ_K_Y);
            CGPoint KDJ_DPoint = CGPointMake(xPosition, KDJ_D_Y);
            CGPoint KDJ_JPoint = CGPointMake(xPosition, KDJ_J_Y);

            
            if(model.KDJ_K)
            {
                [self.Accessory_KDJ_KPositions addObject: [NSValue valueWithCGPoint: KDJ_KPoint]];
            }
            if(model.KDJ_D)
            {
                [self.Accessory_KDJ_DPositions addObject: [NSValue valueWithCGPoint: KDJ_DPoint]];
            }
            if(model.KDJ_J)
            {
                [self.Accessory_KDJ_JPositions addObject: [NSValue valueWithCGPoint: KDJ_JPoint]];
            }
        }];
    }
    else if (self.targetLineStatus == Y_StockChartTargetLineStatusRSI)
    {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.RSI_6)
            {
                if (minValue > model.RSI_6.floatValue) {
                    minValue = model.RSI_6.floatValue;
                }
                if (maxValue < model.RSI_6.floatValue) {
                    maxValue = model.RSI_6.floatValue;
                }
            }
            
            if(model.RSI_12)
            {
                if (minValue > model.RSI_12.floatValue) {
                    minValue = model.RSI_12.floatValue;
                }
                if (maxValue < model.RSI_12.floatValue) {
                    maxValue = model.RSI_12.floatValue;
                }
            }
            
            if(model.RSI_24)
            {
                if (minValue > model.RSI_24.floatValue) {
                    minValue = model.RSI_24.floatValue;
                }
                if (maxValue < model.RSI_24.floatValue) {
                    maxValue = model.RSI_24.floatValue;
                }
            }
        }];
        
        CGFloat unitValue = (maxValue - minValue) / (maxY - minY);
        
        [self.Accessory_RSI_6Positions removeAllObjects];
        [self.Accessory_RSI_12Positions removeAllObjects];
        [self.Accessory_RSI_24Positions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            //MA坐标转换
            CGFloat RSI_6_Y = maxY;
            CGFloat RSI_12_Y = maxY;
            CGFloat RSI_24_Y = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.RSI_6)
                {
                    RSI_6_Y = maxY - (model.RSI_6.floatValue - minValue)/unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.RSI_12)
                {
                    RSI_12_Y = maxY - (model.RSI_12.floatValue - minValue)/unitValue;
                }
            }
            if(unitValue > 0.0000001)
            {
                if(model.RSI_24)
                {
                    RSI_24_Y = maxY - (model.RSI_24.floatValue - minValue)/unitValue;
                }
            }
            
            NSAssert(!isnan(RSI_6_Y) && !isnan(RSI_12_Y) && !isnan(RSI_24_Y), @"出现NAN值");
            
            CGPoint RSI_6Point = CGPointMake(xPosition, RSI_6_Y);
            CGPoint RSI_12Point = CGPointMake(xPosition, RSI_12_Y);
            CGPoint RSI_24Point = CGPointMake(xPosition, RSI_24_Y);
            
            
            if(model.RSI_6)
            {
                [self.Accessory_RSI_6Positions addObject: [NSValue valueWithCGPoint: RSI_6Point]];
            }
            if(model.RSI_12)
            {
                [self.Accessory_RSI_12Positions addObject: [NSValue valueWithCGPoint: RSI_12Point]];
            }
            if(model.RSI_24)
            {
                [self.Accessory_RSI_24Positions addObject: [NSValue valueWithCGPoint: RSI_24Point]];
            }
        }];
    }
    else if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL)
    {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.BOLL_UPPER)
            {
                if (minValue > model.BOLL_UPPER.floatValue) {
                    minValue = model.BOLL_UPPER.floatValue;
                }
                if (maxValue < model.BOLL_UPPER.floatValue) {
                    maxValue = model.BOLL_UPPER.floatValue;
                }
            }
            
            if(model.BOLL_MID)
            {
                if (minValue > model.BOLL_MID.floatValue) {
                    minValue = model.BOLL_MID.floatValue;
                }
                if (maxValue < model.BOLL_MID.floatValue) {
                    maxValue = model.BOLL_MID.floatValue;
                }
            }
            
            if(model.BOLL_DOWN)
            {
                if (minValue > model.BOLL_DOWN.floatValue) {
                    minValue = model.BOLL_DOWN.floatValue;
                }
                if (maxValue < model.BOLL_DOWN.floatValue) {
                    maxValue = model.BOLL_DOWN.floatValue;
                }
            }
        }];
        
        CGFloat unitValue = (maxValue - minValue) / (maxY - minY);
        
        [self.Accessory_BOLL_DNPositions removeAllObjects];
        [self.Accessory_BOLL_UPPositions removeAllObjects];
        [self.Accessory_BOLL_MIDPositions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            //MA坐标转换
            CGFloat BOLL_UP_Y = maxY;
            CGFloat BOLL_MID_Y = maxY;
            CGFloat BOLL_DN_Y = maxY;
            
            if(unitValue > 0.0000001)
            {
                if(model.BOLL_UPPER)
                {
                    BOLL_UP_Y = maxY - (model.BOLL_UPPER.floatValue - minValue)/unitValue;
                }
            }
            if(unitValue > 0.0000001)
            {
                if(model.BOLL_MID)
                {
                    BOLL_MID_Y = maxY - (model.BOLL_MID.floatValue - minValue)/unitValue;
                }
            }
            if(unitValue > 0.0000001)
            {
                if(model.BOLL_DOWN)
                {
                    BOLL_DN_Y = maxY - (model.BOLL_DOWN.floatValue - minValue)/unitValue;
                }
            }
            
            NSAssert(!isnan(BOLL_UP_Y) && !isnan(BOLL_MID_Y) && !isnan(BOLL_DN_Y), @"出现NAN值");
            
            CGPoint BOLL_UPPoint = CGPointMake(xPosition, BOLL_UP_Y);
            CGPoint BOLL_MIDPoint = CGPointMake(xPosition, BOLL_MID_Y);
            CGPoint BOLL_DNPoint = CGPointMake(xPosition, BOLL_DN_Y);
            
            
            if(model.BOLL_UPPER)
            {
                [self.Accessory_BOLL_UPPositions addObject: [NSValue valueWithCGPoint: BOLL_UPPoint]];
            }
            if(model.BOLL_MID)
            {
                [self.Accessory_BOLL_MIDPositions addObject: [NSValue valueWithCGPoint: BOLL_MIDPoint]];
            }
            if(model.BOLL_DOWN)
            {
                [self.Accessory_BOLL_DNPositions addObject: [NSValue valueWithCGPoint: BOLL_DNPoint]];
            }
            
            // kline 坐标转换
            
            CGPoint openPoint = CGPointMake(xPosition, ABS(maxY - (model.Open.floatValue - minValue)/unitValue));
            CGFloat closePointY = ABS(maxY - (model.Close.floatValue - minValue)/unitValue);
            if(ABS(closePointY - openPoint.y) < Y_StockChartKLineMinWidth)
            {
                if(openPoint.y > closePointY)
                {
                    openPoint.y = closePointY + Y_StockChartKLineMinWidth;
                } else if(openPoint.y < closePointY)
                {
                    closePointY = openPoint.y + Y_StockChartKLineMinWidth;
                } else {
                    if(idx > 0)
                    {
                        Y_KLineModel *preKLineModel = kLineModels[idx-1];
                        if(model.Open.floatValue > preKLineModel.Close.floatValue)
                        {
                            openPoint.y = closePointY + Y_StockChartKLineMinWidth;
                        } else {
                            closePointY = openPoint.y + Y_StockChartKLineMinWidth;
                        }
                    } else if(idx + 1 < kLineModels.count){
                        
                        //idx==0即第一个时
                        Y_KLineModel *subKLineModel = kLineModels[idx+1];
                        if(model.Close.floatValue < subKLineModel.Open.floatValue)
                        {
                            openPoint.y = closePointY + Y_StockChartKLineMinWidth;
                        } else {
                            closePointY = openPoint.y + Y_StockChartKLineMinWidth;
                        }
                    }
                }
            }
            
            CGPoint closePoint = CGPointMake(xPosition, closePointY);
            CGPoint highPoint = CGPointMake(xPosition, ABS(maxY - (model.High.floatValue - minValue)/unitValue));
            CGPoint lowPoint = CGPointMake(xPosition, ABS(maxY - (model.Low.floatValue - minValue)/unitValue));
            kLinePositionModel.OpenPoint = openPoint;
            kLinePositionModel.ClosePoint = closePoint;
            kLinePositionModel.HighPoint = highPoint;
            kLinePositionModel.LowPoint = lowPoint;
        }];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(kLineAccessoryViewCurrentMaxValue:minValue:)])
    {
        [self.delegate kLineAccessoryViewCurrentMaxValue:maxValue minValue:minValue];
    }
    return volumePositionModels;
}


@end
