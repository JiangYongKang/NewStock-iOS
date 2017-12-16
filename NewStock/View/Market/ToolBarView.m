//
//  ToolBarView.m
//  NewStock
//
//  Created by Willey on 16/8/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ToolBarView.h"
#import "Masonry.h"
#import "Defination.h"
#import "MarketConfig.h"
#import <UIImageView+WebCache.h>
#import "UserInfoInstance.h"

@interface ToolBarView ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIImageView *leftViewImg;

@property (nonatomic, strong) UIImageView *iv_secret;
@property (nonatomic, strong) UIImageView *iv_real;

@property (nonatomic, strong) UILabel *lb_secret;
@property (nonatomic, strong) UILabel *lb_real;

@property (nonatomic, strong) UIImageView *iv_choose1;
@property (nonatomic, strong) UIImageView *iv_choose2;

@end

@implementation ToolBarView
@synthesize delegate;

- (id)initWithType:(TOOLBAR_TYPE)type {
    self = [super init];
    if (self) {
        self.backgroundColor = kUIColorFromRGB(0xffffff);
        self.type = type;
        
        UIView *topView = [[UIView alloc] init];
        [self addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(@(TOOL_BAR_HEIGHT));
        }];
        
        _tf = [[UITextField alloc] init];
        _tf.backgroundColor = [UIColor whiteColor];
        _tf.placeholder = @"说点什么吧...";
        [_tf setValue:kUIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
        [_tf setValue:[UIFont systemFontOfSize:16 * kScale] forKeyPath:@"_placeholderLabel.font"];
        _tf.delegate = self;
        [topView addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView).offset(7);
            make.right.equalTo(topView).offset(-10);
            make.left.equalTo(topView).offset(45);
            make.bottom.equalTo(topView).offset(-7);
        }];
        
        _tf.borderStyle = UITextBorderStyleRoundedRect;
        UIButton *emotionBtn = [[UIButton alloc] init];
        [emotionBtn setImage:[UIImage imageNamed:@"ic_biaoqing_nor"] forState:UIControlStateNormal];
        [emotionBtn addTarget:self action:@selector(emotionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:emotionBtn];
        [emotionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_tf);
            make.left.equalTo(topView).offset(10);
        }];
        
        if (type == TOOLBAR_TYPE_COMMENT_AMS) {
            [self setupAMSUI];
        }
    }
    return self;
}

- (void)setupAMSUI {
    
    if ([UserInfoInstance sharedUserInfoInstance].isAMS == NO) {
        [self.leftViewImg sd_setImageWithURL:[NSURL URLWithString:LOGO_SECRET]];
        self.iv_choose2.hidden = YES;
        [self setPlaceHolderStr:@"匿名评论"];
    } else {
        [self.leftViewImg sd_setImageWithURL:[NSURL URLWithString:[UserInfoInstance sharedUserInfoInstance].userInfoModel.origin]];
        self.iv_choose1.hidden = YES;
        [self setPlaceHolderStr:[UserInfoInstance sharedUserInfoInstance].userInfoModel.n];
    }
    
    _tf.leftView = self.leftView;
    _tf.leftViewMode = UITextFieldViewModeAlways;
    self.leftView.frame = CGRectMake(0, 0, 30, 0);
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    bottomView.layer.masksToBounds = YES;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(TOOL_BAR_HEIGHT);
    }];
    
    [bottomView addSubview:self.iv_secret];
    [bottomView addSubview:self.iv_real];
    [bottomView addSubview:self.lb_real];
    [bottomView addSubview:self.lb_secret];
    [bottomView addSubview:self.iv_choose1];
    [bottomView addSubview:self.iv_choose2];
    
    [self.iv_secret mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView).offset(-15);
        make.centerX.equalTo(bottomView).offset(-70 * kScale);
        make.width.height.equalTo(@(60 * kScale));
    }];
    
    [self.lb_secret mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iv_secret);
        make.top.equalTo(self.iv_secret.mas_bottom).offset(6 * kScale);
    }];
    
    [self.iv_choose1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.iv_secret);
    }];
    
    [self.iv_real mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.iv_secret);
        make.centerX.equalTo(bottomView).offset(70 * kScale);
    }];
    
    [self.lb_real mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iv_real);
        make.top.equalTo(self.iv_real.mas_bottom).offset(6 * kScale);
    }];
    
    [self.iv_choose2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.iv_real);
    }];
    
}

- (void)setPlaceHolderStr:(NSString *)placeHolderStr {
    _placeHolderStr = placeHolderStr;
    
    CGFloat offset = -1 * kScale;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:placeHolderStr attributes:@{
                                                                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],
                                                                                                                                     NSBaselineOffsetAttributeName : @(offset),
                                                                                                                                     }];
    
    _tf.attributedPlaceholder = attributedString;
}

#pragma mark - Button Actions

