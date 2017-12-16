
//
//  MyStockTopView.m
//  NewStock
//
//  Created by 王迪 on 2017/6/5.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyStockTopView.h"
#import "Defination.h"
#import <Masonry.h>

@interface MyStockTopView ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *dealView;

@property (nonatomic, strong) UILabel *leftNameLb;
@property (nonatomic, strong) UILabel *leftCodeLb;
@property (nonatomic, strong) UILabel *leftZxLb;
@property (nonatomic, strong) UILabel *leftZdfLb;

@property (nonatomic, strong) UIImageView *dealImageView;
@property (nonatomic, strong) UILabel *dealLabel;

@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UILabel *centerLabel;

@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UILabel *line1;
@property (nonatomic, strong) UILabel *line2;
@property (nonatomic, strong) UILabel *line3;

@end

@implementation MyStockTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {

    [self addSubview:self.leftView];
    [self addSubview:self.centerView];
    [self addSubview:self.rightView];
    [self addSubview:self.dealView];
    [self addSubview:self.leftNameLb];
    [self addSubview:self.leftCodeLb];
    [self addSubview:self.leftZxLb];
    [self addSubview:self.leftZdfLb];
    [self addSubview:self.centerImageView];
    [self addSubview:self.centerLabel];
    [self addSubview:self.rightImageView];
    [self addSubview:self.rightLabel];
    [self addSubview:self.dealImageView];
    [self addSubview:self.dealLabel];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    [self addSubview:self.line3];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@(150 * kScale));
    }];
    
    [self.dealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.leftView.mas_right).offset(0);
        make.width.equalTo(@(75 * kScale));
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.dealView);
        make.left.equalTo(self.dealView.mas_right);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self.centerView.mas_right).offset(0);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.dealView).offset(0 * kScale);
        make.width.equalTo(@(0.5));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.line1);
        make.left.equalTo(self.dealView.mas_right).offset(0 * kScale);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightView);
        make.width.top.bottom.equalTo(self.line1);
    }];
    
    [self.leftNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12 * kScale);
        make.centerY.equalTo(self);
    }];
    
    [self.leftCodeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(95 * kScale);
        make.top.equalTo(self).offset(10 * kScale);
    }];
    
    [self.leftZxLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(54 * kScale);
        make.top.equalTo(self.leftCodeLb.mas_bottom).offset(6 * kScale);
    }];
    
    [self.leftZdfLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftZxLb);
        make.right.equalTo(self.line1).offset(-12 * kScale);
    }];
    
    [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(18 * kScale));
        make.centerX.equalTo(self.centerView);
        make.top.equalTo(self).offset(10 * kScale);
    }];
    
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerImageView);
        make.top.equalTo(self.centerImageView.mas_bottom).offset(8 * kScale);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(self.centerImageView);
        make.centerX.equalTo(self.rightView).offset(0 * kScale);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightImageView);
        make.top.equalTo(self.centerLabel);
    }];
    
    [self.dealImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dealView);
        make.top.equalTo(self.dealView).offset(10 * kScale);
    }];
    
    [self.dealLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dealView);
        make.top.equalTo(self.dealImageView.mas_bottom).offset(8 * kScale);
    }];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
}

#pragma mark action

- (void)leftTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(myStockTopViewPushToStock:s:n:m:)]) {
        [self.delegate myStockTopViewPushToStock:@"" s:@"" n:@"" m:@""];
    }
}

- (void)centerTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(myStockTopViewPushToNative:)]) {
        [self.delegate myStockTopViewPushToNative:@"native://ZX0200"];
    }
}

- (void)rightTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(myStockTopViewPushToNative:)]) {
        [self.delegate myStockTopViewPushToNative:@"native://HQ1003"];
    }
}

- (void)dealTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(myStockTopViewPushToNative:)]) {
        [self.delegate myStockTopViewPushToNative:@"./jiabei/TR0001"];
    }
}

- (void)setCode:(NSString *)code zx:(NSString *)zx zdf:(NSString *)zdf {
    
    UIColor *color = kUIColorFromRGB(0x333333);

    if (zdf.floatValue > 0) {
        self.leftCodeLb.text = [NSString stringWithFormat:@"%.2lf",code.floatValue];
        self.leftZxLb.text = [NSString stringWithFormat:@"+%.2lf",zx.floatValue];
        self.leftZdfLb.text = [NSString stringWithFormat:@"+%.2lf%%",zdf.floatValue];
        
        color = kUIColorFromRGB(0xff1919);
    } else {
        self.leftCodeLb.text = [NSString stringWithFormat:@"%.2lf",code.floatValue];
        self.leftZxLb.text = [NSString stringWithFormat:@"%.2lf",zx.floatValue];
        self.leftZdfLb.text = [NSString stringWithFormat:@"%.2lf%%",zdf.floatValue];
        
        color = kUIColorFromRGB(0x009d00);
    }
    
    self.leftCodeLb.textColor = color;
    self.leftZxLb.textColor = color;
    self.leftZdfLb.textColor = color;
}

