//
//  TaoIndexSearchView.m
//  NewStock
//
//  Created by 王迪 on 2017/3/9.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoIndexSearchView.h"
#import "Defination.h"
#import <Masonry.h>


@interface TaoIndexSearchView ()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIButton *askBtn;
@property (nonatomic, strong) UILabel *centerLb;

@end

@implementation TaoIndexSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.bottomView];
    [self addSubview:self.centerView];
    [self.centerView addSubview:self.centerLb];
    [self.centerView addSubview:self.askBtn];
    [self.centerView addSubview:self.searchBtn];
    
    self.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(36 * kScale);
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-6 * kScale);
        make.left.equalTo(self).offset(27 * kScale);
        make.right.equalTo(self).offset(-27 * kScale);
        make.height.equalTo(@(44 * kScale));
    }];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView).offset(10 * kScale);
        make.centerY.equalTo(self.centerView);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.centerView);
        make.width.equalTo(@(44 * kScale));
    }];
    
    [self.askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerView);
        make.right.equalTo(self.searchBtn.mas_left).offset(-16 * kScale);
    }];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self.centerView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.5 * kScale));
        make.top.bottom.equalTo(self.centerView);
        make.right.equalTo(self.searchBtn.mas_left);
    }];
}

- (void)setDsc:(NSString *)dsc {
    _dsc = dsc;
    self.centerLb.text = dsc;
}

#pragma mark action

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.askBlock) {
        self.askBlock();
    }
}

- (void)askBtnClick:(UIButton *)btn {
    if (self.askBlock) {
        self.askBlock();
    }
}

- (void)searchBtnClick:(UIButton *)btn {
    if (self.searchBlock) {
        self.searchBlock();
    }
}

#pragma mark lazy loading

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = kUIColorFromRGB(0xfffffff);
    }
    return _bottomView;
}

- (UIView *)centerView {
    if (_centerView == nil) {
        _centerView = [UIView new];
        _centerView.backgroundColor = kUIColorFromRGB(0xffffff);
        _centerView.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
        _centerView.layer.borderWidth = 0.5 * kScale;
        _centerView.layer.cornerRadius = 10 * kScale;
        _centerView.layer.masksToBounds = YES;
    }
    return _centerView;
}

- (UILabel *)centerLb {
    if (_centerLb == nil) {
        _centerLb = [UILabel new];
        _centerLb.textColor = kUIColorFromRGB(0x333333);
        _centerLb.font = [UIFont systemFontOfSize:14 * kScale];
        _centerLb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_centerLb addGestureRecognizer:tap];
    }
    return _centerLb;
}

- (UIButton *)askBtn {
    if (_askBtn == nil) {
        _askBtn = [[UIButton alloc] init];
        [_askBtn setImage:[UIImage imageNamed:@"icon_ask_nor"] forState:UIControlStateNormal];
        [_askBtn addTarget:self action:@selector(askBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askBtn;
}

- (UIButton *)searchBtn {
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setImage:[UIImage imageNamed:@"ic_bigsearch_nor"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

@end
