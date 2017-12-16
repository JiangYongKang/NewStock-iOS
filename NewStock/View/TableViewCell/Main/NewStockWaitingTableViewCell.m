//
//  NewStockWaitingTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/29.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "NewStockWaitingTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface NewStockWaitingTableViewCell ()

@property (nonatomic) UILabel *lb_name;
@property (nonatomic) UILabel *lb_code;
@property (nonatomic) UILabel *lb_pr;
@property (nonatomic) UILabel *lb_tm;
@property (nonatomic) UILabel *lb_rate;

@end

@implementation NewStockWaitingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.lb_name];
    [self.contentView addSubview:self.lb_code];
    [self.contentView addSubview:self.lb_pr];
    [self.contentView addSubview:self.lb_tm];
    [self.contentView addSubview:self.lb_rate];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(2);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.contentView.mas_centerY).offset(5);
    }];
    
    [self.lb_pr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_left).offset(150 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lb_tm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-105 * kScale);
    }];
    
    [self.lb_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.centerY.equalTo(self.contentView);
    }];

}

- (void)setName:(NSString *)name code:(NSString *)code price:(NSString *)price tm:(NSString *)tm rate:(NSString *)rate {
    self.lb_name.text = name;
    self.lb_code.text = code;
    self.lb_pr.text = [NSString stringWithFormat:@"%.2lf",price.floatValue];
    self.lb_tm.text = tm;
    self.lb_rate.text = [NSString stringWithFormat:@"%.4lf%%",rate.floatValue];
}

#pragma mark lazy loading

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.textColor = kUIColorFromRGB(0x333333);
        _lb_name.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_name;
}

- (UILabel *)lb_code {
    if (_lb_code == nil) {
        _lb_code = [UILabel new];
        _lb_code.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_code.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _lb_code;
}

- (UILabel *)lb_pr {
    if (_lb_pr == nil) {
        _lb_pr = [UILabel new];
        _lb_pr.textColor = kUIColorFromRGB(0x333333);
        _lb_pr.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_pr;
}

- (UILabel *)lb_tm {
    if (_lb_tm == nil) {
        _lb_tm = [UILabel new];
        _lb_tm.font = [UIFont systemFontOfSize:16 * kScale];
        _lb_tm.textColor = kUIColorFromRGB(0x333333);
    }
    return _lb_tm;
}

- (UILabel *)lb_rate {
    if (_lb_rate == nil) {
        _lb_rate = [UILabel new];
        _lb_rate.textColor = kUIColorFromRGB(0x333333);
        _lb_rate.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _lb_rate;
}


@end
