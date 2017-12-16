//
//  WDButton.m
//  NewStock
//
//  Created by 王迪 on 2017/1/11.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "WDButton.h"
#import <Masonry.h>
#import "Defination.h"

@interface WDButton ()

@property (nonatomic, strong) UIImageView *bigVImg;

@property (nonatomic, strong) UIView *coverView;

@end

@implementation WDButton

- (UIImageView *)bigVImg {
    if (_bigVImg == nil) {
        _bigVImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_forumTop_nor"]];
    }
    return _bigVImg;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = kUIColorFromRGB(0xffffff);
        _coverView.alpha = 0.6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPBigV" object:nil];
}

- (UILabel *)custom_lb {
    if (_custom_lb == nil) {
        _custom_lb = [UILabel new];
        _custom_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _custom_lb;
}

- (UIImageView *)custom_img {
    if (_custom_img == nil) {
        _custom_img = [[UIImageView alloc]init];
    }
    return _custom_img;
}

- (instancetype)init {

    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setIsBigV:(BOOL)isBigV {
    
    _isBigV = isBigV;
    
    if (_isBigV == YES) {
        [self.coverView removeFromSuperview];
        [self.bigVImg removeFromSuperview];
        return;
    }
    
    [self addSubview:self.coverView];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.bigVImg];
    [self.bigVImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
    }];
}


- (void)setupUI {

    [self addSubview:self.custom_lb];
    [self addSubview:self.custom_img];
    
    [self.custom_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-12 * kScale);
    }];
    
    [self.custom_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(15 * kScale);
    }];
    
}


@end
