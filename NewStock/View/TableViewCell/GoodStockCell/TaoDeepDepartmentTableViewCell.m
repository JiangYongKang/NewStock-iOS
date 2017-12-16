//
//  TaoDeepDepartmentTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoDeepDepartmentTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"

@interface TaoDeepDepartmentTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;

@property (nonatomic, strong) UILabel *lb_sale;

@property (nonatomic, strong) UILabel *lb_buy;

@property (nonatomic, strong) UILabel *lb_count;

@end

@implementation TaoDeepDepartmentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.clipsToBounds = YES;
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.lb_count];
    [self.contentView addSubview:self.lb_buy];
    [self.contentView addSubview:self.lb_sale];
    [self.contentView addSubview:self.lb_name];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.contentView).offset(10 * kScale);
        make.right.equalTo(self.contentView).offset(-50 * kScale);
    }];
    
    [self.lb_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.lb_name.mas_bottom).offset(3 * kScale);
    }];
    
    [self.lb_sale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_buy);
        make.left.equalTo(self.lb_buy.mas_right).offset(20 * kScale);
    }];

    [self.lb_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-25 * kScale);
        make.centerY.equalTo(self.contentView);
    }];

    
    
}

- (void)setN:(NSString *)n count:(NSString *)count sale:(NSString *)sale buy:(NSString *)buy {
    self.lb_name.text = n;
    self.lb_buy.text = [NSString stringWithFormat:@"%.2lf万",buy.floatValue / 10000.00];
    self.lb_sale.text = [NSString stringWithFormat:@"%.2lf万",sale.floatValue / 10000.00];

    self.lb_count.text = [NSString stringWithFormat:@"%zd",count.integerValue];
}

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.textColor = kUIColorFromRGB(0x333333);
        _lb_name.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _lb_name;
}

- (UILabel *)lb_sale {
    if (_lb_sale == nil) {
        _lb_sale = [UILabel new];
        _lb_sale.textColor = FALL_COLOR;
        _lb_sale.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _lb_sale;
}

- (UILabel *)lb_buy {
    if (_lb_buy == nil) {
        _lb_buy = [UILabel new];
        _lb_buy.font = [UIFont boldSystemFontOfSize:12 * kScale];
        _lb_buy.textColor = RISE_COLOR;
    }
    return _lb_buy;
}

- (UILabel *)lb_count {
    if (_lb_count == nil) {
        _lb_count = [UILabel new];
        _lb_count.textColor = kUIColorFromRGB(0x333333);
        _lb_count.textAlignment = NSTextAlignmentCenter;
        _lb_count.font = [UIFont boldSystemFontOfSize:15 * kScale];
    }
    return _lb_count;
}



@end
