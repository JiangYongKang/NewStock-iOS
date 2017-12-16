//
//  TaoCommedTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/23.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoCommedTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface TaoCommedTableViewCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *cLb;

@end

@implementation TaoCommedTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.icon];
    [self addSubview:self.nameLb];
    [self addSubview:self.cLb];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12 * kScale);
        make.top.equalTo(self).offset(12 * kScale);
        make.width.height.equalTo(@(28 * kScale));
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10 * kScale);
        make.centerY.equalTo(self.icon);
    }];
    
    [self.cLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(10 * kScale);
        make.left.equalTo(self).offset(12 * kScale);
        make.right.equalTo(self).offset(-12 * kScale);
    }];
    
}

- (CGFloat)setUserIcon:(NSString *)icon n:(NSString *)n c:(NSString *)c {
    
    if (n == nil) {
        n = @"--";
    }
    
    if (c == nil) {
        c = @"--";
    }
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:icon]];
    self.nameLb.text = n;
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 5;
    self.cLb.attributedText = [[NSAttributedString alloc] initWithString:c attributes:@{NSParagraphStyleAttributeName : para}];
    self.cLb.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self.cLb sizeToFit];
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
