//
//  MyStockNewsViewController.h
//  NewStock
//
//  Created by Willey on 16/8/4.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "StockNewsListAPI.h"
#import "NewsTableViewCell.h"
#import "NoMyStockView.h"


@interface MyStockNewsViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,NewsTableViewCellDelegate,NoMyStockViewDelegate,APIRequestDelegate>
{
    UITableView *_tableView;
    StockNewsListAPI *_stockNewsListAPI;
    NSMutableArray *_resultListArray;
    int _totalNum;
}

@property (nonatomic, assign) BOOL isSelectedRow;

@property (nonatomic, strong)NoMyStockView *noMyStockView;

- (void)scrollToTop;

@end
