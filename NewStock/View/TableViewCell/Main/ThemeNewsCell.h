//
//  ThemeNewsCell.h
//  NewStock
//
//  Created by 王迪 on 2017/5/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeDetailModel.h"

@class ThemeNewsCell;

@protocol ThemeNewsCellDelegate <NSObject>

- (void)ThemeNewsCellDelegateClick:(ThemeDetailStockModel *)model;

@end

@interface ThemeNewsCell : UITableViewCell

@property (nonatomic, strong) ThemeDetailTmlModel *model;

@property (nonatomic, weak) id <ThemeNewsCellDelegate> delegate;

@property (nonatomic, assign) BOOL isFirst;

@end
