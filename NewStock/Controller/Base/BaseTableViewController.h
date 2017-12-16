//
//  BaseTableViewController.h
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "APIListRequest.h"

@interface BaseTableViewController :  BaseViewController<UITableViewDelegate,UITableViewDataSource,APIRequestDelegate>
{
    UITableView *_tableView;
    
    APIListRequest *_listRequestAPI;

    NSString *_resultListName;
    NSMutableArray *_resultListArray;
    int _totalNum;
}

-(void)initRequestAPI;
-(Class)getModelClass;
-(void)analyzeData:(id)responseJSONObject;
@end
