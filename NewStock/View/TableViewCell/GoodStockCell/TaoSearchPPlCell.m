//
//  TaoSearchPPlCell.m
//  NewStock
//
//  Created by 王迪 on 2017/3/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchPPlCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface TaoSearchPPlCell ()

@property (nonatomic ,strong) UILabel *nameLb;
@property (nonatomic ,strong) UILabel *codeLb;
@property (nonatomic ,strong) UILabel *holdCountLb;
@property (nonatomic ,strong) UILabel *valueLb;
@property (nonatomic ,strong) UILabel *bdLb;

@property (nonatomic, strong) UILabel *pplLb;

@end

@implementation TaoSearchPPlCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.pplLb];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.codeLb];
    [self.contentView addSubview:self.holdCountLb];
    [self.contentView addSubview:self.valueLb];
    [self.contentView addSubview:self.bdLb];
    
    [self.pplLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.top.equalTo(self.contentView).offset(12 * kScale);
    }];
    
    [self.codeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.top.equalTo(self.nameLb.mas_bottom).offset(3 * kScale);
    }];
    
    [self.holdCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(-1 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.valueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(25 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.bdLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15 * kScale);
    }];

}

- (void)setModel:(TaoSearchPPlListModel *)model {
    _model = model;
    
    if (model.s.length) {
        self.nameLb.text = model.n;
        self.codeLb.text = model.s;
        self.pplLb.text = @"";
    } else {
        self.nameLb.text = @"";
        self.codeLb.text = @"";
        self.pplLb.text = model.n;
        self.pplLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    
    if (model.cn.floatValue >= 10000) {
        self.holdCountLb.text = [NSString stringWithFormat:@"%.2lf亿",model.cn.floatValue/10000];
    } else {
        self.holdCountLb.text = [NSString stringWithFormat:@"%.2lf万",model.cn.floatValue];
    }
    
    if (model.sum.floatValue >= 10000) {
        self.valueLb.text = [NSString stringWithFormat:@"%.2lf亿",model.sum.floatValue / 10000];
    } else {
        self.valueLb.text = [NSString stringWithFormat:@"%.2lf万",model.sum.floatValue];
    }
    
    self.bdLb.text = model.bd;
    
    if ([model.bd containsString:@"增持"]) {
        self.bdLb.textColor = kUIColorFromRGB(0xff1919);
    } else if ([model.bd containsString:@"减持"]) {
        self.bdLb.textColor = kUIColorFromRGB(0x009d00);
    } else {
        self.bdLb.textColor = kUIColorFromRGB(0x333333);
    }
}

#pragma mark 

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x333333);
        _nameLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _nameLb;
}

- (UILabel *)codeLb {
    if (_codeLb == nil) {
        _codeLb = [UILabel new];
        _codeLb.textColor = kUIColorFromRGB(0x808080);
        _codeLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _codeLb;
}

- (UILabel *)holdCountLb {
    if (_holdCountLb == nil) {
        _holdCountLb = [UILabel new];
        _holdCountLb.textColor = kUIColorFromRGB(0x333333);
        _holdCountLb.font = [UIFont boldSystemFontOfSize:17 * kScale];
    }
    return _holdCountLb;
}

- (UILabel *)valueLb {
    if (_valueLb == nil) {
        _valueLb = [UILabel new];
        _valueLb.textColor = kUIColorFromRGB(0x333333);
        _valueLb.font = [UIFont boldSystemFontOfSize:17 * kScale];
    }
    return _valueLb;
}

- (UILabel *)bdLb {
    if (_bdLb == nil) {
        _bdLb = [UILabel new];
        _bdLb.font = [UIFont boldSystemFontOfSize:17 * kScale];
    }
    return _bdLb;
}

- (UILabel *)pplLb {
    if (_pplLb == nil) {
        _pplLb = [UILabel new];
        _pplLb.textColor = kUIColorFromRGB(0x358ee7);
        _pplLb.font = [UIFont systemFontOfSize:16 * kScale];
        _pplLb.numberOfLines = 2;
        _pplLb.preferredMaxLayoutWidth = 80 * kScale;
    }
    return _pplLb;
}


@end
