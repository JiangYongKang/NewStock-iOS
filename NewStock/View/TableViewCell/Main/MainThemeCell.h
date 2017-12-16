//
//  MainThemeCell.h
//  NewStock
//
//  Created by 王迪 on 2017/5/4.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"

typedef NS_ENUM(NSInteger, MainThemeCellStyle) {
    MainThemeCellStyleBorder,
    MainThemeCellStyleDefault,
    MainThemeCellStyleShadow,
};

@protocol  MainThemeCellDelegate <NSObject>

- (void)MainThemeCellDelegate:(MainThemeStockModel *)model;

@end

@interface MainThemeCell : UITableViewCell

@property (nonatomic, strong) MainThemeModel *model;

@property (nonatomic, weak) id <MainThemeCellDelegate> delegate;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isLastOne;

@property (nonatomic, assign) MainThemeCellStyle style;

@end
