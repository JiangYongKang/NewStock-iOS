//
//  FeedChildListViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/5/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FeedListModel.h"

@interface FeedChildListViewController : BaseViewController

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *tt;

@property (nonatomic, copy) FeedListModel *model;

@end
