//
//  TaoIndexDataCenterCollectionViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoIndexDataCenterCollectionViewCell.h"
#import "Defination.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface TaoIndexDataCenterCollectionViewCell ()

@property (nonatomic, strong) UIImageView *ico;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, copy) NSString *url;

@end

@implementation TaoIndexDataCenterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.ico];
    [self.contentView addSubview:self.nameLabel];
    
    [self.ico mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.height.equalTo(@(38 * kScale));
        make.top.equalTo(self.contentView).offset(10 * kScale);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10 * kScale);
        make.centerX.equalTo(self.contentView);
    }];
    
}


- (void)setUrl:(NSString *)url ico:(NSString *)ico name:(NSString *)name {
//    ico = @"https://guguaixia-product.oss-cn-shanghai.aliyuncs.com/static/img/ic_hushen@3x.png";
    [self.ico sd_setImageWithURL:[NSURL URLWithString:ico]];
    self.nameLabel.text = name;
    _url = url;
}

#pragma mark lazt loading

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = kUIColorFromRGB(0x808080);
        _nameLabel.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _nameLabel;
}

- (UIImageView *)ico {
    if (_ico == nil) {
        _ico = [[UIImageView alloc] init];
        _ico.layer.masksToBounds = YES;
        _ico.layer.cornerRadius = 19 * kScale;
        _ico.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _ico;
}

@end
