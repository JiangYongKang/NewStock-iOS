//
//  MyVertifyView.m
//  NewStock
//
//  Created by 王迪 on 2017/4/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyVertifyView.h"
#import "Defination.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface MyVertifyView ()

@property (nonatomic, strong) UIImageView *iv_icon;
@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_state;
@property (nonatomic, strong) UILabel *lb_stateDsc;

@property (nonatomic, strong) UILabel *lb_rn;
@property (nonatomic, strong) UILabel *lb_idn;
@property (nonatomic, strong) UILabel *lb_phn;
@property (nonatomic, strong) UILabel *lb_rs;

@end

@implementation MyVertifyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.iv_icon];
    [self addSubview:self.lb_name];
    [self addSubview:self.lb_state];
    [self addSubview:self.lb_stateDsc];
    
    [self.iv_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20 * kScale);
        make.left.equalTo(self).offset(24 * kScale);
        make.width.height.equalTo(@(49 * kScale));
    }];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iv_icon.mas_bottom).offset(10 * kScale);
        make.centerX.equalTo(self.iv_icon);
    }];
    
    [self.lb_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.iv_icon);
    }];
    
    [self.lb_stateDsc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_state).offset(0);
        make.right.equalTo(self).offset(-15 * kScale);
        make.top.equalTo(self.lb_state.mas_bottom).offset(10 * kScale);
    }];
    
    UIView *topMarginView = [UIView new];
    topMarginView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [self addSubview:topMarginView];
    [topMarginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.lb_name.mas_bottom).offset(20 * kScale);
        make.height.equalTo(@(10 * kScale));
    }];
    
    UILabel *rn = [UILabel new];
    rn.text = @"姓名";
    rn.font = [UIFont systemFontOfSize:14 * kScale];
    rn.textColor = kUIColorFromRGB(0x666666);
    
    UILabel *idn = [UILabel new];
    idn.text = @"身份证号码";
    idn.font = [UIFont systemFontOfSize:14 * kScale];
    idn.textColor = kUIColorFromRGB(0x666666);
    
    UILabel *phn = [UILabel new];
    phn.text = @"手机号码";
    phn.font = [UIFont systemFontOfSize:14 * kScale];
    phn.textColor = kUIColorFromRGB(0x666666);
    
    UILabel *line1 = [UILabel new];
    line1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    
    UILabel *line2 = [UILabel new];
    line2.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    
    [self addSubview:line1];
    [self addSubview:line2];
    [self addSubview:rn];
    [self addSubview:self.lb_rn];
    [self addSubview:idn];
    [self addSubview:self.lb_idn];
    [self addSubview:phn];
    [self addSubview:self.lb_phn];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12 * kScale);
        make.right.equalTo(self).offset(-12 * kScale);
        make.top.equalTo(topMarginView.mas_bottom).offset(44 * kScale);
        make.height.equalTo(@(0.5 * kScale));
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(line1);
        make.top.equalTo(line1.mas_bottom).offset(44 * kScale);
    }];
    
    [rn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topMarginView.mas_bottom).offset(15 * kScale);
        make.left.equalTo(line1);
    }];
    
    [self.lb_rn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rn);
        make.right.equalTo(line1);
    }];
    
    [idn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1);
        make.top.equalTo(line1.mas_bottom).offset(15 * kScale);
    }];
    
    [self.lb_idn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(idn);
        make.right.equalTo(line1);
    }];
    
    [phn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(15 * kScale);
        make.left.equalTo(line1);
    }];
    
    [self.lb_phn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phn);
        make.right.equalTo(line1);
    }];
    
    UIView *bottomMarginView = [UIView new];
    bottomMarginView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [self addSubview:bottomMarginView];
    [bottomMarginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(topMarginView);
        make.top.equalTo(line2.mas_bottom).offset(44 * kScale);
    }];
    
    UILabel *rs = [UILabel new];
    rs.text = @"申请理由:";
    rs.textColor = kUIColorFromRGB(0x666666);
    rs.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *line3 = [UILabel new];
    line3.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    
    [self addSubview:rs];
    [self addSubview:line3];
    [self addSubview:self.lb_rs];
    
    [rs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1);
        make.top.equalTo(bottomMarginView.mas_bottom).offset(10 * kScale);
    }];
    
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(line1);
        make.top.equalTo(rs.mas_bottom).offset(10 * kScale);
    }];
    
    [self.lb_rs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1);
        make.right.equalTo(line1);
        make.top.equalTo(line3.mas_bottom).offset(10 * kScale);
    }];
    
}

- (void)setModel:(MyVertifyInfoModel *)model {
    _model = model;
    
    [self.iv_icon sd_setImageWithURL:[NSURL URLWithString:model.ico]];
    self.lb_name.text = model.name;
    self.lb_stateDsc.text = model.rmsg;
    self.lb_rn.text = model.rn;
    self.lb_phn.text = model.ph;
    self.lb_idn.text = model.idn;
    self.lb_rs.text = model.rs;
    
    if (model.st.integerValue == 0) {
        self.lb_state.textColor = kButtonBGColor;
        self.lb_state.text = @"认证审核中...";
    } else if (model.st.integerValue == 1) {
        self.lb_state.textColor = kButtonBGColor;
        self.lb_state.text = @"认证已通过";
    } else if (model.st.integerValue == 2) {
        self.lb_state.textColor = kUIColorFromRGB(0x333333);
        self.lb_state.text = @"认证失败";
    }
    
}

#pragma mark lazyloading

- (UIImageView *)iv_icon {
    if (_iv_icon == nil) {
        _iv_icon = [[UIImageView alloc] init];
        _iv_icon.layer.cornerRadius = 49 * 0.5 * kScale;
        _iv_icon.layer.masksToBounds = YES;
    }
    return _iv_icon;
}

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_name.textColor = kUIColorFromRGB(0x333333);
        _lb_name.numberOfLines = 0;
        _lb_name.preferredMaxLayoutWidth = 90 * kScale;
    }
    return _lb_name;
}

- (UILabel *)lb_state {
    if (_lb_state == nil) {
        _lb_state = [UILabel new];
        _lb_state.font = [UIFont boldSystemFontOfSize:24 * kScale];
    }
    return _lb_state;
}

- (UILabel *)lb_stateDsc {
    if (_lb_stateDsc == nil) {
        _lb_stateDsc = [UILabel new];
        _lb_stateDsc.textColor = kUIColorFromRGB(0x666666);
        _lb_stateDsc.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_stateDsc.numberOfLines = 0;
//        _lb_stateDsc.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH * 0.6;
    }
    return _lb_stateDsc;
}

- (UILabel *)lb_rn {
    if (_lb_rn == nil) {
        _lb_rn = [UILabel new];
        _lb_rn.textColor = kUIColorFromRGB(0x333333);
        _lb_rn.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _lb_rn;
}

- (UILabel *)lb_idn {
    if (_lb_idn == nil) {
        _lb_idn = [UILabel new];
        _lb_idn.font = [UIFont systemFontOfSize:14 * kScale];
        _lb_idn.textColor = kUIColorFromRGB(0x333333);
    }
    return _lb_idn;
}

- (UILabel *)lb_phn {
    if (_lb_phn == nil) {
        _lb_phn = [UILabel new];
        _lb_phn.textColor = kUIColorFromRGB(0x333333);
        _lb_phn.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _lb_phn;
}

- (UILabel *)lb_rs {
    if (_lb_rs == nil) {
        _lb_rs = [UILabel new];
        _lb_rs.numberOfLines = 0;
        _lb_rs.textColor = kUIColorFromRGB(0x333333);
        _lb_rs.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _lb_rs;
}

@end
