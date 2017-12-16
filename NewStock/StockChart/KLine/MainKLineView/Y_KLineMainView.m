//
//  Y_KLineMainView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineMainView.h"
#import "UIColor+Y_StockChart.h"

#import "Y_KLine.h"
#import "Y_MALine.h"
#import "Y_KLinePositionModel.h"
#import "Y_StockChartGlobalVariable.h"
#import "Masonry.h"
#import "Defination.h"

@interface Y_KLineMainView()

/**
 *  需要绘制的model数组
 */
@property (nonatomic, strong) NSMutableArray <Y_KLineModel *> *needDrawKLineModels;

/**
 *  需要绘制的model位置数组
 */
@property (nonatomic, strong) NSMutableArray *needDrawKLinePositionModels;


/**
 *  Index开始X的值
 */
@property (nonatomic, assign) NSInteger startXPosition;

/**
 *  旧的contentoffset值
 */
@property (nonatomic, assign) CGFloat oldContentOffsetX;

/**
 *  旧的缩放值
 */
@property (nonatomic, assign) CGFloat oldScale;

/**
 *  均线位置数组
 */
@property (nonatomic, strong) NSMutableArray *AverPositions;

/**
 *  MA7位置数组
 */
@property (nonatomic, strong) NSMutableArray *MA7Positions;

@property (nonatomic, strong) NSMutableArray *MA12Positions;

@property (nonatomic, strong) NSMutableArray *MA26Positions;


/**
 *  MA30位置数组
 */
@property (nonatomic, strong) NSMutableArray *MA30Positions;

@end

@implementation Y_KLineMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.needDrawKLineModels = @[].mutableCopy;
        self.needDrawKLinePositionModels = @[].mutableCopy;
        self.AverPositions = @[].mutableCopy;
        self.MA7Positions = @[].mutableCopy;
        self.MA12Positions = @[].mutableCopy;
        self.MA26Positions = @[].mutableCopy;
        self.MA30Positions = @[].mutableCopy;
        _needDrawStartIndex = 0;
        self.oldContentOffsetX = 0;
        self.oldScale = 0;
        
        
    }
    return self;
}

#pragma mark - 绘图相关方法

#pragma mark drawRect方法
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //如果数组为空，则不进行绘制，直接设置本view为背景
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(!self.kLineModels)
    {
        CGContextClearRect(context, rect);
        CGContextSetFillColorWithColor(context, [UIColor backgroundColor].CGColor);
        CGContextFillRect(context, rect);
        return;
    }
    
    //设置View的背景颜色
    NSMutableArray *kLineColors = @[].mutableCopy;
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor backgroundColor].CGColor);
    CGContextFillRect(context, rect);
    
    //设置显示日期的区域背景颜色
    CGContextSetFillColorWithColor(context, [UIColor assistBackgroundColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, Y_StockChartKLineMainViewMaxY, self.frame.size.width, self.frame.size.height - Y_StockChartKLineMainViewMaxY));
    
    
    //边框
    CGContextStrokeRect(context,CGRectMake(100, 120, 10, 10));//画方框
    CGContextSetLineWidth(context, 0.5);//线的宽度
    CGContextSetStrokeColorWithColor(context, [kUIColorFromRGB(0xd3d3d3) CGColor]);//线框颜色
    CGContextAddRect(context,CGRectMake(0, 0, self.frame.size.width, Y_StockChartKLineMainViewMaxY));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
    
    
    
    //横线
    CGContextSetLineWidth(context, 0.3);
    CGContextSetStrokeColorWithColor(context, [UIColor dividingColor].CGColor);//线框颜色
