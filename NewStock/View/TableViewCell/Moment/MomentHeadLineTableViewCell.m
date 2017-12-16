//
//  MomentHeadLineTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/5/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentHeadLineTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "Defination.h"
#import "SystemUtil.h"
#import <Masonry.h>

@interface MomentHeadLineTableViewCell ()

@property (nonatomic, strong) UILabel *lb_source;
@property (nonatomic, strong) UILabel *lb_time;
@property (nonatomic, strong) UILabel *lb_title;

@property (nonatomic, strong) UIImageView *singleImg;
@property (nonatomic, strong) UIImageView *iv1;
@property (nonatomic, strong) UIImageView *iv2;
@property (nonatomic, strong) UIImageView *iv3;

@end

@implementation MomentHeadLineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.iv1];
    [self.contentView addSubview:self.iv2];
    [self.contentView addSubview:self.iv3];
    [self.contentView addSubview:self.singleImg];
    [self.contentView addSubview:self.lb_time];
    [self.contentView addSubview:self.lb_title];
    [self.contentView addSubview:self.lb_source];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);//124
        make.top.equalTo(self.contentView).offset(15 * kScale);
    }];
    
    [self.lb_source mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.bottom.equalTo(self.contentView).offset(-15 * kScale);
    }];

    [self.lb_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_source.mas_right).offset(5 * kScale);
        make.bottom.equalTo(self.lb_source);
    }];
    
    [self.singleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(100 * kScale));
        make.height.equalTo(@(70 * kScale));
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(self.lb_title);
    }];
    
    [self.iv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(109 * kScale));
        make.height.equalTo(@(62 * kScale));
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.lb_title.mas_bottom).offset(15 * kScale);
    }];
    
    [self.iv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.iv1);
        make.top.equalTo(self.iv1);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.iv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.iv1);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(self.iv1);
    }];
    
}

- (void)setModel:(FeedListModel *)model {
    _model = model;
    [self dealWithImg:model];
    self.lb_title.text = model.tt;
    if (model.tm) {
        self.lb_time.text = [SystemUtil getDateString:model.tm];
    }
    
    self.lb_source.text = model.sr;
    if (model.imgs.count == 1 || model.imgs.count == 2) {
        [self.singleImg sd_setImageWithURL:[NSURL URLWithString:model.imgs[0][@"origin"]]];
    } else if (model.imgs.count >= 3) {
        [self.iv1 sd_setImageWithURL:[NSURL URLWithString:model.imgs[0][@"origin"]]];
        [self.iv2 sd_setImageWithURL:[NSURL URLWithString:model.imgs[1][@"origin"]]];
        [self.iv3 sd_setImageWithURL:[NSURL URLWithString:model.imgs[2][@"origin"]]];
    }
}

- (void)dealWithImg:(FeedListModel *)model {
    if (model.imgs.count >= 3) {
        _iv1.hidden = NO;
        _iv2.hidden = NO;
        _iv3.hidden = NO;
        _singleImg.hidden = YES;
        [_iv1 sd_setImageWithURL:[NSURL URLWithString:model.imgs[0][@"origin"]]];
        [_iv2 sd_setImageWithURL:[NSURL URLWithString:model.imgs[1][@"origin"]]];
        [_iv3 sd_setImageWithURL:[NSURL URLWithString:model.imgs[2][@"origin"]]];
        _lb_title.numberOfLines = 1;
        [self.lb_title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-12 * kScale);//124
        }];
    } else if (model.imgs.count > 0) {
        _iv1.hidden = YES;
        _iv2.hidden = YES;
        _iv3.hidden = YES;
        _singleImg.hidden = NO;
        [_singleImg sd_setImageWithURL:[NSURL URLWithString:model.imgs[0][@"origin"]]];
        _lb_title.numberOfLines = 2;
        [self.lb_title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-124 * kScale);//124
        }];
    } else {
        _iv1.hidden = YES;
        _iv2.hidden = YES;
        _iv3.hidden = YES;
        _singleImg.hidden = YES;
        _lb_title.numberOfLines = 2;
        [self.lb_title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-12 * kScale);//124
        }];
    }
}

#pragma mark action

- (void)tap:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    if (![self.delegate respondsToSelector:@selector(MomentHeadLineTableViewCellPhotoDelegate:andIndex:)]) {
        return;
    }
    
    if (index == 4) {
        if (self.singleImg.image != nil) {
            [self.delegate MomentHeadLineTableViewCellPhotoDelegate:@[_singleImg] andIndex:0];
        }
    } else {
        if (_iv1.image != nil && _iv2.image != nil && _iv3.image != nil) {
            [self.delegate MomentHeadLineTableViewCellPhotoDelegate:@[_iv1,_iv2,_iv3] andIndex:index];
        }
    }
}

#pragma mark lazyloading

- (UILabel *)lb_source {
    if (_lb_source == nil) {
        _lb_source = [UILabel new];
        _lb_source.textAlignment = NSTextAlignmentLeft;
        _lb_source.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_source.backgroundColor = [UIColor whiteColor];
        _lb_source.layer.masksToBounds = YES;
        _lb_source.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _lb_source;
}

- (UILabel *)lb_time {
    if (_lb_time == nil) {
        _lb_time = [UILabel new];
        _lb_time.backgroundColor = [UIColor whiteColor];
        _lb_time.layer.masksToBounds = YES;
        _lb_time.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_time.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _lb_time;
}

- (UILabel *)lb_title {
    if (_lb_title == nil) {
        _lb_title = [UILabel new];
        _lb_title.backgroundColor = [UIColor whiteColor];
        _lb_title.layer.masksToBounds = YES;
        _lb_title.textColor = kUIColorFromRGB(0x333333);
        _lb_title.font = [UIFont systemFontOfSize:17 * kScale];
        _lb_title.numberOfLines = 2;
    }
    return _lb_title;
}

- (UIImageView *)singleImg {
    if (_singleImg == nil) {
        _singleImg = [UIImageView new];
        _singleImg.contentMode = UIViewContentModeScaleAspectFill;
        _singleImg.clipsToBounds = YES;
        _singleImg.userInteractionEnabled = YES;
        _singleImg.tag = 4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_singleImg addGestureRecognizer:tap];
    }
    return _singleImg;
}

- (UIImageView *)iv1 {
    if (_iv1 == nil) {
        _iv1 = [UIImageView new];
        _iv1.contentMode = UIViewContentModeScaleAspectFill;
        _iv1.userInteractionEnabled = YES;
        _iv1.clipsToBounds = YES;
        _iv1.tag = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_iv1 addGestureRecognizer:tap];
    }
    return _iv1;
}

- (UIImageView *)iv2 {
    if (_iv2 == nil) {
        _iv2 = [UIImageView new];
        _iv2.contentMode = UIViewContentModeScaleAspectFill;
        _iv2.userInteractionEnabled = YES;
        _iv2.clipsToBounds = YES;
        _iv2.tag = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_iv2 addGestureRecognizer:tap];
    }
    return _iv2;
}

- (UIImageView *)iv3 {
    if (_iv3 == nil) {
        _iv3 = [UIImageView new];
        _iv3.contentMode = UIViewContentModeScaleAspectFill;
        _iv3.userInteractionEnabled = YES;
        _iv3.clipsToBounds = YES;
        _iv3.tag = 2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_iv3 addGestureRecognizer:tap];
    }
    return _iv3;
}


@end
