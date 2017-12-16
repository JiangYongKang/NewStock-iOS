//
//  MomentAdHeadCell.m
//  NewStock
//
//  Created by 王迪 on 2017/5/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentAdHeadCell.h"
#import "Defination.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface MomentAdHeadCell ()

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UIView *coverView;

@end

@implementation MomentAdHeadCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.img];
    [self.contentView addSubview:self.coverView];
    [self.contentView addSubview:self.titleLb];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(30 * kScale));
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coverView);
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-50 * kScale);
    }];
}

- (void)setModel:(AdListItemModel *)model {
    _model = model;
    self.titleLb.text = model.tt;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.img]];
}

#pragma mark

- (UILabel *)titleLb {
    if (_titleLb == nil) {
        _titleLb = [UILabel new];
        _titleLb.textColor = kUIColorFromRGB(0xffffff);
        _titleLb.font = [UIFont systemFontOfSize:15 * kScale];
    }
    return _titleLb;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [UIView new];
        _coverView.backgroundColor = kUIColorFromRGB(0x000000);
        _coverView.alpha = 0.4;
    }
    return _coverView;
}

- (UIImageView *)img {
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        _img.contentMode = UIViewContentModeScaleAspectFill;
        _img.clipsToBounds = YES;
    }
    return _img;
}

@end
