//
//  TaoQLNGBottomView.m
//  NewStock
//
//  Created by 王迪 on 2017/6/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGBottomView.h"
#import "Defination.h"
#import <Masonry.h>

@interface TaoQLNGBottomView ()

@property (nonatomic, strong) UIButton *starBtn;
@property (nonatomic, strong) UIButton *comBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation TaoQLNGBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];

    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = kUIColorFromRGB(0xf7f7f7);
    [self addSubview:self.starBtn];
    [self addSubview:self.comBtn];
    [self addSubview:self.shareBtn];
    
    CGFloat w = MAIN_SCREEN_WIDTH / 2.0;

//    [self.starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(self);
//        make.width.equalTo(@(w));
//    }];
    
    [self.comBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starBtn);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@(w));
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self);
        make.width.equalTo(@(w));
    }];
    
    UILabel *lb = [UILabel new];
    lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

- (void)btnClick:(UIButton *)btn {
    if (![self.delegate respondsToSelector:@selector(taoQLNGBottomViewDelegatePushTo:)]) {
        return;
    }
    NSString *url = @"";
    if (btn.tag == 1) {
        url = @"dy";
    } else if (btn.tag == 2) {
        url = @"pj";
    } else if (btn.tag == 3) {
        url = @"fx";
    }
    [self.delegate taoQLNGBottomViewDelegatePushTo:url];
}

#pragma mark lazy loading

- (UIButton *)starBtn {
    if (_starBtn == nil) {
        _starBtn = [UIButton new];
        _starBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_starBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _starBtn.tag = 1;
        [_starBtn setTitle:@"订阅" forState:UIControlStateNormal];
        [_starBtn setImage:[UIImage imageNamed:@"tao_qlng_bottom_star"] forState:UIControlStateNormal];
        [_starBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
        UILabel *line = [UILabel new];
        line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_starBtn addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(_starBtn);
            make.width.equalTo(@(0.5));
        }];
        _starBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    return _starBtn;
}

- (UIButton *)comBtn {
    if (_comBtn == nil) {
        _comBtn = [UIButton new];
        _comBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_comBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _comBtn.tag = 2;
        [_comBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_comBtn setImage:[UIImage imageNamed:@"tao_qlng_bottom_comment"] forState:UIControlStateNormal];
        [_comBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
        UILabel *line = [UILabel new];
        line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_comBtn addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(_comBtn);
            make.width.equalTo(@(0.5));
        }];
        _comBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    return _comBtn;
}

- (UIButton *)shareBtn {
    if (_shareBtn == nil) {
        _shareBtn = [UIButton new];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.tag = 3;
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"tao_qlng_bottom_share"] forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, -6);
    }
    return _shareBtn;
}

@end
