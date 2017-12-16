//
//  ZFBaseSettingViewController.h
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFSettingGroup.h"
#import "ZFSettingItem.h"
#import "BaseViewController.h"

@interface ZFBaseSettingViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_allGroups; // 所有的组模型
    
    UITableView *_tableView;
}
@end
