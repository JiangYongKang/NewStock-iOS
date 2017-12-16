//
//  ThemeCenterStockView.h
//  NewStock
//
//  Created by 王迪 on 2017/5/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeDetailModel.h"

@class ThemeCenterStockView;

@protocol ThemeCenterStockViewDelegate <NSObject>

- (void)ThemeCenterStockViewStockClick:(ThemeDetailStockModel *)model;

@end

@interface ThemeCenterStockView : UIView

@property (nonatomic, strong) NSArray <ThemeDetailStockModel *> *dataArray;

@property (nonatomic, weak) id <ThemeCenterStockViewDelegate> delegate;

@end
