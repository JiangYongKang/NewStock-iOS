//
//  DepartmentListCell.h
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TaoSearchDepartmentModel.h"

@interface DepartmentListCell : UITableViewCell

@property (nonatomic, strong) TaoSearchDepartmentListModel *model;

@property (nonatomic, copy) NSString *tm;

@end
