//
//  MsgAlertPopView.m
//  NewStock
//
//  Created by 王迪 on 2017/4/26.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MsgAlertPopView.h"
#import "Defination.h"
#import <Masonry.h>

@interface MsgAlertPopView ()

@property (nonatomic, strong) UILabel *msgLb;

@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation MsgAlertPopView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.msgLb];
    [self addSubview:self.pushBtn];
    
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40 * kScale);
        make.centerX.equalTo(self);
    }];
    
    [self.pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-30 * kScale);
        make.width.equalTo(@(120 * kScale));
        make.height.equalTo(@(32 * kScale));
    }];
}

- (void)setMsg:(NSString *)msg {
    _msg = msg;
    
    self.msgLb.text = msg;
}

- (void)pushBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(MsgAlertPopViewBtnClick:)]) {
        [self.delegate MsgAlertPopViewBtnClick:self.url];
    }
}

#pragma mark lazyloading

- (UILabel *)msgLb {
    if (_msgLb == nil) {
        _msgLb = [UILabel new];
        _msgLb.font = [UIFont systemFontOfSize:14 * kScale];
        _msgLb.textColor = kUIColorFromRGB(0x333333);
        _msgLb.numberOfLines = 0;
        _msgLb.preferredMaxLayoutWidth = 250 * kScale;
    }
    return _msgLb;
}

- (UIButton *)pushBtn {
    if (_pushBtn == nil) {
        _pushBtn = [UIButton new];
        [_pushBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        [_pushBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        _pushBtn.layer.cornerRadius = 16 * kScale;
        _pushBtn.layer.masksToBounds = YES;
        _pushBtn.backgroundColor = kButtonBGColor;
        [_pushBtn addTarget:self action:@selector(pushBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushBtn;
}

@end