//    CGFloat lengths[] = {4,2};//先画4个点再画2个点
//    CGContextSetLineDash(context,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    CGContextMoveToPoint(context, 0, Y_StockChartKLineMainViewMaxY/2);
    CGContextAddLineToPoint(context, self.frame.size.width, Y_StockChartKLineMainViewMaxY/2);
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
//    CGFloat lengths2[] = {4,0};//先画4个点再画2个点
//    CGContextSetLineDash(context,0, lengths2,2);//注意2(count)的值等于lengths数组的长度
    
    
    
    
    Y_MALine *MALine = [[Y_MALine alloc]initWithContext:context];
    MALine.maxY = Y_StockChartKLineMainViewMaxY;


    if(self.MainViewType == Y_StockChartcenterViewTypeKline)
    {
        Y_KLine *kLine = [[Y_KLine alloc]initWithContext:context];
        kLine.maxY = Y_StockChartKLineMainViewMaxY;

        __block CGPoint lastDrawDatePoint = CGPointZero;
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull kLinePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            kLine.kLinePositionModel = kLinePositionModel;
            kLine.kLineModel = self.needDrawKLineModels[idx];
            UIColor *kLineColor = [kLine draw];
            [kLineColors addObject:kLineColor];

            //日期
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.needDrawKLineModels[idx].Date.doubleValue/1000];
            NSDateFormatter *formatter = [NSDateFormatter new];
            
            if (self.kLineType == Y_StockKLineType_1Min)
            {
                formatter.dateFormat = @"hh:mm";
            }
            else if (self.kLineType == Y_StockKLineType_5Min
                || self.kLineType == Y_StockKLineType_15Min
                || self.kLineType == Y_StockKLineType_30Min
                || self.kLineType == Y_StockKLineType_60Min)
            {
                formatter.dateFormat = @"MM-dd";
            }
            else
            {
                formatter.dateFormat = @"yyyy-MM";
            }
            NSString *dateStr = [formatter stringFromDate:date];
            NSString *lastDateStr = dateStr;
            if (idx>0)
            {
                NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:self.needDrawKLineModels[idx-1].Date.doubleValue/1000];
                lastDateStr = [formatter stringFromDate:lastDate];
            }
            CGPoint drawDatePoint = CGPointMake(kLine.kLinePositionModel.LowPoint.x, Y_StockChartKLineMainViewMaxY + 1.5);
            //CGPoint lastDrawDatePoint;
            
            if (self.kLineType == Y_StockKLineType_1Min)
            {
                long fifty_min = 30*60*1000;//30分钟
                
                long longDate = (long)self.needDrawKLineModels[idx].Date.longLongValue;

                if ((longDate % fifty_min) == 0 && drawDatePoint.x - lastDrawDatePoint.x > 100)//
                {
                    [dateStr drawAtPoint:CGPointMake(drawDatePoint.x-23, drawDatePoint.y) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : kUIColorFromRGB(0x666666)}];//[UIColor assistTextColor]
                    lastDateStr = dateStr;
                    lastDrawDatePoint = drawDatePoint;
                    
                    CGContextSetLineWidth(context, 0.3);
                    CGContextSetStrokeColorWithColor(context, [UIColor dividingColor].CGColor);//线框颜色
                    
                    CGContextMoveToPoint(context, drawDatePoint.x, 0);
                    CGContextAddLineToPoint(context, drawDatePoint.x, Y_StockChartKLineMainViewMaxY);
                    
                    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
                }
            }
            else
            {
                if((![dateStr isEqualToString:lastDateStr]) && drawDatePoint.x - lastDrawDatePoint.x > 100)
                {
                    [dateStr drawAtPoint:CGPointMake(drawDatePoint.x-23, drawDatePoint.y) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : kUIColorFromRGB(0x666666)}];//[UIColor assistTextColor]
                    lastDateStr = dateStr;
                    lastDrawDatePoint = drawDatePoint;
                    
                    CGContextSetLineWidth(context, 0.3);
                    CGContextSetStrokeColorWithColor(context, [UIColor dividingColor].CGColor);//线框颜色
                    
                    CGContextMoveToPoint(context, drawDatePoint.x, 0);
                    CGContextAddLineToPoint(context, drawDatePoint.x, Y_StockChartKLineMainViewMaxY);
                    
                    //                CGContextMoveToPoint(context, 0, Y_StockChartKLineMainViewMaxY/2);
                    //                CGContextAddLineToPoint(context, self.frame.size.width, Y_StockChartKLineMainViewMaxY/2);
                    
                    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
                }
                
            }
            
            
        }];
    } else {
        NSMutableArray *positions = @[].mutableCopy;
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull positionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            UIColor *strokeColor = positionModel.OpenPoint.y < positionModel.ClosePoint.y ? [UIColor increaseColor] : [UIColor decreaseColor];
            [kLineColors addObject:strokeColor];
            [positions addObject:[NSValue valueWithCGPoint:positionModel.ClosePoint]];
        }];
        MALine.MAPositions = positions;
        MALine.MAType = -1;
        CGFloat maxY = self.parentScrollView.frame.size.height * [Y_StockChartGlobalVariable kLineMainViewRadio] - 12;
        [MALine drawMiniWithOriginalY:maxY];
