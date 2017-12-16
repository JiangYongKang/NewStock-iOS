//
//  ThemeNewsCell.m
//  NewStock
//
//  Created by 王迪 on 2017/5/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ThemeNewsCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface ThemeNewsCell ()

@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) UILabel *lb_time;

@property (nonatomic) UILabel *leadLb1;
@property (nonatomic) UILabel *leadLb2;
@property (nonatomic) UILabel *rateLb1;
@property (nonatomic) UILabel *rateLb2;
@property (nonatomic) UILabel *topLine;
@property (nonatomic) UILabel *bottomLine;
@property (nonatomic) UILabel *centerBall;

@end

@implementation ThemeNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.lb_title];
    [self.contentView addSubview:self.lb_time];
    [self.contentView addSubview:self.leadLb1];
    [self.contentView addSubview:self.leadLb2];
    [self.contentView addSubview:self.rateLb1];
    [self.contentView addSubview:self.rateLb2];
    
    [self.lb_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20 * kScale);
        make.left.equalTo(self.contentView).offset(54 * kScale);
    }];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(54 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(self.contentView).offset(52 * kScale);
    }];
    
    [self.leadLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(54 * kScale);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.rateLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leadLb1);
        make.left.equalTo(self.leadLb1.mas_right).offset(10 * kScale);
    }];
    
    [self.leadLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leadLb1);
        make.left.equalTo(self.rateLb1.mas_right).offset(20 * kScale);
    }];
    
    [self.rateLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leadLb1);
        make.left.equalTo(self.leadLb2.mas_right).offset(10 * kScale);
    }];

    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.centerBall];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(25 * kScale);
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(26 * kScale));
    }];
    
    [self.centerBall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLine.mas_bottom);
        make.centerX.equalTo(self.topLine);
        make.width.height.equalTo(@(6 * kScale));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerBall.mas_bottom);
        make.bottom.equalTo(self.contentView);
        make.width.equalTo(self.topLine);
        make.centerX.equalTo(self.topLine);
    }];
    
}

- (void)setModel:(ThemeDetailTmlModel *)model {
    _model = model;
    if (model.tm.length > 10) {
        self.lb_time.text = [model.tm substringToIndex:10];
    }
    self.lb_title.text = model.tt;
    [self dealWithSl];
}

- (void)dealWithSl {
    NSArray *arr = _model.sl;
    self.leadLb1.text = @"";
    self.leadLb2.text = @"";
    self.rateLb1.text = @"";
    self.rateLb2.text = @"";
    
    if (arr.count >= 2) {
        ThemeDetailStockModel *model1 = _model.sl[0];
        ThemeDetailStockModel *model2 = _model.sl[1];
        self.leadLb1.text = model1.n;
        self.leadLb2.text = model2.n;
        self.rateLb1.text = [NSString stringWithFormat:@"%.2lf%%",model1.zdf.floatValue];
        self.rateLb2.text = [NSString stringWithFormat:@"%.2lf%%",model2.zdf.floatValue];
        self.rateLb1.textColor = model1.zdf.floatValue >= 0 ? kUIColorFromRGB(0xff1919) : kUIColorFromRGB(0x009d00);
        self.rateLb2.textColor = model2.zdf.floatValue >= 0 ? kUIColorFromRGB(0xff1919) : kUIColorFromRGB(0x009d00);
    } else if (arr.count == 1) {
        ThemeDetailStockModel *model1 = _model.sl[0];
        self.leadLb1.text = model1.n;
        self.rateLb1.text = [NSString stringWithFormat:@"%.2lf%%",model1.zdf.floatValue];
        self.rateLb1.textColor = model1.zdf.floatValue >= 0 ? kUIColorFromRGB(0xff1919) : kUIColorFromRGB(0x009d00);
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    ThemeDetailStockModel *model;
    if (tap.view.tag == 1) {
        model = self.model.sl[0];
    } else if (tap.view.tag == 2) {
        model = self.model.sl[1];
    }
    if ([self.delegate respondsToSelector:@selector(ThemeNewsCellDelegateClick:)]) {
        [self.delegate ThemeNewsCellDelegateClick:model];
    }
}

- (void)setIsFirst:(BOOL)isFirst {
    _isFirst = isFirst;
    self.topLine.hidden = isFirst;
}

#pragma mark  lazy loading

- (UILabel *)lb_title {
    if (_lb_title == nil) {
        _lb_title = [UILabel new];
        _lb_title.textColor = kUIColorFromRGB(0x333333);
        _lb_title.font = [UIFont boldSystemFontOfSize:14 * kScale];
    }
    return _lb_title;
}

- (UILabel *)lb_time {
    if (_lb_time == nil) {
        _lb_time = [UILabel new];
        _lb_time.textColor = kUIColorFromRGB(0x999999);
        _lb_time.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _lb_time;
}

- (UILabel *)leadLb1 {
    if (_leadLb1 == nil) {
        _leadLb1 = [UILabel new];
        _leadLb1.textColor = kNameColor;
        _leadLb1.font = [UIFont systemFontOfSize:13 * kScale];
        _leadLb1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_leadLb1 addGestureRecognizer:tap];
        _leadLb1.tag = 1;
    }
    return _leadLb1;
}

- (UILabel *)leadLb2 {
    if (_leadLb2 == nil) {
        _leadLb2 = [UILabel new];
        _leadLb2.textColor = kNameColor;
        _leadLb2.font = [UIFont systemFontOfSize:13 * kScale];
        _leadLb2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_leadLb2 addGestureRecognizer:tap];
        _leadLb2.tag = 2;
    }
    return _leadLb2;
}

- (UILabel *)rateLb1 {
    if (_rateLb1 == nil) {
        _rateLb1 = [UILabel new];
        _rateLb1.font = [UIFont systemFontOfSize:13 * kScale];
    }
    return _rateLb1;
}

- (UILabel *)rateLb2 {
    if (_rateLb2 == nil) {
        _rateLb2 = [UILabel new];
        _rateLb2.font = [UIFont systemFontOfSize:13 * kScale];
    }
    return _rateLb2;
}

- (UILabel *)topLine {
    if (_topLine == nil) {
        _topLine = [UILabel new];
        _topLine.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _topLine;
}

- (UILabel *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [UILabel new];
        _bottomLine.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _bottomLine;
}

- (UILabel *)centerBall {
    if (_centerBall == nil) {
        _centerBall = [UILabel new];
        _centerBall.backgroundColor = kUIColorFromRGB(0xff1919);
        _centerBall.layer.cornerRadius = 3 * kScale;
        _centerBall.layer.masksToBounds = YES;
    }
    return _centerBall;
}


@end
