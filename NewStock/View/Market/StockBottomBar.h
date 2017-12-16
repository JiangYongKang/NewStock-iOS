//
//  StockBottomBar.h
//  NewStock
//
//  Created by 王迪 on 2017/6/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StockBottomBar;

typedef NS_ENUM(NSInteger,STOCK_BAR_TYPE) {
    STOCK_BAR_TYPE_STOCK,
    STOCK_BAR_TYPE_INDEX,
};

@protocol StockBottomBarDelegate <NSObject>

- (void)stockBottomBarDelegatePushTo:(NSString *)url;

@end

@interface StockBottomBar : UIView

@property (nonatomic, weak) id <StockBottomBarDelegate> delegate;

- (instancetype)initWithType:(STOCK_BAR_TYPE)type;

- (void)setIsAdd:(BOOL)isAdd;

@end
