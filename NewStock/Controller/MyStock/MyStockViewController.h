//
//  MyStockViewController.h
//  NewStock
//
//  Created by Willey on 16/8/4.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "APIListRequest.h"
#import "StockListTitleCell.h"
#import "MyStockTitle.h"
#import "NoMyStockView.h"



@interface MyStockViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,APIRequestDelegate,MyStockTitleDelegate,NoMyStockViewDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_myStockArray;
    
    NSArray * _array;
    NSMutableArray *_resultListArray;
    
    STOCK_SORT_STATE _sortState;
    NSTimer *_myTimer;
}

- (void)loadNewData;

@property (nonatomic, strong)NoMyStockView *noMyStockView;

@end
