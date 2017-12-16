//
//  MainThemeView.h
//  NewStock
//
//  Created by 王迪 on 2017/5/4.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"

@protocol MainThemeViewDelegate <NSObject>

- (void)MainThemeViewStockClick:(MainThemeStockModel *)model;
- (void)MainThemeViewClick:(NSString *)url;
- (void)MainThemeViewMoreClick;

@end

@interface MainThemeView : UIView

@property (nonatomic, strong) NSArray <MainThemeModel *> *dataArray;

@property (nonatomic, weak) id <MainThemeViewDelegate> delegate;

@end
