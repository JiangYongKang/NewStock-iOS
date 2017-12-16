//
//  MyHoldStockCell.m
//  NewStock
//
//  Created by 王迪 on 2017/1/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyHoldStockCell.h"
#import <Masonry.h>
#import "Defination.h"

@interface MyHoldStockCell ()

@property (nonatomic, strong) UILabel *lb_namel;
@property (nonatomic, strong) UILabel *lb_value;
@property (nonatomic, strong) UILabel *lb_earn;
@property (nonatomic, strong) UILabel *lb_earnRate;
@property (nonatomic, strong) UILabel *lb_hold;
@property (nonatomic, strong) UILabel *lb_old;
@property (nonatomic, strong) UILabel *lb_new;

@end

@implementation MyHoldStockCell

- (void)setModel:(MyAssetListModel *)model {
    _model = model;
    
    self.lb_namel.text = model.symbolName;
    self.lb_value.text = [NSString stringWithFormat:@"%.2lf",model.marketValue.floatValue];
    if (model.allEarnings.floatValue > 10000) {
        self.lb_earn.text = [NSString stringWithFormat:@"%.2lf(万)",model.allEarnings.floatValue / 10000];
    } else if (model.allEarnings.floatValue > 100000000) {
        self.lb_earn.text = [NSString stringWithFormat:@"%.2lf(亿)",model.allEarnings.floatValue / 100000000];
    } else {
        self.lb_earn.text = [NSString stringWithFormat:@"%.2lf",model.allEarnings.floatValue];
    }

    self.lb_earnRate.text = model.amplitude;
    self.lb_hold.text = [NSString stringWithFormat:@"%zd",model.qty.integerValue];
    self.lb_old.text = [NSString stringWithFormat:@"%.2lf",model.inPrice.floatValue];
    self.lb_new.text = [NSString stringWithFormat:@"%.2lf",model.currPrice.floatValue];
    
    if (model.currEarnings.floatValue > 0) {
        self.lb_new.textColor = kUIColorFromRGB(0xff1919);
    } else if (model.currEarnings.floatValue < 0) {
        self.lb_new.textColor = kUIColorFromRGB(0x009d00);
    } else {
        self.lb_new.textColor = kUIColorFromRGB(0x333333);
    }
    
    if (model.amplitude.floatValue > 0) {
        self.lb_earn.textColor = kUIColorFromRGB(0xff1919);
        self.lb_earnRate.textColor = kUIColorFromRGB(0xff1919);
    } else if (model.amplitude.floatValue < 0) {
        self.lb_earn.textColor = kUIColorFromRGB(0x009b00);
        self.lb_earnRate.textColor = kUIColorFromRGB(0x009b00);
    } else {
        self.lb_earn.textColor = kUIColorFromRGB(0x333333);
        self.lb_earnRate.textColor = kUIColorFromRGB(0x333333);
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.lb_namel];
    [self.contentView addSubview:self.lb_value];
    [self.contentView addSubview:self.lb_earn];
    [self.contentView addSubview:self.lb_earnRate];
    [self.contentView addSubview:self.lb_hold];
    [self.contentView addSubview:self.lb_old];
    [self.contentView addSubview:self.lb_new];
    
    CGFloat margin = MAIN_SCREEN_WIDTH / 4;
    
    [self.lb_namel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.top.equalTo(self.contentView).offset(15 * kScale);
    }];
    
    [self.lb_value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.bottom.equalTo(self.contentView).offset(-15 * kScale);
    }];
    
    [self.lb_earn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(margin);
        make.top.equalTo(self.lb_namel);
        make.width.equalTo(@(margin * kScale));
    }];
    
    [self.lb_earnRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(margin);
        make.top.equalTo(self.lb_value);
        make.width.equalTo(@(margin * kScale));
    }];
    
    [self.lb_hold mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(margin * 2);
        make.width.equalTo(@(margin * kScale));
    }];
    
    [self.lb_old mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15 * kScale);
        make.top.equalTo(self.lb_namel);
    }];
    
    [self.lb_new mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lb_old);
        make.bottom.equalTo(self.contentView).offset(-15 * kScale);
    }];
    
    
}

- (UILabel *)lb_namel {
    if (_lb_namel == nil) {
        _lb_namel = [UILabel new];
        _lb_namel.textColor = kUIColorFromRGB(0x333333);
        _lb_namel.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_namel;
}

- (UILabel *)lb_value {
    if (_lb_value == nil) {
        _lb_value = [UILabel new];
        _lb_value.textColor = kUIColorFromRGB(0x333333);
        _lb_value.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _lb_value;
}

- (UILabel *)lb_earn {
    if (_lb_earn == nil) {
        _lb_earn = [UILabel new];
        _lb_earn.textColor = kUIColorFromRGB(0x333333);
        _lb_earn.font = [UIFont systemFontOfSize:17 * kScale];
        _lb_earn.textAlignment = NSTextAlignmentCenter;
    }
    return _lb_earn;
}

- (UILabel *)lb_earnRate {
    if (_lb_earnRate == nil) {
        _lb_earnRate = [UILabel new];
        _lb_earnRate.textColor = kUIColorFromRGB(0x333333);
        _lb_earnRate.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_earnRate.textAlignment = NSTextAlignmentCenter;
    }
    return _lb_earnRate;
}

- (UILabel *)lb_hold {
    if (_lb_hold == nil) {
        _lb_hold = [UILabel new];
        _lb_hold.textColor = kUIColorFromRGB(0x333333);
        _lb_hold.font = [UIFont systemFontOfSize:17 * kScale];
        _lb_hold.textAlignment = NSTextAlignmentCenter;
    }
    return _lb_hold;
}

- (UILabel *)lb_old {
    if (_lb_old == nil) {
        _lb_old = [UILabel new];
        _lb_old.textColor = kUIColorFromRGB(0x333333);
        _lb_old.font = [UIFont systemFontOfSize:17 * kScale];
    }
    return _lb_old;
}

- (UILabel *)lb_new {
    if (_lb_new == nil) {
        _lb_new = [UILabel new];
        _lb_new.textColor = kUIColorFromRGB(0x333333);
        _lb_new.font = [UIFont systemFontOfSize:17 * kScale];
    }
    return _lb_new;
}







@end
