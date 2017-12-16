//
//  MainStockApplyView.h
//  NewStock
//
//  Created by 王迪 on 2017/5/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainStockApplyView;

@protocol MainStockApplyViewDelegate <NSObject>

- (void)mainStockApplyViewBtnClick:(NSString *)url;

@end

@interface MainStockApplyView : UIView

@property (nonatomic, weak) id <MainStockApplyViewDelegate> delegate;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *btnStr;

- (void)setApplyCount:(NSInteger) count;

@end
