//
//  BoardListViewController.h
//  NewStock
//
//  Created by Willey on 16/8/7.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger , BoardDetailType) {
    BoardDetailType_10 = 0,
    BoardDetailType_20,
    BoardDetailType_30
};

@interface BoardListViewController : BaseTableViewController

@property (nonatomic, assign) BoardDetailType BoardDetailType;

@end
