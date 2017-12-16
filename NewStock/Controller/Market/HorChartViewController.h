//
//  HorChartViewController.h
//  NewStock
//
//  Created by Willey on 16/11/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "StockListModel.h"
#import "Y_KLineGroupModel.h"
#import "Y_StockChartConstant.h"

@interface HorChartViewController : BaseViewController
{
    NSTimer *_myTimer;

}

@property (nonatomic, strong) StockListModel *stockListModel;
@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;

@property (nonatomic, assign) Y_StockType currentStockType;

@end
