//
//  BigVPopView.m
//  NewStock
//
//  Created by 王迪 on 2017/4/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BigVPopView.h"
#import "Defination.h"
#import <Masonry.h>

@interface BigVPopView ()

@property (nonatomic) UILabel *topLb;

@property (nonatomic) UILabel *bottomLb;

@property (nonatomic) UIButton *buttomBtn;

@property (nonatomic) UIImageView *topImageView;

@end

@implementation BigVPopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.buttomBtn];
    [self addSubview:self.bottomLb];
    [self addSubview:self.topLb];
    [self addSubview:self.topImageView];
    
    self.layer.cornerRadius = 7 * kScale;
    
    [self.buttomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-21 * kScale);
        make.width.equalTo(@(130 * kScale));
        make.height.equalTo(@(32 * kScale));
    }];
    
    [self.bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.buttomBtn.mas_top).offset(-20 * kScale);
    }];
    
    [self.topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.bottomLb.mas_top).offset(-10 * kScale);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.height.equalTo(@(70 * kScale));
        make.top.equalTo(self).offset(-25 * kScale);
    }];
    
}

- (void)btnClick {
    if ([self.delegate respondsToSelector:@selector(BigVPopViewDelegate:andBtnClick:)]) {
        [self.delegate BigVPopViewDelegate:self andBtnClick:_buttomBtn];
    }
    [self dismissPopup];
}

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_popBigV_nor"]];
        _topImageView.layer.cornerRadius = 35 * kScale;
        _topImageView.layer.masksToBounds = YES;
    }
    return _topImageView;
}

- (UILabel *)topLb {
    if (_topLb == nil) {
        _topLb = [UILabel new];
        _topLb.textColor = kUIColorFromRGB(0x333333);
        _topLb.font = [UIFont boldSystemFontOfSize:20 * kScale];
        _topLb.text = @"快来成为\"认证\"大V吧!";
        _topLb.textAlignment = NSTextAlignmentCenter;
    }
    return _topLb;
}

- (UILabel *)bottomLb {
    if (_bottomLb == nil) {
        _bottomLb = [UILabel new];
        _bottomLb.textColor = kUIColorFromRGB(0x666666);
        _bottomLb.font = [UIFont systemFontOfSize:12 * kScale];
        _bottomLb.text = @"拥有大V专属地盘,你的地盘你做主";
        _bottomLb.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLb;
}

- (UIButton *)buttomBtn {
    if (_buttomBtn == nil) {
        _buttomBtn = [[UIButton alloc] init];
        [_buttomBtn setTitle:@"免费认证" forState:UIControlStateNormal];
        [_buttomBtn.titleLabel setFont:[UIFont systemFontOfSize:16 * kScale]];
        [_buttomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttomBtn setBackgroundColor:kButtonBGColor];
        _buttomBtn.layer.cornerRadius = 16 * kScale;
        _buttomBtn.layer.masksToBounds = YES;
        [_buttomBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttomBtn;
}


@end
