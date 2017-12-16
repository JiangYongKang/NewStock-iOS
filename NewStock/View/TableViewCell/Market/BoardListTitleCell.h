//
//  BoardListTitleCell.h
//  NewStock
//
//  Created by Willey on 16/8/8.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"

@interface BoardListTitleCell : UITableViewCell
{
    UILabel *_stockNameLb;
    UILabel *_lbChangeRate;
    UILabel *_leadingStockLb;
}
- (void)setName:(NSString *)name changeRate:(NSString *)changeRate leadingStock:(NSString *)leadingStock;

@end
