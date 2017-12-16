//
//  TaoSkillStockCollectionViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/19.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSkillStockCollectionViewCell.h"
#import "MarketConfig.h"
#import "Defination.h"
#import <Masonry.h>

@interface TaoSkillStockCollectionViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *stockNameLabel;
@property (nonatomic, strong) UILabel *stockZdfLabel;


@end

@implementation TaoSkillStockCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.stockZdfLabel];
    [self.contentView addSubview:self.stockNameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(8 * kScale);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(2 * kScale);
    }];
    
    [self.stockNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.bottom.equalTo(self.contentView).offset(-5 * kScale);
    }];
    
    [self.stockZdfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.bottom.equalTo(self.stockNameLabel);
    }];
    
}

- (void)setName:(NSString *)name count:(NSString *)count stockN:(NSString *)n zdf:(NSString *)zdf {
    if (n == nil) {
        n = @"--";
    }
    _nameLabel.text = name;
    _countLabel.text = [NSString stringWithFormat:@"%zd只",count.integerValue];
    _stockNameLabel.text = n;
    _stockZdfLabel.text = [NSString stringWithFormat:@"%.2lf%%",zdf.floatValue];
    if (zdf.floatValue > 0) {
        _stockZdfLabel.textColor = RISE_COLOR;
    } else if (zdf.floatValue < 0) {
        _stockZdfLabel.textColor = FALL_COLOR;
    } else {
        _stockZdfLabel.textColor = PLAN_COLOR;
    }
}

#pragma mark lzay loading

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = kUIColorFromRGB(0x555555);
        _nameLabel.font = [UIFont boldSystemFontOfSize:14 * kScale];
    }
    return _nameLabel;
}

- (UILabel *)countLabel {
    if (_countLabel == nil) {
        _countLabel = [UILabel new];
        _countLabel.textColor = kUIColorFromRGB(0x358ee7);
        _countLabel.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _countLabel;
}

- (UILabel *)stockNameLabel {
    if (_stockNameLabel == nil) {
        _stockNameLabel = [UILabel new];
        _stockNameLabel.textColor = kUIColorFromRGB(0x555555);
        _stockNameLabel.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _stockNameLabel;
}

- (UILabel *)stockZdfLabel {
    if (_stockZdfLabel == nil) {
        _stockZdfLabel = [UILabel new];
        _stockZdfLabel.textColor = kUIColorFromRGB(0x333333);
        _stockZdfLabel.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _stockZdfLabel;
}



@end
