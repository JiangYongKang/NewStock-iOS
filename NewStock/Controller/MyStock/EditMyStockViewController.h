//
//  EditMyStockViewController.h
//  NewStock
//
//  Created by Willey on 16/8/25.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "APIListRequest.h"
#import "StockListTitleCell.h"
#import "MyStockTitle.h"

@interface EditMyStockViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,APIRequestDelegate,MyStockTitleDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_myStockArray;
}
@end
