//
//  TabbarView.m
//  NewStock
//
//  Created by 王迪 on 2017/2/16.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TabbarView.h"
#import "Defination.h"
#import <Masonry.h>

@interface TabbarView ()



@end

@implementation TabbarView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    [self addSubview:self.btn1];
    [self addSubview:self.btn2];
    [self addSubview:self.btn3];
    [self addSubview:self.btn4];
    [self addSubview:self.btn5];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(MAIN_SCREEN_WIDTH * 0.2));
        make.height.equalTo(@49);
        make.left.bottom.equalTo(self);
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(MAIN_SCREEN_WIDTH * 0.2));
        make.height.equalTo(@49);
        make.bottom.equalTo(self);
        make.left.equalTo(self.btn1.mas_right);
    }];
    
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(MAIN_SCREEN_WIDTH * 0.2));
        make.height.equalTo(@65);
        make.bottom.equalTo(self);
        make.left.equalTo(self.btn2.mas_right);
    }];
    
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(MAIN_SCREEN_WIDTH * 0.2));
        make.height.equalTo(@49);
        make.bottom.equalTo(self);
        make.left.equalTo(self.btn3.mas_right);
    }];
    
    [self.btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(MAIN_SCREEN_WIDTH * 0.2));
        make.height.equalTo(@49);
        make.bottom.equalTo(self);
        make.left.equalTo(self.btn4.mas_right);
    }];
    
    self.lastBtn = self.btn1;
    self.lastBtn.selected = YES;
}

- (void)btnClick:(UIButton *)btn {
    if (self.selectedBlcok) {
        self.selectedBlcok(btn.tag);
    }
    
    self.lastBtn.selected = NO;
    self.lastBtn = btn;
    self.lastBtn.selected = YES;
}

- (UIButton *)btn1 {
    if (_btn1 == nil) {
        _btn1 = [[UIButton alloc] init];
        _btn1.tintColor = kButtonBGColor;
        [_btn1 setImage:[UIImage imageNamed:@"tabbar_discovery"] forState:UIControlStateNormal];
        [_btn1 setImage:[UIImage imageNamed:@"tabbar_discoveryHL"] forState:UIControlStateSelected];
        [_btn1 setImage:[UIImage imageNamed:@"tabbar_discoveryHL"] forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn1 setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        [_btn1 setTitleColor:kTitleColor forState:UIControlStateSelected];
        [_btn1 setTitleColor:kTitleColor forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn1 setTitle:@"发现" forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn1.tag = 0;
        _btn1.adjustsImageWhenHighlighted = NO;
        [_btn1 setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:12];
        _btn1.imageEdgeInsets = UIEdgeInsetsMake(-7, 10, 7, -10);
        _btn1.titleEdgeInsets = UIEdgeInsetsMake(13, -13, -13, 13);
    }
    return _btn1;
}

- (UIButton *)btn2 {
    if (_btn2 == nil) {
        _btn2 = [[UIButton alloc] init];
        _btn2.tintColor = kButtonBGColor;
        UIImage *img = [UIImage imageNamed:@"tabbar_myStockHL"];
        [_btn2 setImage:[UIImage imageNamed:@"tabbar_myStock"] forState:UIControlStateNormal];
        [_btn2 setImage:img forState:UIControlStateSelected];
        [_btn2 setImage:img forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btn2 setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        [_btn2 setTitleColor:kTitleColor forState:UIControlStateSelected];
        [_btn2 setTitleColor:kTitleColor forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn2 setTitle:@"自选" forState:UIControlStateNormal];
        _btn2.tag = 1;
        _btn2.adjustsImageWhenHighlighted = NO;
        [_btn2 setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:12];
        _btn2.imageEdgeInsets = UIEdgeInsetsMake(-7, 12, 7, -12);
        _btn2.titleEdgeInsets = UIEdgeInsetsMake(13, -11, -13, 11);
    }
    return _btn2;
}

- (VerticalButton *)btn3 {
    if (_btn3 == nil) {
        _btn3 = [[VerticalButton alloc] init];
//        _btn3.tintColor = kButtonBGColor;
        [_btn3 setImage:[UIImage imageNamed:@"tabbar_goodStock"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"tabbar_goodStockHL"] forState:UIControlStateSelected];
        [_btn3 setImage:[UIImage imageNamed:@"tabbar_goodStockHL"] forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn3 setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        [_btn3 setTitleColor:kUIColorFromRGB(0xff6e19) forState:UIControlStateSelected];
        [_btn3 setTitleColor:kUIColorFromRGB(0xff6e19) forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn3 setTitle:@"淘牛股" forState:UIControlStateNormal];
        [_btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn3.tag = 2;
        _btn3.adjustsImageWhenHighlighted = NO;
        [_btn3 setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _btn3;
}

- (UIButton *)btn4 {
    if (_btn4 == nil) {
        _btn4 = [[UIButton alloc] init];
        _btn4.tintColor = kButtonBGColor;
        [_btn4 setImage:[UIImage imageNamed:@"tabbar_moment"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"tabbar_momentHL"] forState:UIControlStateSelected];
        [_btn4 setImage:[UIImage imageNamed:@"tabbar_momentHL"] forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn4 setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        [_btn4 setTitleColor:kTitleColor forState:UIControlStateSelected];
        [_btn4 setTitleColor:kTitleColor forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn4 setTitle:@"股侠圈" forState:UIControlStateNormal];
        [_btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn4.tag = 3;
        _btn4.adjustsImageWhenHighlighted = NO;
        [_btn4 setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _btn4.titleLabel.font = [UIFont systemFontOfSize:12];
        _btn4.imageEdgeInsets = UIEdgeInsetsMake(-9, 19, 9, -19);
        _btn4.titleEdgeInsets = UIEdgeInsetsMake(13, -9, -13, 9);
    }
    return _btn4;
}

- (UIButton *)btn5 {
    if (_btn5 == nil) {
        _btn5 = [[UIButton alloc] init];
        _btn5.tintColor = kButtonBGColor;
        [_btn5 setImage:[UIImage imageNamed:@"tabbar_account"] forState:UIControlStateNormal];
        [_btn5 setImage:[UIImage imageNamed:@"tabbar_accountHL"] forState:UIControlStateSelected];
        [_btn5 setImage:[UIImage imageNamed:@"tabbar_accountHL"] forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn5 setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        [_btn5 setTitleColor:kTitleColor forState:UIControlStateSelected];
        [_btn5 setTitleColor:kTitleColor forState:UIControlStateHighlighted | UIControlStateSelected];
        [_btn5 setTitle:@"我的" forState:UIControlStateNormal];
        [_btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn5.tag = 4;
        _btn5.adjustsImageWhenHighlighted = NO;
        [_btn5 setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _btn5.titleLabel.font = [UIFont systemFontOfSize:12];
        _btn5.imageEdgeInsets = UIEdgeInsetsMake(-7, 12, 7, -12);
        _btn5.titleEdgeInsets = UIEdgeInsetsMake(13, -11, -13, 11);
    }
    return _btn5;
}




@end
