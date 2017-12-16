//
//  Y_MALine.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_MALine.h"
#import "UIColor+Y_StockChart.h"
#import "Y_StockChartConstant.h"
@interface Y_MALine ()

@property (nonatomic, assign) CGContextRef context;
/**
 *  最后一个绘制日期点
 */
@property (nonatomic, assign) CGPoint lastDrawDatePoint;
@end

@implementation Y_MALine

/**
 *  根据context初始化画线
 */
- (instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if(self)
    {
        self.context = context;
    }
    return self;
}

- (void)draw
{
    if(!self.context || !self.MAPositions)
    {
        return;
    }
    
    
    UIColor *lineColor ;//= [UIColor mainTextColor];// = self.MAType == Y_MA7Type ? [UIColor ma7Color] : (self.MAType == Y_MA30Type ? [UIColor ma30Color] : [UIColor mainTextColor]);
    if(self.MAType == Y_MA7Type)lineColor=[UIColor ma7Color];
    else if(self.MAType == Y_MA12Type)lineColor=[UIColor ma12Color];
    else if(self.MAType == Y_MA26Type)lineColor=[UIColor ma26Color];
    else if(self.MAType == Y_MA30Type)lineColor=[UIColor ma30Color];
    else lineColor=[UIColor mainTextColor];
    
    if(self.MAType == Y_AverType)lineColor = [UIColor averColor];
    
    CGContextSetStrokeColorWithColor(self.context, lineColor.CGColor);
    
    CGContextSetLineWidth(self.context, Y_StockChartMALineWidth);
    
    CGPoint firstPoint = [self.MAPositions.firstObject CGPointValue];
    NSAssert(!isnan(firstPoint.x) && !isnan(firstPoint.y), @"出现NAN值：MA画线");
    CGContextMoveToPoint(self.context, firstPoint.x, firstPoint.y);
    
    for (NSInteger idx = 1; idx < self.MAPositions.count ; idx++)
    {
        CGPoint point = [self.MAPositions[idx] CGPointValue];
        
        //CGContextAddLineToPoint(self.context, point.x, point.y);

        //NSLog(@"--maxY:%lf----%lf,%lf",self.maxY,point.x,point.y);
        if (point.y < self.maxY)
        {
            CGContextAddLineToPoint(self.context, point.x, point.y);
        }
//        else
//        {
//            CGContextAddLineToPoint(self.context, point.x, self.maxY-1);
//        }

//
//
//        //日期
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.kLineModel.Date.doubleValue/1000];
//        NSDateFormatter *formatter = [NSDateFormatter new];
//        formatter.dateFormat = @"HH:mm";
//        NSString *dateStr = [formatter stringFromDate:date];
//        
//        CGPoint drawDatePoint = CGPointMake(point.x + 1, self.maxY + 1.5);
//        if(CGPointEqualToPoint(self.lastDrawDatePoint, CGPointZero) || point.x - self.lastDrawDatePoint.x > 60 )
//        {
//            [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor assistTextColor]}];
//            self.lastDrawDatePoint = drawDatePoint;
//        }
    }
//
    CGContextStrokePath(self.context);
}

- (void)drawMiniWithOriginalY:(int)orgY
{
    
    if(!self.context || !self.MAPositions)
    {
        return;
    }
    
    
    
    
    CGMutablePathRef fillPath = CGPathCreateMutable();
    
    
    
   
    
    
    
    UIColor *lineColor = [UIColor miniColor];
    
    CGContextSetStrokeColorWithColor(self.context, lineColor.CGColor);
    
    CGContextSetLineWidth(self.context, Y_StockChartMALineWidth);
    
    CGPoint firstPoint = [self.MAPositions.firstObject CGPointValue];
    //NSAssert(!isnan(firstPoint.x) && !isnan(firstPoint.y), @"出现NAN值：MA画线");
    CGContextMoveToPoint(self.context, firstPoint.x, firstPoint.y);
    
    
    int Xorg = firstPoint.x;
    int Yorg = orgY;//firstPoint.y+70;
    //绘制Path 添加第一个点
    CGPathMoveToPoint(fillPath, NULL, Xorg, Yorg);
    CGPathAddLineToPoint(fillPath, NULL, Xorg,firstPoint.y);
    CGPathAddLineToPoint(fillPath, NULL, firstPoint.x, firstPoint.y);
    
    
    
    for (NSInteger idx = 1; idx < self.MAPositions.count ; idx++)
    {
        CGPoint point = [self.MAPositions[idx] CGPointValue];
        CGContextAddLineToPoint(self.context, point.x, point.y);
        
        
        if ((self.MAPositions.count - 1) == idx) {
            CGPathAddLineToPoint(fillPath, NULL, point.x, point.y);
            CGPathAddLineToPoint(fillPath, NULL, point.x, Yorg);
            CGPathAddLineToPoint(fillPath, NULL, Xorg, Yorg);
            CGPathCloseSubpath(fillPath);
        }else{
            CGPathAddLineToPoint(fillPath, NULL, point.x, point.y);
        }
        

        
    }
    CGContextStrokePath(self.context);
    
    
    
    
    
    
    //绘制渐变
    [self drawLinearGradient:self.context path:fillPath alpha:0.5 startColor:lineColor.CGColor endColor:[UIColor whiteColor].CGColor];
    //注意释放CGMutablePathRef
    CGPathRelease(fillPath);

}


- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                     alpha:(CGFloat)alpha
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextSetAlpha(context, alpha);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}

@end

