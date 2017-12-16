//
//  HalfCellView.h
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoIndexModel.h"

@class HalfCellView;

@protocol HalfCellViewDelegate <NSObject>

- (void)HalfCellViewDelegate:(HalfCellView *)cell;

@end

@interface HalfCellView : UIView

@property (nonatomic, strong) TaoIndexModelClildStock *model;

@property (nonatomic, weak) id<HalfCellViewDelegate> delegate;

@end
