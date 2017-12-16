//
//  TaoIndexBlockTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/3/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoIndexBlockTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>


@interface TaoIndexBlockTableViewCell ()

@property (nonatomic, strong) UILabel *nameLb;

@property (nonatomic, strong) UILabel *valueLb;

@property (nonatomic, strong) UILabel *rateLb;

@end

@implementation TaoIndexBlockTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.rateLb];
    [self.contentView addSubview:self.valueLb];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.valueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    [self.rateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(TaoIndexModelClildStock *)model {
    _model = model;
    
    self.nameLb.text = model.n;
    self.valueLb.text = [NSString stringWithFormat:@"%.2lf",model.zx.floatValue];
    self.rateLb.text = [NSString stringWithFormat:@"%.2lf%%",model.zdf.floatValue];
    
    if (model.zdf.floatValue > 0) {
        self.valueLb.textColor = kUIColorFromRGB(0xff1919);
        self.rateLb.textColor = kUIColorFromRGB(0xff1919);
    } else if (model.zdf.floatValue < 0) {
        self.valueLb.textColor = kUIColorFromRGB(0x009d00);
        self.rateLb.textColor = kUIColorFromRGB(0x009d00);
    } else {
        self.valueLb.textColor = kUIColorFromRGB(0x333333);
        self.rateLb.textColor = kUIColorFromRGB(0x333333);
    }
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x333333);
        _nameLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _nameLb;
}

- (UILabel *)valueLb {
    if (_valueLb == nil) {
        _valueLb = [UILabel new];
        _valueLb.textColor = kUIColorFromRGB(0xff1919);
        _valueLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _valueLb;
}

- (UILabel *)rateLb {
    if (_rateLb == nil) {
        _rateLb = [UILabel new];
        _rateLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
        _rateLb.textColor = kUIColorFromRGB(0xff1919);
    }
    return _rateLb;
}

@end
