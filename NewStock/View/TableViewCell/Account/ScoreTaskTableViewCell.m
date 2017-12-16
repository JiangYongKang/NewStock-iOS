//
//  ScoreTaskTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/4/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ScoreTaskTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface ScoreTaskTableViewCell ()

@property (nonatomic, strong) UILabel *leftLb;

@property (nonatomic, strong) UILabel *centerLb;

@property (nonatomic, strong) UILabel *rightLb;

@end

@implementation ScoreTaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {

    [self.contentView addSubview:self.leftLb];
    [self.contentView addSubview:self.centerLb];
    [self.contentView addSubview:self.rightLb];
    
    [self.leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12 * kScale);
    }];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
    }];
    
    [self.rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
}

- (void)setLeftStr:(NSString *)leftStr {
    _leftStr = leftStr;
    self.leftLb.text = leftStr;
}

- (void)setCenterStr:(NSString *)centerStr {
    _centerStr = centerStr;
    self.centerLb.text = centerStr;
}

- (void)setIsCompleted:(BOOL)isCompleted {
    _isCompleted = isCompleted;
    if (_isCompleted) {
        self.centerLb.textColor = kUIColorFromRGB(0xb2b2b2);
        self.rightLb.textColor = kUIColorFromRGB(0xb2b2b2);
        self.rightLb.text = @"已获取";
        self.accessoryType = UITableViewCellAccessoryNone;
        [self.rightLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-12 * kScale);
        }];
    } else {
        self.centerLb.textColor = kUIColorFromRGB(0x666666);
        self.rightLb.textColor = kUIColorFromRGB(0x666666);
        self.rightLb.text = @"立即修改";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.rightLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(0 * kScale);
        }];
    }
}

#pragma mark lazyloading

- (UILabel *)leftLb {
    if (_leftLb == nil) {
        _leftLb = [UILabel new];
        _leftLb.font = [UIFont systemFontOfSize:14 * kScale];
        _leftLb.textColor = kUIColorFromRGB(0x333333);
    }
    return _leftLb;
}

- (UILabel *)rightLb {
    if (_rightLb == nil) {
        _rightLb = [UILabel new];
        _rightLb.textColor = kUIColorFromRGB(0x666666);
        _rightLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _rightLb;
}

- (UILabel *)centerLb {
    if (_centerLb == nil) {
        _centerLb = [UILabel new];
        _centerLb.textColor = kUIColorFromRGB(0x666666);
        _centerLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _centerLb;
}

@end
