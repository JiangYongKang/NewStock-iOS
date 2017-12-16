//
//  MainLinkButton.m
//  NewStock
//
//  Created by 王迪 on 2017/3/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainLinkButton.h"
#import "Defination.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainLinkButton ()

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation MainLinkButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLb.text = title;
}

- (void)setImgStr:(NSString *)imgStr {
    _imgStr = imgStr;
    
    self.imgView.image = [UIImage imageNamed:imgStr];
}

- (void)setImgURL:(NSString *)imgURL {
    _imgURL = imgURL;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgURL]];
}

- (void)setupUI {
    [self addSubview:self.titleLb];
    [self addSubview:self.imgView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-19 * kScale);
        make.width.equalTo(@(45 * kScale));
        make.height.equalTo(@(45 * kScale));
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self).offset(17 * kScale);
    }];
    
}

- (UILabel *)titleLb {
    if (_titleLb == nil) {
        _titleLb = [UILabel new];
        _titleLb.font = [UIFont systemFontOfSize:13 * kScale];
        _titleLb.textColor = kUIColorFromRGB(0x333333);
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

@end