- (void)secretTap:(UITapGestureRecognizer *)tap {
    self.iv_choose1.hidden = NO;
    self.iv_choose2.hidden = YES;
    [self.leftViewImg sd_setImageWithURL:[NSURL URLWithString:LOGO_SECRET]];
    [UserInfoInstance sharedUserInfoInstance].isAMS = NO;
    [self setPlaceHolderStr:@"匿名评论"];
}

- (void)realTap:(UITapGestureRecognizer *)tap {
    self.iv_choose1.hidden = YES;
    self.iv_choose2.hidden = NO;
    [self.leftViewImg sd_setImageWithURL:[NSURL URLWithString:[UserInfoInstance sharedUserInfoInstance].userInfoModel.origin]];
    [UserInfoInstance sharedUserInfoInstance].isAMS = YES;
    [self setPlaceHolderStr:[UserInfoInstance sharedUserInfoInstance].userInfoModel.n];
}

- (void)chooseTap:(UITapGestureRecognizer *)tap {
    if ([delegate respondsToSelector:@selector(toolBarView:actionIndex:)]) {
        [delegate toolBarView:self actionIndex:TOOLBAR_ACTION_CHOOSE_AMS];
    }
}

- (void)emotionBtnClick:(UIButton *)btn {
    self.isEmoticomAction = YES;
    if([delegate respondsToSelector:@selector(toolBarView:actionIndex:)]) {
        [delegate toolBarView:self actionIndex:TOOLBAR_ACTION_REPLY];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.isEmoticomAction = NO;
    if([delegate respondsToSelector:@selector(toolBarView:actionIndex:)]) {
        [delegate toolBarView:self actionIndex:TOOLBAR_ACTION_REPLY];
    }
    return NO;
}

#pragma mark lazyloading

- (UIImageView *)leftViewImg {
    if (_leftViewImg == nil) {
        _leftViewImg = [[UIImageView alloc] init];
        _leftViewImg.layer.cornerRadius = 12;
        _leftViewImg.layer.masksToBounds = YES;
    }
    return _leftViewImg;
}

- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [UIView new];
        UIImageView *rbIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_amsRb_nor"]];
        [_leftView addSubview:rbIv];
        
        [rbIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_leftView).offset(13);
            make.centerY.equalTo(_leftView).offset(10);
        }];
        _leftView.backgroundColor = [UIColor greenColor];
        [_leftView addSubview:self.leftViewImg];
        [self.leftViewImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_leftView);
            make.left.equalTo(_leftView).offset(6 * kScale);
            make.width.height.equalTo(@(24));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTap:)];
        [_leftView addGestureRecognizer:tap];
    }
    return _leftView;
}

- (UIImageView *)iv_secret {
    if (_iv_secret == nil) {
        _iv_secret = [UIImageView new];
        _iv_secret.layer.cornerRadius = 30 * kScale;
        _iv_secret.layer.masksToBounds = YES;
        [_iv_secret sd_setImageWithURL:[NSURL URLWithString:LOGO_SECRET]];
        _iv_secret.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secretTap:)];
        [_iv_secret addGestureRecognizer:tap];
    }
    return _iv_secret;
}

- (UIImageView *)iv_real {
    if (_iv_real == nil) {
        _iv_real = [UIImageView new];
        [_iv_real sd_setImageWithURL:[NSURL URLWithString:[UserInfoInstance sharedUserInfoInstance].userInfoModel.origin]];
        _iv_real.layer.cornerRadius = 30 * kScale;
        _iv_real.layer.masksToBounds = YES;
        _iv_real.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(realTap:)];
        [_iv_real addGestureRecognizer:tap];
    }
    return _iv_real;
}

- (UILabel *)lb_secret {
    if (_lb_secret == nil) {
        _lb_secret = [UILabel new];
        _lb_secret.text = @"匿名";
        _lb_secret.font = [UIFont systemFontOfSize:14 * kScale];
        _lb_secret.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_secret.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secretTap:)];
        [_lb_secret addGestureRecognizer:tap];
    }
    return _lb_secret;
}

- (UILabel *)lb_real {
    if (_lb_real == nil) {
        _lb_real = [UILabel new];
        _lb_real.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_real.font = [UIFont systemFontOfSize:14 * kScale];
        _lb_real.text = [UserInfoInstance sharedUserInfoInstance].userInfoModel.n;
        _lb_real.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(realTap:)];
        [_lb_real addGestureRecognizer:tap];
    }
    return _lb_real;
}

- (UIImageView *)iv_choose1 {
    if (_iv_choose1 == nil) {
        _iv_choose1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_ams_choose_nor"]];
    }
    return _iv_choose1;
}

- (UIImageView *)iv_choose2 {
    if (_iv_choose2 == nil) {
        _iv_choose2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_ams_choose_nor"]];
    }
    return _iv_choose2;
}

@end
