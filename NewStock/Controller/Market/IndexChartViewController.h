//
//  IndexChartViewController.h
//  NewStock
//
//  Created by Willey on 16/8/8.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "IndexInfoModel.h"

@interface IndexChartViewController : BaseViewController<UIScrollViewDelegate,UITableViewDelegate,UIWebViewDelegate>
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
@property (nonatomic, strong) IndexInfoModel *indexModel;

@end
