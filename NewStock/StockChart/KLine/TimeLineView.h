//
//  TimeLineView.h
//
//

#import <UIKit/UIKit.h>
#import "Y_KLineModel.h"
#import "Y_StockChartConstant.h"
@interface TimeLineView : UIView

/**
 *  第一个View的高所占比例
 */
@property (nonatomic, assign) CGFloat mainViewRatio;

/**
 *  第二个View(成交量)的高所占比例
 */
@property (nonatomic, assign) CGFloat volumeViewRatio;

/**
 *  数据
 */
@property(nonatomic, copy) NSArray<Y_KLineModel *> *kLineModels;

/**
 *  重绘
 */
- (void)reDraw;


/**
 *  线类型
 */
@property (nonatomic, assign) Y_StockTimeLineType timeLineType;


/**
 *  显示股票类型：股票、指数
 */
@property (nonatomic, assign) Y_StockType currentStockType;

@end
