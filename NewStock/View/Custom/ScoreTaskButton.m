//
//  ScoreTaskButton.m
//  NewStock
//
//  Created by 王迪 on 2017/4/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ScoreTaskButton.h"
#import "Defination.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface ScoreTaskButton ()

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UILabel *centerLb;

@property (nonatomic, strong) UILabel *bottomLb;

@end

@implementation ScoreTaskButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.topImageView];
    [self addSubview:self.centerLb];
    [self addSubview:self.bottomLb];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(0 * kScale);
        make.width.height.equalTo(@(40 * kScale));
    }];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.topImageView.mas_bottom).offset(15 * kScale);
    }];
    
    [self.bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.centerLb.mas_bottom).offset(6 * kScale);
    }];
    
}

- (void)setImgStr:(NSString *)imgStr {
    _imgStr = imgStr;
    self.topImageView.image = [UIImage imageNamed:imgStr];
}

- (void)setBottomLbStr:(NSString *)bottomLbStr {
    _bottomLbStr = bottomLbStr;
    self.bottomLb.text = bottomLbStr;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

- (void)setCenterStr:(NSString *)centerStr {
    _centerStr = centerStr;
    self.centerLb.text = centerStr;
}

- (void)setIsCompleted:(BOOL)isCompleted {
    _isCompleted = isCompleted;
    
    if (_isCompleted) {
        self.centerLb.textColor = kTitleColor;
        self.bottomLb.textColor = kTitleColor;
    } else {
        self.centerLb.textColor = kUIColorFromRGB(0x666666);
        self.bottomLb.textColor = kUIColorFromRGB(0x999999);
    }
}

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [UIImageView new];
    }
    return _topImageView;
}

- (UILabel *)centerLb {
    if (_centerLb == nil) {
        _centerLb = [UILabel new];
        _centerLb.textColor = kUIColorFromRGB(0x666666);
        _centerLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _centerLb;
}

- (UILabel *)bottomLb {
    if (_bottomLb == nil) {
        _bottomLb = [UILabel new];
        _bottomLb.textColor = kUIColorFromRGB(0x999999);
        _bottomLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:11 * kScale];
    }
    return _bottomLb;
}

@end
