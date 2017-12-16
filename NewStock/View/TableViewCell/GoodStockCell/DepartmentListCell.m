//
//  DepartmentListCell.m
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "DepartmentListCell.h"
#import "Defination.h"
#import <Masonry.h>
@interface DepartmentListCell ()

@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *rateLb;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *moneyLb;

@end

@implementation DepartmentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return  self;
}

- (void)setupUI {
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.rateLb];
    [self.contentView addSubview:self.typeLb];
    [self.contentView addSubview:self.moneyLb];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.top.equalTo(self.contentView).offset(10 * kScale);
    }];
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.top.equalTo(self.nameLb.mas_bottom).offset(3 * kScale);
    }];
    
    [self.rateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(-18 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-123 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15 * kScale);
    }];
    
    
}

- (void)setModel:(TaoSearchDepartmentListModel *)model {
    _model = model;
    
    self.nameLb.text = model.n;
    self.timeLb.text = model.tm;
    
    self.rateLb.text = [NSString stringWithFormat:@"%.2lf%%",model.zdf.floatValue];
    if (model.zdf.floatValue > 0) {
        self.rateLb.textColor = kUIColorFromRGB(0xff1919);
    } else if (model.zdf.floatValue < 0) {
        self.rateLb.textColor = kUIColorFromRGB(0x009d00);
    } else {
        self.rateLb.textColor = kUIColorFromRGB(0x333333);
    }
    
    self.typeLb.text = model.stn;
    if ([model.stn isEqualToString:@"卖出"]) {
        self.typeLb.textColor = kUIColorFromRGB(0x009d00);
        self.moneyLb.textColor = kUIColorFromRGB(0x009d00);
    } else {
        self.moneyLb.textColor = kUIColorFromRGB(0xff1919);
        self.typeLb.textColor = kUIColorFromRGB(0xff1919);
    }
    
    self.moneyLb.text = [NSString stringWithFormat:@"%.2lf",model.num.floatValue];
    
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x333333);
        _nameLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _nameLb;
}

- (UILabel *)timeLb {
    if (_timeLb == nil) {
        _timeLb = [UILabel new];
        _timeLb.textColor = kUIColorFromRGB(0x808080);
        _timeLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _timeLb;
}

- (UILabel *)rateLb {
    if (_rateLb == nil) {
        _rateLb = [UILabel new];
        _rateLb.textColor = kUIColorFromRGB(0xff1919);
        _rateLb.font = [UIFont boldSystemFontOfSize:17 * kScale];
    }
    return _rateLb;
}

- (UILabel *)typeLb {
    if (_typeLb == nil) {
        _typeLb = [UILabel new];
        _typeLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _typeLb;
}

- (UILabel *)moneyLb {
    if (_moneyLb == nil) {
        _moneyLb = [UILabel new];
        _moneyLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _moneyLb;
}




@end