//        
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull positionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGPoint point = [positions[idx] CGPointValue];
            
            //日期
            
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.needDrawKLineModels[idx].Date.doubleValue/1000];
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"MM-dd";
            NSString *dateStr = [formatter stringFromDate:date];
 
            CGPoint drawDatePoint = CGPointMake(point.x + 1, Y_StockChartKLineMainViewMaxY + 1.5);
            CGPoint lastDrawDatePoint = CGPointZero;
            if(CGPointEqualToPoint(lastDrawDatePoint, CGPointZero) || point.x - lastDrawDatePoint.x > 60 )
            {
                [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor assistTextColor]}];
                lastDrawDatePoint = drawDatePoint;
            }
        }];
        
        
        //画MA7线
        MALine.MAType = Y_AverType;
        MALine.MAPositions = self.AverPositions;
        [MALine draw];
    }
    
    if(self.targetLineStatus != Y_StockChartTargetLineStatusCloseMA) {
        

        //画MA7线
        MALine.MAType = Y_MA7Type;
        MALine.MAPositions = self.MA7Positions;
        [MALine draw];
        
        MALine.MAType = Y_MA12Type;
        MALine.MAPositions = self.MA12Positions;
        [MALine draw];

        MALine.MAType = Y_MA26Type;
        MALine.MAPositions = self.MA26Positions;
        [MALine draw];

        //画MA30线
        MALine.MAType = Y_MA30Type;
        MALine.MAPositions = self.MA30Positions;
        [MALine draw];
        
        
    }

    
    if(self.delegate && kLineColors.count > 0)
    {
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLineColors:)])
        {
            [self.delegate kLineMainViewCurrentNeedDrawKLineColors:kLineColors];
        }
    }
}

#pragma mark - 公有方法
- (void)resetMainView
{
    self.kLineModels = nil;
    [self setNeedsDisplay];
    
}

#pragma mark 重新设置相关数据，然后重绘
- (void)drawMainView
{
    if(self.kLineModels)
    {
        NSAssert(self.kLineModels, @"kLineModels不能为空");
        
        //提取需要的kLineModel
        [self private_extractNeedDrawModels];
        //转换model为坐标model
        [self private_convertToKLinePositionModelWithKLineModels];
        
        //间接调用drawRect方法
        [self setNeedsDisplay];
    }
    
}

/**
 *  更新MainView的宽度
 */
- (void)updateMainViewWidth
{
    //根据stockModels的个数和间隔和K线的宽度计算出self的宽度，并设置contentsize
    //CGFloat kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap] + 10;
    CGFloat kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap];
    
    float scale = 0.0;
    if(self.parentScrollView.contentSize.width>0)scale = kLineViewWidth /self.parentScrollView.contentSize.width;
    
    
    if(kLineViewWidth < self.parentScrollView.bounds.size.width) {
        kLineViewWidth = self.parentScrollView.bounds.size.width;
    }
//    if (kLineViewWidth < [UIScreen mainScreen].bounds.size.width) {
//        kLineViewWidth = [UIScreen mainScreen].bounds.size.width;
//    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kLineViewWidth));
    }];

    [self layoutIfNeeded];
    
    //更新scrollview的contentsize
    self.parentScrollView.contentSize = CGSizeMake(kLineViewWidth, self.parentScrollView.contentSize.height);
//    CGFloat offset = self.parentScrollView.contentSize.width - self.parentScrollView.bounds.size.width;
//    if (offset > 0)
//    {
//        NSLog(@"计算出来的位移%f",offset);
//        [self.parentScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
//    }
//    else {
//        NSLog(@"计算出来的位移%f",offset);
//        [self.parentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
    
    
    
    
    if (scale>0)
    {
        CGFloat offset = self.parentScrollView.contentOffset.x * scale;

        self.parentScrollView.contentOffset = CGPointMake(offset, 0);
    }
    
    
    
