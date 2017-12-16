//
//  WDHorButton.m
//  NewStock
//
//  Created by 王迪 on 2017/3/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "WDHorButton.h"
#import "Defination.h"
#import <Masonry.h>

@interface WDHorButton ()

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation WDHorButton

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

- (void)setupUI {
    [self addSubview:self.titleLb];
    [self addSubview:self.imgView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-5 * kScale);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12 * kScale);
        make.centerY.equalTo(self);
    }];
    
}

- (UILabel *)titleLb {
    if (_titleLb == nil) {
        _titleLb = [UILabel new];
        _titleLb.font = [UIFont systemFontOfSize:12 * kScale];
        _titleLb.textColor = kUIColorFromRGB(0x666666);
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
