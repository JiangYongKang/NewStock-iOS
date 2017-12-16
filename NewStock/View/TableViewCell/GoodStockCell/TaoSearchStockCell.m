//
//  TaoSearchStockCell.m
//  NewStock
//
//  Created by 王迪 on 2017/2/23.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoSearchStockCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface TaoSearchStockCell ()

@property (nonatomic, strong) UILabel *nameLb;

@property (nonatomic, strong) UILabel *buyLb;

@property (nonatomic, strong) UILabel *saleLb;

@end

@implementation TaoSearchStockCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {

    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.buyLb];
    [self.contentView addSubview:self.saleLb];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.buyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-125 * kScale);
    }];
    
    [self.saleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(TaoSearchStockBSModel *)model {
    _model = model;
    
    self.nameLb.text = model.n;
    
    self.buyLb.text = [NSString stringWithFormat:@"%.2lf",model.b.floatValue];
    
    self.saleLb.text = [NSString stringWithFormat:@"%.2lf",model.s.floatValue];
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x358ee7);
        _nameLb.font = [UIFont systemFontOfSize:12 * kScale];
        _nameLb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_nameLb addGestureRecognizer:tap];
        _nameLb.numberOfLines = 2;
        _nameLb.preferredMaxLayoutWidth = 158 * kScale;
    }
    return _nameLb;
}

- (UILabel *)buyLb {
    if (_buyLb == nil) {
        _buyLb = [UILabel new];
        _buyLb.textColor = kUIColorFromRGB(0xff1919);
        _buyLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _buyLb;
}

- (UILabel *)saleLb {
    if (_saleLb == nil) {
        _saleLb = [UILabel new];
        _saleLb.textColor = kUIColorFromRGB(0x009d00);
        _saleLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
    }
    return _saleLb;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.pushBlock) {
        self.pushBlock(self.nameLb.text);
    }
}



@end
