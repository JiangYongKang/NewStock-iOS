//
//  TabbarView.h
//  NewStock
//
//  Created by 王迪 on 2017/2/16.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerticalButton.h"


@interface TabbarView : UIView

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) VerticalButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@property (nonatomic, strong) UIButton *btn5;

@property (nonatomic, strong) UIButton *lastBtn;

@property (nonatomic, copy) void (^selectedBlcok)(NSInteger);
- (void)btnClick:(UIButton *)btn ;

@end
