//
//  StockChartViewController.h
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "StockListModel.h"

@interface StockChartViewController : BaseViewController<UIScrollViewDelegate,UITableViewDelegate>
{
    NSString *_commentNum;
    NSString *_fid;
    
    NSTimer *_myTimer;

    
    BOOL _bOneDay;
    BOOL _bFiveDay;
    BOOL _bDayKLine;
    BOOL _bWeekKLine;
    BOOL _bMonthKLine;
}
@property (nonatomic, strong) StockListModel *stockListModel;

@end
