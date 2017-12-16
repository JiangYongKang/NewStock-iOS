//
//  TaoTuiJianTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/3/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoTuiJianTableViewCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface TaoTuiJianTableViewCell ()

@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_code;
@property (nonatomic, strong) UILabel *lb_rate;
@property (nonatomic, strong) UILabel *lb_pure_buy;
@property (nonatomic, strong) UIButton *lb_more;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *bottomLb;

@property (nonatomic, strong) UIView *btnCoverView;

@property (nonatomic, strong) UILabel *bottomLine;

@end

@implementation TaoTuiJianTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.btnCoverView];
    [self.contentView addSubview:self.lb_name];
    [self.contentView addSubview:self.lb_code];
    [self.contentView addSubview:self.lb_rate];
    [self.contentView addSubview:self.lb_pure_buy];
    [self.btnCoverView addSubview:self.lb_more];
    
    [self.btnCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@(80 * kScale));
    }];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10 * kScale);
        make.left.equalTo(self.contentView).offset(15 * kScale);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(self.lb_name.mas_bottom).offset(3 * kScale);
    }];
    
    [self.lb_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lb_more.mas_left).offset(-45 * kScale);
        make.centerY.equalTo(self.lb_pure_buy);
    }];
    
    [self.lb_pure_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(-20 * kScale);
        make.top.equalTo(self.contentView).offset(20 * kScale);
    }];
    
    [self.lb_more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lb_rate);
        make.right.equalTo(self.contentView).offset(-15 * kScale);
        make.width.equalTo(@(40 * kScale));
        make.height.equalTo(@(21 * kScale));
    }];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.bottomLb];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(54 * kScale);
        make.height.equalTo(@(40 * kScale));
    }];
    
    [self.bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(15 * kScale);
        make.right.equalTo(self.bottomView).offset(-15 * kScale);
        make.top.equalTo(self.bottomView).offset(15 * kScale);
        make.bottom.equalTo(self.bottomView).offset(-15 * kScale);
    }];
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.right.equalTo(self.contentView).offset(-15 * kScale);
        make.height.equalTo(@(0.5 * kScale));
        make.bottom.equalTo(self.contentView);
    }];
    
}

- (void)setModel:(TaoTuiJianModel *)model {
    
    _model = model;
    
    self.lb_more.selected = model.isSelected;
    
    if (_lb_more.isSelected) {
        _lb_more.layer.borderColor = kUIColorFromRGB(0xb2b2b2).CGColor;
    } else {
        _lb_more.layer.borderColor = kButtonBGColor.CGColor;
    }
    
    self.lb_name.text = model.n;
    self.lb_code.text = model.s;
    if (model.zdf == nil) {
        self.lb_rate.text = @"--";
    } else {
        self.lb_rate.text = [NSString stringWithFormat:@"%.2lf%%",model.zdf.floatValue];
    }
    
    if (model.zdf.floatValue > 0) {
        _lb_rate.textColor = kUIColorFromRGB(0xff1919);
        _lb_pure_buy.textColor = kUIColorFromRGB(0xff1919);
    } else if (model.zdf.floatValue < 0) {
        _lb_rate.textColor = kUIColorFromRGB(0x009d00);
        _lb_pure_buy.textColor = kUIColorFromRGB(0x009d00);
    } else {
        _lb_rate.textColor = kUIColorFromRGB(0x333333);
        _lb_pure_buy.textColor = kUIColorFromRGB(0x333333);
    }
    
    if (model.close == nil) {
        self.lb_pure_buy.text = @"--";
    } else {
        self.lb_pure_buy.text = [NSString stringWithFormat:@"%.2lf",model.close.floatValue];
    }
    
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = 3 * kScale;
    
    NSMutableAttributedString *nmAttrS = [[NSMutableAttributedString alloc] initWithString:model.rs attributes:@{
                                                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:12 * kScale],
                                                                                                                 NSParagraphStyleAttributeName : para,
                                                                                                                     }];
    self.bottomLb.attributedText = nmAttrS;
//    CGRect rect = [model.rs boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH - 30 * kScale, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
//                                                                                                                                                           NSFontAttributeName : [UIFont systemFontOfSize:12 * kScale]
//                                                                                                                                                           } context:nil];
    CGRect rect = [nmAttrS boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH - 30 * kScale, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    CGFloat h = rect.size.height + 30 * kScale;
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(h));
    }];
    
    model.height = h + 54 * kScale;
    
    [self.contentView layoutIfNeeded];
    
}

#pragma mark action

- (void)moreBtnClick:(UIButton *)btn {

    _model.isSelected = !btn.isSelected;
    self.bottomLine.hidden = btn.isSelected;
    if (self.heightBlcok) {
        self.heightBlcok();
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self moreBtnClick:self.lb_more];
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
        [_lb_more setTitle:@"理由" forState:UIControlStateNormal];
        _lb_more.adjustsImageWhenHighlighted = NO;
        [_lb_more setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_lb_more setTitleColor:kUIColorFromRGB(0xb2b2b2) forState:UIControlStateSelected];
        [_lb_more setTitleColor:kUIColorFromRGB(0xb2b2b2) forState:UIControlStateHighlighted | UIControlStateSelected];
        _lb_more.backgroundColor = kUIColorFromRGB(0xffffff);
        _lb_more.layer.cornerRadius = 3 * kScale;
        _lb_more.layer.masksToBounds = YES;
        [_lb_more addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _lb_more.layer.borderWidth = 0.5 * kScale;
        _lb_more.layer.borderColor = kButtonBGColor.CGColor;
    }
    return _lb_more;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _bottomView;
}

- (UILabel *)bottomLb {
    if (_bottomLb == nil) {
        _bottomLb = [UILabel new];
        _bottomLb.textColor = kUIColorFromRGB(0x333333);
        _bottomLb.numberOfLines = 0;
        _bottomLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 30 * kScale;
        _bottomLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _bottomLb;
}

- (UIView *)btnCoverView {
    if (_btnCoverView == nil) {
        _btnCoverView = [UIView new];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_btnCoverView addGestureRecognizer:tap];
    }
    return _btnCoverView;
}

- (UILabel *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [UILabel new];
        _bottomLine.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _bottomLine;
}

@end
