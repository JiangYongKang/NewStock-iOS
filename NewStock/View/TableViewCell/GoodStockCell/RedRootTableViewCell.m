//
//  RedRootTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/2/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "RedRootTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface RedRootTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_code;
@property (nonatomic, strong) UILabel *lb_rate;
@property (nonatomic, strong) UILabel *lb_pure_buy;
@property (nonatomic, strong) UIButton *lb_more;

@end

@implementation RedRootTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.lb_name];
    [self.contentView addSubview:self.lb_code];
    [self.contentView addSubview:self.lb_rate];
    [self.contentView addSubview:self.lb_pure_buy];
    [self.contentView addSubview:self.lb_more];

    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10 * kScale);
        make.left.equalTo(self.contentView).offset(15 * kScale);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.lb_name.mas_bottom).offset(3 * kScale);
    }];
    
    [self.lb_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(-20 * kScale);
        make.top.equalTo(self.contentView).offset(20 * kScale);
    }];
    
    [self.lb_pure_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lb_more.mas_left).offset(-40 * kScale);
        make.centerY.equalTo(self.lb_rate);
    }];
    
    [self.lb_more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lb_rate);
        make.right.equalTo(self.contentView).offset(-15 * kScale);
        make.width.equalTo(@(40 * kScale));
        make.height.equalTo(@(21 * kScale));
    }];
    
}

- (void)setModel:(RedRootListModel *)model {

    _model = model;
    
    self.lb_name.text = model.n;
    self.lb_code.text = model.s;
    if (model.zdf == nil) {
        self.lb_rate.text = @"--";
    } else {
        self.lb_rate.text = [NSString stringWithFormat:@"%.2lf%%",model.zdf.floatValue];
    }
    
    if (model.zdf.floatValue > 0) {
        _lb_rate.textColor = kUIColorFromRGB(0xff1919);
    } else if (model.zdf.floatValue < 0) {
        _lb_rate.textColor = kUIColorFromRGB(0x009d00);
    } else {
        _lb_rate.textColor = kUIColorFromRGB(0x333333);
    }
    
    if (model.nbuy == nil) {
        self.lb_pure_buy.text = @"--";
    } else {
        self.lb_pure_buy.text = [NSString stringWithFormat:@"%.2lf",model.nbuy.floatValue];
    }

}

#pragma mark action 

- (void)moreBtnClick:(UIButton *)btn {

    if (self.heightBlcok) {
        self.heightBlcok();
    }
}

#pragma mark lazy loading

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [[UILabel alloc] init];
        _lb_name.font = [UIFont boldSystemFontOfSize:16 * kScale];
        _lb_name.textColor = kUIColorFromRGB(0x333333);
    }
    return _lb_name;
}

- (UILabel *)lb_code {
    if (_lb_code == nil) {
        _lb_code = [[UILabel alloc] init];
        _lb_code.font = [UIFont systemFontOfSize:11 * kScale];
        _lb_code.textColor = kUIColorFromRGB(0x808080);
    }
    return _lb_code;
}

- (UILabel *)lb_rate {
    if (_lb_rate == nil) {
        _lb_rate = [[UILabel alloc] init];
        _lb_rate.font = [UIFont boldSystemFontOfSize:17 * kScale];
        _lb_rate.textColor = kUIColorFromRGB(0xff1919);
    }
    return _lb_rate;
}

- (UILabel *)lb_pure_buy {
    if (_lb_pure_buy == nil) {
        _lb_pure_buy = [[UILabel alloc] init];
        _lb_pure_buy.font = [UIFont boldSystemFontOfSize:17 * kScale];
        _lb_pure_buy.textColor = kUIColorFromRGB(0x333333);
        _lb_pure_buy.textAlignment = NSTextAlignmentRight;
    }
    return _lb_pure_buy;
}

- (UIButton *)lb_more {
    if (_lb_more == nil) {
        _lb_more = [[UIButton alloc] init];
        _lb_more.titleLabel.font = [UIFont systemFontOfSize:11 * kScale];
        [_lb_more setTitle:@"行情" forState:UIControlStateNormal];
        [_lb_more setTitleColor:kTitleColor forState:UIControlStateNormal];
        _lb_more.backgroundColor = [UIColor whiteColor];
        _lb_more.layer.cornerRadius = 3 * kScale;
        _lb_more.layer.masksToBounds = YES;
        [_lb_more addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _lb_more.layer.borderWidth = 0.5 * kScale;
        _lb_more.layer.borderColor = kButtonBGColor.CGColor;
    }
    return _lb_more;
}

@end
