//
//  NewStockApplyDetailTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/6/29.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "NewStockApplyDetailTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface NewStockApplyDetailTableViewCell ()

@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *valueLb;

@end

@implementation NewStockApplyDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.valueLb];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.valueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
}

- (void)setName:(NSString *)name value:(NSString *)value {
    self.nameLb.text = name;
    self.valueLb.text = value;
}

#pragma mark lazy loading

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x808080);
        _nameLb.font = [UIFont systemFontOfSize:13 * kScale];
        _nameLb.numberOfLines = 0;
        _nameLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
    }
    return _nameLb;
}

- (UILabel *)valueLb {
    if (_valueLb == nil) {
        _valueLb = [UILabel new];
        _valueLb.textColor = kUIColorFromRGB(0x333333);
        _valueLb.font = [UIFont systemFontOfSize:13 * kScale];
    }
    return _valueLb;
}

@end
