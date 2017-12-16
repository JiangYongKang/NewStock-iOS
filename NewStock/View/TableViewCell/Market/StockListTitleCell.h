//
//  StockListTitleCell.h
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StockListTitleCellDelegate;

@interface StockListTitleCell : UITableViewCell
{
    UILabel *_stockNameLb;
    UILabel *_valueLb;
    UILabel *_lbChangeRate;
    UIButton *_editBtn;
}
@property (nonatomic, assign) id<StockListTitleCellDelegate> delegate;

- (void)setName:(NSString *)name value:(NSString *)value changeRate:(NSString *)changeRate;

- (void)setEditBtn:(UIImage *)img;
@end



@protocol StockListTitleCellDelegate <NSObject>
@optional
- (void)stockListTitleCell:(StockListTitleCell*)cell selectedIndex:(NSUInteger)index;

@end