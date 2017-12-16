//
//  IdleFundStockCellTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "IdleFundStockCellTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface IdleFundStockCellTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;

@property (nonatomic, strong) UILabel *lb_code;

@property (nonatomic, strong) UILabel *lb_new;

@property (nonatomic, strong) UILabel *lb_rate;

@end

@implementation IdleFundStockCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {

    [self.contentView addSubview:self.lb_rate];
    [self.contentView addSubview:self.lb_new];
    [self.contentView addSubview:self.lb_code];
    [self.contentView addSubview:self.lb_name];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.contentView).offset(10 * kScale);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.lb_name.mas_bottom).offset(3 * kScale);
    }];
    
    [self.lb_new mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(25 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lb_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
}

- (void)setModel:(IdleFundStockListModel *)model {
    
    _model = model;

    self.lb_name.text = model.n;
    
    self.lb_code.text = model.s;
    
    if (model.zx == nil) {
        self.lb_new.text = @"--";
        self.lb_new.textColor = kUIColorFromRGB(0x333333);
    }else {
        self.lb_new.text = [NSString stringWithFormat:@"%.2lf",model.zx.floatValue];
    }
    
    if (model.zdf == nil) {
        self.lb_rate.text = @"--";
        self.lb_rate.textColor = kUIColorFromRGB(0x333333);
        return;
    }else {
        self.lb_rate.text = [NSString stringWithFormat:@"%.2lf%%",model.zdf.floatValue];
    }
    
    if (model.zdf.floatValue > 0) {
        self.lb_rate.textColor = kUIColorFromRGB(0xff1919);
        self.lb_new.textColor = kUIColorFromRGB(0xff1919);
    } else if (model.zdf.floatValue < 0) {
        self.lb_rate.textColor = kUIColorFromRGB(0x009d00);
        self.lb_new.textColor = kUIColorFromRGB(0x009d00);
    } else {
        self.lb_rate.textColor = kUIColorFromRGB(0x333333);
        self.lb_new.textColor = kUIColorFromRGB(0x333333);
    }
    
}

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.textColor = kUIColorFromRGB(0x333333);
        _lb_name.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _lb_name;
}

- (UILabel *)lb_code {
    if (_lb_code == nil) {
        _lb_code = [UILabel new];
        _lb_code.textColor = kUIColorFromRGB(0x808080);
        _lb_code.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _lb_code;
}

- (UILabel *)lb_new {
    if (_lb_new == nil) {
        _lb_new = [UILabel new];
        _lb_new.font = [UIFont boldSystemFontOfSize:17 * kScale];
        _lb_new.textColor = kUIColorFromRGB(0x333333);
    }
    return _lb_new;
}

- (UILabel *)lb_rate {
    if (_lb_rate == nil) {
        _lb_rate = [UILabel new];
        _lb_rate.textAlignment = NSTextAlignmentCenter;
        _lb_rate.font = [UIFont boldSystemFontOfSize:17 * kScale];
    }
    return _lb_rate;
}


@end
