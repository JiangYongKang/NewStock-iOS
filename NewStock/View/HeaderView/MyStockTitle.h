//
//  MyStockTitle.h
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, STOCK_SORT_STATE) {
    STOCK_SORT_NORMAL,
    STOCK_SORT_UP,
    STOCK_SORT_DOWN
};

typedef NS_ENUM(NSInteger, MYSTOCKTITLE_TYPE) {
    MYSTOCKTITLE_TYPE_NORMAL = 0,
    MYSTOCKTITLE_TYPE_Edit,
};

@protocol MyStockTitleDelegate;

@interface MyStockTitle : UIView
{
    UILabel *_stockNameLb;
    UILabel *_valueLb;
    UILabel *_lbChangeRate;
    UIButton *_editBtn;

    UIButton *_sortBtn;
    STOCK_SORT_STATE _sortType;
}
@property (nonatomic, assign) id<MyStockTitleDelegate> delegate;

- (void)setName:(NSString *)name value:(NSString *)value changeRate:(NSString *)changeRate;

- (void)setEditBtn:(UIImage *)img;

@end



@protocol MyStockTitleDelegate <NSObject>
@optional
- (void)myStockTitle:(MyStockTitle*)cell selectedIndex:(NSUInteger)index;
- (void)myStockTitle:(MyStockTitle*)cell sortType:(STOCK_SORT_STATE)type;

@end
