//
//  Y-StockChartView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_StockChartView.h"
#import "TimeLineView.h"
#import "Y_KLineView.h"

#import "Masonry.h"
#import "Y_StockChartSegmentView.h"
#import "HMSegmentedControl.h"
#import "Y_StockChartGlobalVariable.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Y_StockChart.h"
#import "MarketConfig.h"
#import "Defination.h"
#import "AppDelegate.h"

@interface Y_StockChartView() <Y_StockChartSegmentViewDelegate>

/**
 *  走势图View
 */
@property (nonatomic, strong) TimeLineView *timeLineView;

/**
 *  K线图View
 */
@property (nonatomic, strong) Y_KLineView *kLineView;

/**
 *  底部选择View
 */
@property (nonatomic, strong) Y_StockChartSegmentView *segmentView;

/**
 *  图表类型
 */
@property(nonatomic,assign) Y_StockChartCenterViewType currentCenterViewType;

/**
 *  当前索引
 */
@property(nonatomic,assign,readwrite) NSInteger currentIndex;

@end


@implementation Y_StockChartView

- (TimeLineView *)timeLineView {
    if(!_timeLineView) {
        _timeLineView = [TimeLineView new];
        _timeLineView.layer.borderWidth = 0.5;
        _timeLineView.layer.borderColor = SEP_BG_COLOR.CGColor;//[[UIColor boarderColor] CGColor];
        
        [self addSubview:_timeLineView];

        if (self.currentStockType == Y_StockType_AStock) {
            [_timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.bottom.right.left.equalTo(self);
                make.bottom.left.equalTo(self);
                make.top.equalTo(self.segmentView.mas_bottom);
                //make.width.mas_equalTo(self.segmentView.mas_width).multipliedBy(1-[Y_StockChartGlobalVariable fifthPosViewRadio]);
                make.width.mas_equalTo(MAIN_SCREEN_WIDTH - [Y_StockChartGlobalVariable fifthPosViewWidth]);
            }];
        } else {
            [_timeLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.left.equalTo(self);
                make.width.mas_equalTo(self.segmentView.mas_width);//(self.frame.size.width)
                make.top.equalTo(self.segmentView.mas_bottom);
            }];
        }
        
    }
    return _timeLineView;
}

- (Y_KLineView *)kLineView {
    if(!_kLineView) {
        _kLineView = [Y_KLineView new];
        _kLineView.layer.borderWidth = 0.5;
        _kLineView.layer.borderColor = SEP_BG_COLOR.CGColor;//[[UIColor boarderColor] CGColor];
        [self addSubview:_kLineView];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.isEable == YES) {
            [_kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.left.equalTo(self);
                make.right.equalTo(self).offset(-60);
                make.top.equalTo(self.segmentView.mas_bottom);
            }];
        } else {
            [_kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.right.left.equalTo(self);
                make.top.equalTo(self.segmentView.mas_bottom);
            }];
        }
    }
    return _kLineView;
}

- (void)showKLineAccessoryView:(BOOL)b {
    [_kLineView showKLineAccessoryView:b];
}

- (Y_StockChartSegmentView *)segmentView {
    if(!_segmentView) {
        _segmentView = [Y_StockChartSegmentView new];
        _segmentView.backgroundColor = kUIColorFromRGB(0xffffff);
        _segmentView.layer.borderWidth = 0.5;
        _segmentView.layer.borderColor = kUIColorFromRGB(0xe6e6e6).CGColor;//SEP_BG_COLOR.CGColor;
        
        _segmentView.delegate = self;
        [self addSubview:_segmentView];
        [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.equalTo(self);
            make.height.equalTo(@(40 * kScale));//@25
        }];
    }
    return _segmentView;
}

- (void)setItemModels:(NSArray *)itemModels {
    _itemModels = itemModels;
    if(itemModels) {
        NSMutableArray *items = [NSMutableArray array];
        for(Y_StockChartViewItemModel *item in itemModels) {
            [items addObject:item.title];
        }
        self.segmentView.items = items;
        Y_StockChartViewItemModel *firstModel = itemModels.firstObject;
        self.currentCenterViewType = firstModel.centerViewType;
    }
    if(self.dataSource) {
        self.segmentView.selectedIndex = 0;
    }
}

- (void)setDataSource:(id<Y_StockChartViewDataSource>)dataSource {
    _dataSource = dataSource;
    if(self.itemModels) {
        self.segmentView.selectedIndex = 0;
    }
}

- (void)setCurrentStockType:(Y_StockType)currentStockType {
    _currentStockType = currentStockType;
    _timeLineView.currentStockType = currentStockType;
}

