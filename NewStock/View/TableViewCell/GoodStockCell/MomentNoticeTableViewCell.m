//
//  MomentNoticeTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/3/31.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentNoticeTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "Defination.h"
#import <Masonry.h>

@interface MomentNoticeTableViewCell ()

@property (nonatomic ,strong) UIImageView *icon;
@property (nonatomic ,strong) UILabel *nameLb;
@property (nonatomic ,strong) UILabel *contentLb;
@property (nonatomic ,strong) UILabel *dscLb;
@property (nonatomic ,strong) UILabel *timeLb;

@property (nonatomic ,strong) UIView *coverView;

@end

@implementation MomentNoticeTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.contentLb];
    [self.contentView addSubview:self.dscLb];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.coverView];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(40 * kScale));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12 * kScale);
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10 * kScale);
        make.left.equalTo(self.icon.mas_right).offset(10 * kScale);
    }];
    
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.centerY.equalTo(self.contentView).offset(4);
        make.right.equalTo(self.contentView).offset(-85 * kScale);
    }];
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.bottom.equalTo(self.contentView).offset(-6 * kScale);
    }];
    
    [self.dscLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.contentView bringSubviewToFront:self.coverView];
}

- (void)setModel:(MomentNoticeModel *)model {
    _model = model;
    
    self.nameLb.text = model.n;
    if (model.tm.length > 6) {
        self.timeLb.text = [model.tm substringFromIndex:5];
    } else {
        self.timeLb.text = model.tm;
    }
    
    self.contentLb.text = model.dsc;
    self.dscLb.text = model.c;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.origin]];
    
    if (model.st.integerValue == 0) {
        self.coverView.hidden = YES;
    } else {
        self.coverView.hidden = NO;
    }
    
}

#pragma mark lazy

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.layer.cornerRadius = 20 * kScale;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x333333);
        _nameLb.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _nameLb;
}

- (UILabel *)contentLb {
    if (_contentLb == nil) {
        _contentLb = [UILabel new];
        _contentLb.textColor = kUIColorFromRGB(0x666666);
        _contentLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _contentLb;
}

- (UILabel *)timeLb {
    if (_timeLb == nil) {
        _timeLb = [UILabel new];
        _timeLb.font = [UIFont systemFontOfSize:11 * kScale];
        _timeLb.textColor = kUIColorFromRGB(0xb2b2b2);
    }
    return _timeLb ;
}

- (UILabel *)dscLb {
    if (_dscLb == nil) {
        _dscLb = [UILabel new];
        _dscLb.textColor = kUIColorFromRGB(0x333333);
        _dscLb.font = [UIFont systemFontOfSize:12 * kScale];
        _dscLb.numberOfLines = 3;
        _dscLb.preferredMaxLayoutWidth = 65 * kScale;
    }
    return _dscLb;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
        _coverView.hidden = YES;
    }
    return _coverView;
}

@end