#pragma mark lazy loading

- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTap:)];
        [_leftView addGestureRecognizer:tap];
    }
    return _leftView;
}

- (UIView *)centerView {
    if (_centerView == nil) {
        _centerView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTap:)];
        [_centerView addGestureRecognizer:tap];
    }
    return _centerView;
}

- (UIView *)rightView {
    if (_rightView == nil) {
        _rightView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTap:)];
        [_rightView addGestureRecognizer:tap];
    }
    return _rightView;
}

- (UIView *)dealView {
    if (_dealView == nil) {
        _dealView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
        [_dealView addGestureRecognizer:tap];
    }
    return _dealView;
}


- (UILabel *)leftNameLb {
    if (_leftNameLb == nil) {
        _leftNameLb = [UILabel new];
        _leftNameLb.font = [UIFont systemFontOfSize:15 * kScale];
        _leftNameLb.preferredMaxLayoutWidth = 35 * kScale;
        _leftNameLb.numberOfLines = 2;
        _leftNameLb.textColor = kUIColorFromRGB(0x333333);
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.lineSpacing = 4 * kScale;
        NSAttributedString *nsAttrS = [[NSAttributedString alloc] initWithString:@"上证指数" attributes:@{NSParagraphStyleAttributeName : para}];
        _leftNameLb.attributedText = nsAttrS;
    }
    return _leftNameLb;
}

- (UILabel *)leftCodeLb {
    if (_leftCodeLb == nil) {
        _leftCodeLb = [UILabel new];
        _leftCodeLb.font = [UIFont boldSystemFontOfSize:17 * kScale];
    }
    return _leftCodeLb;
}

- (UILabel *)leftZxLb {
    if (_leftZxLb == nil) {
        _leftZxLb = [UILabel new];
        _leftZxLb.font = [UIFont boldSystemFontOfSize:11 * kScale];
    }
    return _leftZxLb;
}

- (UILabel *)leftZdfLb {
    if (_leftZdfLb == nil) {
        _leftZdfLb = [UILabel new];
        _leftZdfLb.font = [UIFont boldSystemFontOfSize:11 * kScale];
    }
    return _leftZdfLb;
}

- (UILabel *)line1 {
    if (_line1 == nil) {
        _line1 = [UILabel new];
        _line1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line1;
}

- (UILabel *)line2 {
    if (_line2 == nil) {
        _line2 = [UILabel new];
        _line2.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line2;
}

- (UILabel *)line3 {
    if (_line3 == nil) {
        _line3 = [UILabel new];
        _line3.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line3;
}

- (UIImageView *)centerImageView {
    if (_centerImageView == nil) {
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_myNews_nor"]];
    }
    return _centerImageView;
}

- (UILabel *)centerLabel {
    if (_centerLabel == nil) {
        _centerLabel = [UILabel new];
        _centerLabel.font = [UIFont systemFontOfSize:12 * kScale];
        _centerLabel.textColor= kUIColorFromRGB(0x333333);
        _centerLabel.text = @"自选资讯";
    }
    return _centerLabel;
}

- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_myNotice_nor"]];
    }
    return _rightImageView;
}

- (UILabel *)rightLabel {
    if (_rightLabel == nil) {
        _rightLabel = [UILabel new];
        _rightLabel.font = [UIFont systemFontOfSize:12 * kScale];
        _rightLabel.textColor = kUIColorFromRGB(0x333333);
        _rightLabel.text = @"自选公告";
    }
    return _rightLabel;
}

- (UIImageView *)dealImageView {
    if (_dealImageView == nil) {
        _dealImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_myDeal_nor"]];
    }
    return _dealImageView;
}

- (UILabel *)dealLabel {
    if (_dealLabel == nil) {
        _dealLabel = [UILabel new];
        _dealLabel.font = [UIFont systemFontOfSize:12 * kScale];
        _dealLabel.textColor = kUIColorFromRGB(0x333333);
        _dealLabel.text = @"委托交易";
    }
    return _dealLabel;
}


@end