- (void)setAccessoryViewIndex:(NSInteger) index {
    if (index == 1) {
        NSLog(@"MACD");
        _kLineView.targetLineStatus = Y_StockChartTargetLineStatusMACD;
    } else if (index == 2) {
        NSLog(@"KDJ");
        _kLineView.targetLineStatus = Y_StockChartTargetLineStatusKDJ;
    } else if (index == 3) {
        NSLog(@"RSI");
        _kLineView.targetLineStatus = Y_StockChartTargetLineStatusRSI;
    } else if (index == 4) {
        NSLog(@"BOLL");
        _kLineView.targetLineStatus = Y_StockChartTargetLineStatusBOLL;
    }
    
}

- (void)reloadData {
    
    //self.segmentView.selectedIndex = self.segmentView.selectedIndex;
    
    [self.segmentView reloadData];
}

#pragma mark - 代理方法

- (void)y_StockChartSegmentView:(Y_StockChartSegmentView *)segmentView clickSegmentButtonIndex:(NSInteger)index {
    self.currentIndex = index;
    
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(stockDatasWithIndex:)]) {
        id stockData = [self.dataSource stockDatasWithIndex:index];
        
//        if(!stockData)
//        {
//            return;
//        }
        
        Y_StockChartCenterViewType type = Y_StockChartcenterViewTypeKline;
        
        if (index < [self.itemModels count]) {
            Y_StockChartViewItemModel *itemModel = self.itemModels[index];
            type = itemModel.centerViewType;
        }
        
        if(index == 0) {
            if (self.currentStockType == Y_StockType_AStock) {
                [_timeLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.left.equalTo(self);
                    make.top.equalTo(self.segmentView.mas_bottom);
                    //make.width.mas_equalTo(self.segmentView.mas_width).multipliedBy(1-[Y_StockChartGlobalVariable fifthPosViewRadio]);
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH - [Y_StockChartGlobalVariable fifthPosViewWidth]);

                }];
                [_timeLineView layoutIfNeeded];//
            } else {
                [_timeLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self);
                    make.left.equalTo(self);
                    make.top.equalTo(self.segmentView.mas_bottom);
                    make.width.mas_equalTo(self.segmentView.mas_width);//(self.frame.size.width)
                }];
                [_timeLineView layoutIfNeeded];//
            }
            
            
            self.timeLineView.kLineModels = (NSArray *)stockData;
            self.timeLineView.timeLineType = Y_StockTimeLine_OneDay;
            self.timeLineView.hidden = NO;
            self.kLineView.hidden = YES;
            
            //if(stockData)[self.timeLineView reDraw];
            [self.timeLineView reDraw];
        } else if(index == 1) {
            if (self.currentStockType == Y_StockType_AStock) {
                [_timeLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.left.equalTo(self);
                    make.width.mas_equalTo(self.segmentView.mas_width);//(self.frame.size.width)
                    make.top.equalTo(self.segmentView.mas_bottom);
                }];
                [_timeLineView layoutIfNeeded];
            }
            
            self.timeLineView.kLineModels = (NSArray *)stockData;
            self.timeLineView.timeLineType = Y_StockTimeLine_FiveDay;
            self.timeLineView.hidden = NO;
            self.kLineView.hidden = YES;
            if(stockData)[self.timeLineView reDraw];
        } else {
            self.kLineView.kLineModels = (NSArray *)stockData;
            
            
            /*
             Y_StockKLineType_OneDay= 1, //
             Y_StockKLineType_Week,  //
             Y_StockKLineType_Month,
             Y_StockKLineType_1Min,
             Y_StockKLineType_5Min,
             Y_StockKLineType_15Min,
             Y_StockKLineType_30Min,
             Y_StockKLineType_60Min
             */
            if (index == 5) {
                self.kLineView.kLineType = Y_StockKLineType_1Min;
            }
            else if (index == 6) {
                self.kLineView.kLineType = Y_StockKLineType_5Min;
            }
            else if (index == 7) {
                self.kLineView.kLineType = Y_StockKLineType_15Min;
            }
            else if (index == 8) {
                self.kLineView.kLineType = Y_StockKLineType_30Min;
            }
            else if (index == 9) {
                self.kLineView.kLineType = Y_StockKLineType_60Min;
            }
            else
            {
                self.kLineView.kLineType = Y_StockKLineType_OneDay;
            }

            self.kLineView.MainViewType = type;
            self.timeLineView.hidden = YES;
            self.kLineView.hidden = NO;
            if(stockData)[self.kLineView reDraw];
        }
        
        
    }

}

@end

/************************ItemModel类************************/
@implementation Y_StockChartViewItemModel

+ (instancetype)itemModelWithTitle:(NSString *)title type:(Y_StockChartCenterViewType)type {
    Y_StockChartViewItemModel *itemModel = [Y_StockChartViewItemModel new];
    itemModel.title = title;
    itemModel.centerViewType = type;
    return itemModel;
}

@end
