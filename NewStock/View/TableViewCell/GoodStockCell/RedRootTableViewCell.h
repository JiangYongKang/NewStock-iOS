//
//  RedRootTableViewCell.h
//  NewStock
//
//  Created by 王迪 on 2017/2/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedRootModel.h"


@interface RedRootTableViewCell : UITableViewCell

@property (nonatomic, strong) RedRootListModel *model;

@property (nonatomic, copy) void (^heightBlcok)();

@end
