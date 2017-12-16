//
//  TaoTuiJianTableViewCell.h
//  NewStock
//
//  Created by 王迪 on 2017/3/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoTuiJianModel.h"

@interface TaoTuiJianTableViewCell : UITableViewCell

@property (nonatomic, strong) TaoTuiJianModel *model;

@property (nonatomic, copy) void(^heightBlcok)();

@end
 
