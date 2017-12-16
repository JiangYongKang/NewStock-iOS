//
//  AccountCenterTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/4/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "AccountCenterTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "Defination.h"

@interface AccountCenterTableViewCell ()

@property (nonatomic, strong) UIImageView *leftImg;

@property (nonatomic, strong) UILabel *leftLb;

@property (nonatomic, strong) UILabel *rightLb;

//@property (nonatomic, strong) UIImageView *right;

@end

@implementation AccountCenterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.leftImg];
    [self.contentView addSubview:self.leftLb];
    [self.contentView addSubview:self.rightLb];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@(21 * kScale));
    }];
    
    [self.leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).offset(8 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-0 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setLeftStr:(NSString *)leftStr {
    _leftStr = leftStr;
    self.leftLb.text = leftStr;
}

- (void)setRightStr:(NSString *)rightStr {
    _rightStr = rightStr;
    self.rightLb.text = rightStr;
}

- (void)setImageStr:(NSString *)imageStr {
    _imageStr = imageStr;
    self.leftImg.image = [UIImage imageNamed:imageStr];
}

- (UIImageView *)leftImg {
    if (_leftImg == nil) {
        _leftImg = [UIImageView new];
        _leftImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImg;
}

- (UILabel *)leftLb {
    if (_leftLb == nil) {
        _leftLb = [UILabel new];
        _leftLb.textColor = kUIColorFromRGB(0x333333);
        _leftLb.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _leftLb;
}

- (UILabel *)rightLb {
    if (_rightLb == nil) {
        _rightLb = [UILabel new];
        _rightLb.font = [UIFont systemFontOfSize:11 * kScale];
        _rightLb.textColor = kUIColorFromRGB(0xb2b2b2);
    }
    return _rightLb;
}

@end
