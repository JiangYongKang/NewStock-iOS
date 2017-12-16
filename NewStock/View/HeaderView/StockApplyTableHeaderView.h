//
//  StockApplyTableHeaderView.h
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockApplyModel.h"

@class StockApplyTableHeaderView;


@protocol StockApplyTableHeaderViewDelegate <NSObject>

- (void)stockApplyTableHeaderViewClick;

@end

@interface StockApplyTableHeaderView : UIView

@property (nonatomic, strong) StockApplyModel *model;

@property (nonatomic, weak) id <StockApplyTableHeaderViewDelegate> delegate;

@end