//    CGFloat offsetX = _needDrawStartIndex * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap];// + 10;
//    
//    CGFloat offset = offsetX - self.parentScrollView.frame.size.width;
//    
//    NSLog(@"~~~~~~~scrollViewOffsetX:%f",offset);
//
//    if (offset > 0)
//    {
//        self.parentScrollView.contentOffset = CGPointMake(offset, 0);
//    } else {
//        //self.parentScrollView.contentOffset = CGPointMake(0, 0);
//    }
    

}

/**
 *  长按的时候根据原始的x位置获得精确的x的位置
 */
- (CGFloat)getExactXPositionWithOriginXPosition:(CGFloat)originXPosition
{
    CGFloat xPositoinInMainView = originXPosition;
    NSInteger startIndex = (NSInteger)((xPositoinInMainView - self.startXPosition) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]));
    NSInteger arrCount = self.needDrawKLinePositionModels.count;
    for (NSInteger index = startIndex > 0 ? startIndex - 1 : 0; index < arrCount; ++index) {
        Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[index];
        
        CGFloat minX = kLinePositionModel.HighPoint.x - ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]/2);
        CGFloat maxX = kLinePositionModel.HighPoint.x + ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]/2);
        
        if(xPositoinInMainView > minX && xPositoinInMainView < maxX)
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewLongPressKLinePositionModel:kLineModel:)])
            {
                [self.delegate kLineMainViewLongPressKLinePositionModel:self.needDrawKLinePositionModels[index] kLineModel:self.needDrawKLineModels[index]];
            }
            return kLinePositionModel.HighPoint.x;
        }
        

    }
    if (startIndex>arrCount)
    {
        Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[arrCount-1];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewLongPressKLinePositionModel:kLineModel:)])
        {
            [self.delegate kLineMainViewLongPressKLinePositionModel:self.needDrawKLinePositionModels[arrCount-1] kLineModel:self.needDrawKLineModels[arrCount-1]];
        }
        
        return kLinePositionModel.HighPoint.x;
    }
    return 0.f;
}

/**
 *  长按的时候根据原始的y位置获得精确的y的位置
 */
- (CGFloat)getExactYPositionWithOriginYPosition:(CGFloat)originXPosition
{
    CGFloat xPositoinInMainView = originXPosition;
    NSInteger startIndex = (NSInteger)((xPositoinInMainView - self.startXPosition) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]));
    NSInteger arrCount = self.needDrawKLinePositionModels.count;
    for (NSInteger index = startIndex > 0 ? startIndex - 1 : 0; index < arrCount; ++index) {
        Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[index];
        
        CGFloat minX = kLinePositionModel.HighPoint.x - ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]/2);
        CGFloat maxX = kLinePositionModel.HighPoint.x + ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]/2);
        
        if(xPositoinInMainView > minX && xPositoinInMainView < maxX)
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewLongPressKLinePositionModel:kLineModel:)])
            {
                //[self.delegate kLineMainViewLongPressKLinePositionModel:self.needDrawKLinePositionModels[index] kLineModel:self.needDrawKLineModels[index]];
            }
            //return kLinePositionModel.HighPoint.y;
            return kLinePositionModel.ClosePoint.y;
        }
        
    }
    if (startIndex>arrCount)
    {
        Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[arrCount-1];
        //return kLinePositionModel.HighPoint.y;
        return kLinePositionModel.ClosePoint.y;
    }
    return 0.f;
}


