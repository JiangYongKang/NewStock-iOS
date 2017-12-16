//
//  SearchViewController.h
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "ILRemoteSearchBar.h"
#import "AddMyStockAPI.h"

@interface SearchViewController : BaseViewController<ILRemoteSearchBarDelegate, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    ILRemoteSearchBar *_searchBar;
    NSMutableArray *_resultArray;
    NSMutableArray *_historyArray;
    
    UITableView *_tableView;
    
    BOOL _bStartSearch;
    
    AddMyStockAPI *_addMyStockAPI;
}
@end
