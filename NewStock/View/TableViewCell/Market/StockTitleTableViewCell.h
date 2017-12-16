//
//  StockTitleTableViewCell.h
//  NewStock
//
//  Created by Willey on 16/7/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableViewCell.h"

@protocol StockTitleTableViewCellDelegate;

@interface StockTitleTableViewCell : SKSTableViewCell
{
    UIButton *_moreBtn;
}

@property (assign, nonatomic) id<StockTitleTableViewCellDelegate> delegate;


@end


@protocol StockTitleTableViewCellDelegate <NSObject>
@optional
- (void)stockTitleTableViewCell:(StockTitleTableViewCell*)cell selectedIndex:(NSUInteger)index;

@end