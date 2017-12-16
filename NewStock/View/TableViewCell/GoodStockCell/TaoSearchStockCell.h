//
//  TaoSearchStockCell.h
//  NewStock
//
//  Created by 王迪 on 2017/2/23.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoSearchStockModel.h"

@interface TaoSearchStockCell : UITableViewCell

@property (nonatomic, copy) void (^pushBlock)(NSString *);

@property (nonatomic, strong) TaoSearchStockBSModel *model;

@end
