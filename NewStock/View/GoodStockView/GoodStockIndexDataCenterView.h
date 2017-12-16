//
//  GoodStockIndexDataCenterView.h
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodStockIndexDataCenterView;

@protocol GoodStockIndexDataCenterViewDelegate <NSObject>

- (void)goodStockIndexDataCenterViewDelegatePush:(NSString *)url;

@end

@interface GoodStockIndexDataCenterView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, weak) id <GoodStockIndexDataCenterViewDelegate> delegate;

@end