#pragma mark 私有方法
//提取需要绘制的数组
- (NSArray *)private_extractNeedDrawModels
{
    
    
    //数组个数
    CGFloat scrollViewWidth = self.parentScrollView.frame.size.width;
    
    
    CGFloat lineGap = [Y_StockChartGlobalVariable kLineGap];
    CGFloat lineWidth = [Y_StockChartGlobalVariable kLineWidth];
    NSInteger needDrawKLineCount = 1+(scrollViewWidth - lineGap)/(lineGap+lineWidth);//+1
    
    //起始位置
    NSInteger needDrawKLineStartIndex ;
    
    if(self.pinchStartIndex > 0) {
        needDrawKLineStartIndex = self.pinchStartIndex;
        _needDrawStartIndex = self.pinchStartIndex;
        self.pinchStartIndex = -1;
    } else {
       needDrawKLineStartIndex = self.needDrawStartIndex;
    }
    
    
//    NSLog(@"这是模型开始的index-----------%lu",needDrawKLineStartIndex);
    [self.needDrawKLineModels removeAllObjects];
    
    //赋值数组
    if(needDrawKLineStartIndex < self.kLineModels.count)
    {
        if(needDrawKLineStartIndex + needDrawKLineCount < self.kLineModels.count)
        {
            [self.needDrawKLineModels addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, needDrawKLineCount+1)]];
        } else{
            [self.needDrawKLineModels addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, self.kLineModels.count - needDrawKLineStartIndex)]];
        }
    }
    
    
    
    
    //响应代理
    if(self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLineModels:)])
    {
        [self.delegate kLineMainViewCurrentNeedDrawKLineModels:self.needDrawKLineModels];
    }
    return self.needDrawKLineModels;
}

#pragma mark 将model转化为Position模型
- (NSArray *)private_convertToKLinePositionModelWithKLineModels
{
    if(!self.needDrawKLineModels)
    {
        return nil;
    }
    
    NSArray *kLineModels = self.needDrawKLineModels;
    
    //计算最小单位
    Y_KLineModel *firstModel = kLineModels.firstObject;
    __block CGFloat minAssert = firstModel.Low.floatValue;
    __block CGFloat maxAssert = firstModel.High.floatValue;
//    __block CGFloat minMA7 = CGFLOAT_MAX;
//    __block CGFloat maxMA7 = CGFLOAT_MIN;
//    __block CGFloat minMA30 = CGFLOAT_MAX;
//    __block CGFloat maxMA30 = CGFLOAT_MIN;
    
    [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel * _Nonnull kLineModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if(kLineModel.High.floatValue > maxAssert)
        {
            maxAssert = kLineModel.High.floatValue;
        }
        if(kLineModel.Low.floatValue < minAssert)
        {
            minAssert = kLineModel.Low.floatValue;
        }
//        if(kLineModel.MA7)
//        {
//            if (minAssert > kLineModel.MA7.floatValue) {
//                minAssert = kLineModel.MA7.floatValue;
//            }
//            if (maxAssert < kLineModel.MA7.floatValue) {
//                maxAssert = kLineModel.MA7.floatValue;
//            }
//        }
//        if(kLineModel.MA30)
//        {
//            if (minAssert > kLineModel.MA30.floatValue) {
//                minAssert = kLineModel.MA30.floatValue;
//            }
//            if (maxAssert < kLineModel.MA30.floatValue) {
//                maxAssert = kLineModel.MA30.floatValue;
//            }
//        }
//        if(kLineModel.AverPrice)
//        {
//            if (minAssert > kLineModel.AverPrice.floatValue) {
//                minAssert = kLineModel.AverPrice.floatValue;
//            }
//            if (maxAssert < kLineModel.AverPrice.floatValue) {
//                maxAssert = kLineModel.AverPrice.floatValue;
//            }
//        }
    }];
    
    
    
//    maxAssert *= 1.0001;
//    minAssert *= 0.9991;
    
    if (self.kLineType == Y_StockKLineType_1Min
        || self.kLineType == Y_StockKLineType_5Min
        || self.kLineType == Y_StockKLineType_15Min
        || self.kLineType == Y_StockKLineType_30Min
        || self.kLineType == Y_StockKLineType_60Min)
    {
        maxAssert *= 1.001;
        minAssert *= 0.999;
    }
    else
    {
        maxAssert *= 1.01;
        minAssert *= 0.99;
    }
    
    
    
    CGFloat minY = Y_StockChartKLineMainViewMinY;
    CGFloat maxY = self.parentScrollView.frame.size.height * [Y_StockChartGlobalVariable kLineMainViewRadio] - 15;
//    CGFloat rectWidth = self.frame.size.width;
    
    CGFloat unitValue = (maxAssert - minAssert)/(maxY - minY);
