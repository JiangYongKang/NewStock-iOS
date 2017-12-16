//
//  TaoQLNGCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoQLNGCell.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"

@interface TaoQLNGCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *cLb;
@property (nonatomic, strong) UILabel *tmLb;

@end

@implementation TaoQLNGCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.cLb];
    [self.contentView addSubview:self.tmLb];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.contentView).offset(12 * kScale);
        make.width.height.equalTo(@(28 * kScale));
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10 * kScale);
        make.centerY.equalTo(self.icon);
    }];
    
    [self.cLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(10 * kScale);
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
    [self.tmLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLb);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
}

- (CGFloat)setUserIcon:(NSString *)icon n:(NSString *)n c:(NSString *)c tm:(NSString *)tm {
    
    if (n == nil) {
        n = @"--";
    }
    
    if (c == nil) {
        c = @"--";
    }
    
    if (tm == nil) {
        tm = @"--";
    }
    
    self.tmLb.text = tm;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:icon]];
    self.nameLb.text = n;
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 5;
    self.cLb.attributedText = [[NSAttributedString alloc] initWithString:c attributes:@{NSParagraphStyleAttributeName : para}];
    self.cLb.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self.cLb sizeToFit];
    [self.contentView layoutIfNeeded];
    
    self.height = CGRectGetMaxY(self.cLb.frame) + 15 * kScale;
    return _height;

}

#pragma mark lazy loading

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.layer.cornerRadius = 14 * kScale;
        _icon.layer.masksToBounds = YES;
        _icon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _icon;
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x358ee7);
        _nameLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _nameLb;
}

- (UILabel *)tmLb {
    if (_tmLb == nil) {
        _tmLb = [UILabel new];
        _tmLb.textColor = kUIColorFromRGB(0x999999);
        _tmLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _tmLb;
}

- (UILabel *)cLb {
    if (_cLb == nil) {
        _cLb = [UILabel new];
        _cLb.textColor = kUIColorFromRGB(0x555555);
        _cLb.font = [UIFont systemFontOfSize:12 * kScale];
        _cLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
        _cLb.numberOfLines = 0;
    }
    return _cLb;
}

@end
