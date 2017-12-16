//
//  MessageViewController.h
//  NewStock
//
//  Created by Willey on 16/8/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableViewController.h"
#import "MessageAPI.h"

@interface MessageViewController : BaseViewController <APIRequestDelegate,UITableViewDelegate,UITableViewDataSource>//BaseTableViewController
{
    UILabel *_tipsLb;
    
    MessageAPI *_messageRequestAPI;
    UITableView *_tableView;
    NSArray *_resultListArray;
    NSInteger _curCount;
}
@end