//    CGFloat ma7UnitValue = (maxMA7 - minMA7) / (maxY - minY);
//    CGFloat ma30UnitValue = (maxMA30 - minMA30) / (maxY - minY);
    
    
    
    
    [self.needDrawKLinePositionModels removeAllObjects];
    [self.AverPositions removeAllObjects];
    [self.MA7Positions removeAllObjects];
    [self.MA12Positions removeAllObjects];
    [self.MA26Positions removeAllObjects];
    [self.MA30Positions removeAllObjects];
    
    NSInteger kLineModelsCount = kLineModels.count;
    
    //CGFloat idxWidth = rectWidth/kLineModelsCount;

    
    for (NSInteger idx = 0 ; idx < kLineModelsCount; ++idx)
    {
        //K线坐标转换
        Y_KLineModel *kLineModel = kLineModels[idx];
        
        //CGFloat xPosition = self.startXPosition + idx * ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]);
        CGFloat xPosition = self.startXPosition + idx * ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]);
        CGPoint openPoint = CGPointMake(xPosition, ABS(maxY - (kLineModel.Open.floatValue - minAssert)/unitValue));
        CGFloat closePointY = ABS(maxY - (kLineModel.Close.floatValue - minAssert)/unitValue);
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
                    if(kLineModel.Open.floatValue > preKLineModel.Close.floatValue)
                    {
                        openPoint.y = closePointY + Y_StockChartKLineMinWidth;
                    } else {
                        closePointY = openPoint.y + Y_StockChartKLineMinWidth;
                    }
                } else if(idx+1 < kLineModelsCount){
                    
                    //idx==0即第一个时
                    Y_KLineModel *subKLineModel = kLineModels[idx+1];
                    if(kLineModel.Close.floatValue < subKLineModel.Open.floatValue)
                    {
                        openPoint.y = closePointY + Y_StockChartKLineMinWidth;
                    } else {
                        closePointY = openPoint.y + Y_StockChartKLineMinWidth;
                    }
                }
            }
        }
        
        CGPoint closePoint = CGPointMake(xPosition, closePointY);
        CGPoint highPoint = CGPointMake(xPosition, ABS(maxY - (kLineModel.High.floatValue - minAssert)/unitValue));
        CGPoint lowPoint = CGPointMake(xPosition, ABS(maxY - (kLineModel.Low.floatValue - minAssert)/unitValue));
        
        Y_KLinePositionModel *kLinePositionModel = [Y_KLinePositionModel modelWithOpen:openPoint close:closePoint high:highPoint low:lowPoint];
        [self.needDrawKLinePositionModels addObject:kLinePositionModel];
         
        
        //MA坐标转换
        CGFloat ma7Y = maxY;
        CGFloat ma12Y = maxY;
        CGFloat ma26Y = maxY;
        CGFloat ma30Y = maxY;
        CGFloat averY = maxY;
        if(unitValue > 0.0000001)
        {
            if(kLineModel.MA7)
            {
                ma7Y = maxY - (kLineModel.MA7.floatValue - minAssert)/unitValue;
            }

        }
        if(unitValue > 0.0000001)
        {
            if(kLineModel.MA12)
            {
                ma12Y = maxY - (kLineModel.MA12.floatValue - minAssert)/unitValue;
            }
            
        }
        if(unitValue > 0.0000001)
        {
            if(kLineModel.MA26)
            {
                ma26Y = maxY - (kLineModel.MA26.floatValue - minAssert)/unitValue;
            }
            
        }
        if(unitValue > 0.0000001)
        {
            if(kLineModel.MA30)
            {
                ma30Y = maxY - (kLineModel.MA30.floatValue - minAssert)/unitValue;
            }
        }
        if(unitValue > 0.0000001)
        {
            if(kLineModel.AverPrice)
            {
                averY = maxY - (kLineModel.AverPrice.floatValue - minAssert)/unitValue;
            }
        }
        
        NSAssert(!isnan(ma7Y) && !isnan(ma30Y)&&!isnan(averY), @"出现NAN值");
        
        CGPoint ma7Point = CGPointMake(xPosition, ma7Y);
        CGPoint ma12Point = CGPointMake(xPosition, ma12Y);
        CGPoint ma26Point = CGPointMake(xPosition, ma26Y);
        CGPoint ma30Point = CGPointMake(xPosition, ma30Y);
        CGPoint averPoint = CGPointMake(xPosition, averY);
        
        if(kLineModel.MA7)
        {
            [self.MA7Positions addObject: [NSValue valueWithCGPoint: ma7Point]];
        }
        if(kLineModel.MA12)
        {
            [self.MA12Positions addObject: [NSValue valueWithCGPoint: ma12Point]];
        }
        if(kLineModel.MA26)
        {
            [self.MA26Positions addObject: [NSValue valueWithCGPoint: ma26Point]];
        }
        if(kLineModel.MA30)
        {
            [self.MA30Positions addObject: [NSValue valueWithCGPoint: ma30Point]];
        }
        if(kLineModel.AverPrice)
        {
            [self.AverPositions addObject:[NSValue valueWithCGPoint: averPoint]];
        }
    }
    
    //响应代理方法
    if(self.delegate)
    {
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentMaxPrice:minPrice:)])
        {
            [self.delegate kLineMainViewCurrentMaxPrice:maxAssert minPrice:minAssert];
        }
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLinePositionModels:)])
        {
            [self.delegate kLineMainViewCurrentNeedDrawKLinePositionModels:self.needDrawKLinePositionModels];
        }
    }
    return self.needDrawKLinePositionModels;
}

