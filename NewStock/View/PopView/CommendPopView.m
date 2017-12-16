//
//  CommendPopView.m
//  NewStock
//
//  Created by 王迪 on 2017/1/11.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "CommendPopView.h"
#import "Defination.h"
#import <Masonry.h>

@interface CommendPopView ()

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *kissImageView;
@property (nonatomic, strong) UIImageView *heartImageView;

@property (nonatomic, strong) UILabel *topLb;
@property (nonatomic, strong) UILabel *centerLb;
@property (nonatomic, strong) UILabel *bottomLb;

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation CommendPopView



- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        self.layer.cornerRadius = 10 * kScale;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.kissImageView];
    [self addSubview:self.heartImageView];
    [self addSubview:self.topImageView];
    [self addSubview:self.topLb];
    [self addSubview:self.centerLb];
    [self addSubview:self.bottomLb];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(-47 * kScale);
        make.width.height.equalTo(@(124 * kScale));
        make.centerX.equalTo(self);
    }];
    
    [self.kissImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(2);
        make.top.equalTo(self).offset(5);
    }];
    
    [self.heartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topImageView.mas_left).offset(-5);
        make.top.equalTo(self.topImageView).offset(10 * kScale);
    }];
    
    [self.topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(12 * kScale);
        make.centerX.equalTo(self);
    }];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.topLb.mas_bottom).offset(12 * kScale);
    }];
    
    [self.bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.centerLb.mas_bottom).offset(11 * kScale);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLb.mas_bottom).offset(20 * kScale);
        make.left.equalTo(self).offset(20 * kScale);
        make.width.equalTo(@(100 * kScale));
        make.height.equalTo(@(36 * kScale));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(self.leftBtn);
        make.right.equalTo(self).offset(-20 * kScale);
    }];
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(commendPopViewDelegate:)]) {
        [self.delegate commendPopViewDelegate:tap.view.tag];
    }
}

- (void)btnClick:(UIButton *)btn {
    if (![self.delegate respondsToSelector:@selector(commendPopViewDelegate:)]) {
        return;
    }
    if (btn.tag == 1) {
        [self.delegate commendPopViewDelegate:1];
    } else if (btn.tag == 2) {
        [self.delegate commendPopViewDelegate:2];
    }
}

#pragma mark lazyloading

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_monkey_img"]];
        _topImageView.layer.cornerRadius = 62 * kScale;
        _topImageView.layer.masksToBounds = YES;
    }
    return _topImageView;
}

- (UIImageView *)heartImageView {
    if (_heartImageView == nil) {
        _heartImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_heart_img"]];
    }
    return _heartImageView;
}

- (UIImageView *)kissImageView {
    if (_kissImageView == nil) {
        _kissImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_kiss_img"]];
    }
    return _kissImageView;
}

- (UILabel *)topLb {
    if (_topLb == nil) {
        _topLb = [UILabel new];
        _topLb.font = [UIFont systemFontOfSize:12 * kScale];
        _topLb.textColor = kUIColorFromRGB(0x666666);
        _topLb.numberOfLines = 2;
        _topLb.text = @"产品MM挥起小皮鞭~\n程序猿GG日夜苦干~";
    }
    return _topLb;
}

- (UILabel *)centerLb {
    if (_centerLb == nil) {
        _centerLb = [UILabel new];
        _centerLb.font = [UIFont systemFontOfSize:15 * kScale];
        _centerLb.textColor = kUIColorFromRGB(0x333333);
        _centerLb.text = @"新版又来了";
    }
    return _centerLb;
}

- (UILabel *)bottomLb {
    if (_bottomLb == nil) {
        _bottomLb = [UILabel new];
        _bottomLb.font = [UIFont systemFontOfSize:16 * kScale];
        _bottomLb.textColor = kTitleColor;
        _bottomLb.text = @"亲~请吐槽~请鞭策";
    }
    return _bottomLb;
}

- (UIButton *)leftBtn {
    if (_leftBtn == nil) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitle:@"冷漠拒绝" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16 * kScale];
        [_leftBtn setBackgroundColor:kUIColorFromRGB(0xb2b2b2)];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.tag = 1;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (_rightBtn == nil) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:@"抽一鞭子" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16 * kScale];
        [_rightBtn setBackgroundColor:kButtonBGColor];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.tag = 2;
    }
    return _rightBtn;
}

@end
