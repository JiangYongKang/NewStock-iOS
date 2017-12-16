//
//  MainStockApplyView.m
//  NewStock
//
//  Created by 王迪 on 2017/5/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainStockApplyView.h"
#import "Defination.h"
#import <Masonry.h>

@interface MainStockApplyView ()

@property (nonatomic) UILabel *applyLb;

@property (nonatomic) UIButton *applyBtn;

@end

@implementation MainStockApplyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyBtnClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.applyLb];
    [self addSubview:self.applyBtn];
    
    [self.applyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12 * kScale);
        make.centerY.equalTo(self);
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_applyLb);
        make.right.equalTo(self).offset(-12 * kScale);
        make.width.equalTo(@(75 * kScale));
        make.height.equalTo(@(24 * kScale));
    }];
}

#pragma mark action

- (void)setApplyCount:(NSInteger) count {
    NSString *countS = [NSString stringWithFormat:@"%zd",count];
    NSString *s = [NSString stringWithFormat:@"今日可申购新股 %@ 支",countS];
    NSRange range = [s rangeOfString:countS];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:s];
    [attr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(0xff1919) range:range];
    self.applyLb.attributedText = attr;
}

- (void)setBtnStr:(NSString *)btnStr {
    _btnStr = btnStr;
    [self.applyBtn setTitle:btnStr forState:UIControlStateNormal];
}


- (void)applyBtnClick {
    if ([self.delegate respondsToSelector:@selector(mainStockApplyViewBtnClick:)]) {
        [self.delegate mainStockApplyViewBtnClick:_url];
    }
}

#pragma mark lazyloading

- (UILabel *)applyLb {
    if (_applyLb == nil) {
        _applyLb = [UILabel new];
        _applyLb.textColor = kUIColorFromRGB(0x333333);
        _applyLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _applyLb;
}

- (UIButton *)applyBtn {
    if (_applyBtn == nil) {
        _applyBtn = [UIButton new];
        _applyBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_applyBtn setTitle:@"新股申购" forState:UIControlStateNormal];
        [_applyBtn setTitleColor:kUIColorFromRGB(0x358ee7) forState:UIControlStateNormal];
        _applyBtn.layer.cornerRadius = 12 * kScale;
        _applyBtn.layer.masksToBounds = YES;
        _applyBtn.layer.borderWidth = 0.5;
        _applyBtn.layer.borderColor = kUIColorFromRGB(0x358ee7).CGColor;
        _applyBtn.userInteractionEnabled = NO;
        //        [_applyBtn addTarget:self action:@selector(applyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
}


@end