static char *observerContext = NULL;
#pragma mark 添加所有事件监听的方法
- (void)private_addAllEventListener
{
    //KVO监听scrollview的状态变化
    [_parentScrollView addObserver:self forKeyPath:Y_StockChartContentOffsetKey options:NSKeyValueObservingOptionNew context:observerContext];
}
#pragma mark - setter,getter方法
- (NSInteger)startXPosition
{
    NSInteger leftArrCount = self.needDrawStartIndex;
    CGFloat startXPosition = (leftArrCount + 1) * [Y_StockChartGlobalVariable kLineGap] + leftArrCount * [Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineWidth]/2;
    return startXPosition;
}

- (NSInteger)needDrawStartIndex
{
    
   // if (_needDrawStartIndex == 0)
    {
        CGFloat scrollViewOffsetX = self.parentScrollView.contentOffset.x < 0 ? 0 : self.parentScrollView.contentOffset.x;
        

        NSUInteger leftArrCount = ABS(scrollViewOffsetX - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
        _needDrawStartIndex = leftArrCount;
        return _needDrawStartIndex;

    }
//    else
//    {
//        CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
//        CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
//        CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
//        NSUInteger oldLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + oldKLineWidth);
//        NSUInteger newLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
//        
//        NSLog(@"----centerPoint x:%lf y:%lf",centerPoint.x, centerPoint.y);
//        NSLog(@"----self.scrollView.contentOffset.x:%lf",self.scrollView.contentOffset.x);
//        
//        NSLog(@"----oldNeedDrawStartIndex:%ld",oldNeedDrawStartIndex);
//        NSLog(@"----oldLeftArrCount:%ld",oldLeftArrCount);
//        NSLog(@"----newLeftArrCount:%ld",newLeftArrCount);
//        self.kLineMainView.pinchStartIndex = oldNeedDrawStartIndex + oldLeftArrCount - newLeftArrCount;
//    }
}

- (void)setKLineModels:(NSArray *)kLineModels
{
    _kLineModels = kLineModels;
    
    [self updateMainViewWidth];


}

#pragma mark - 系统方法
#pragma mark 已经添加到父view的方法,设置父scrollview
- (void)didMoveToSuperview
{
    _parentScrollView = (UIScrollView *)self.superview;
    [self private_addAllEventListener];
    [super didMoveToSuperview];
}

#pragma mark KVO监听实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:Y_StockChartContentOffsetKey])
    {
        CGFloat difValue = ABS(self.parentScrollView.contentOffset.x - self.oldContentOffsetX);
        if(difValue >= [Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth])
        {
            self.oldContentOffsetX = self.parentScrollView.contentOffset.x;
            [self drawMainView];
        }
    
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 移除所有监听
- (void)removeAllObserver
{
    [_parentScrollView removeObserver:self forKeyPath:Y_StockChartContentOffsetKey context:observerContext];
}
@end
