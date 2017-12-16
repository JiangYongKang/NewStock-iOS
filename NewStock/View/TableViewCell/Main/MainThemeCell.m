//
//  MainThemeCell.m
//  NewStock
//
//  Created by 王迪 on 2017/5/4.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainThemeCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface MainThemeCell ()

@property (nonatomic) UIImageView *leftImg;
@property (nonatomic) UILabel *lb_name;
@property (nonatomic) UIImageView *star1;
@property (nonatomic) UIImageView *star2;
@property (nonatomic) UIImageView *star3;
@property (nonatomic) UIImageView *star4;
@property (nonatomic) UIImageView *star5;

@property (nonatomic) NSMutableArray *starArray;
@property (nonatomic) UILabel *timeLb;
@property (nonatomic) UILabel *dscLb;
@property (nonatomic) UILabel *leadLb;
@property (nonatomic) UILabel *leadLb1;
@property (nonatomic) UILabel *leadLb2;
@property (nonatomic) UILabel *rateLb1;
@property (nonatomic) UILabel *rateLb2;
@property (nonatomic) UILabel *indexLb;

@property (nonatomic) UIView *blockView;

@end

@implementation MainThemeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.blockView];
    [_blockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
    [self.contentView addSubview:self.leftImg];
    [self.contentView addSubview:self.indexLb];
    [self.contentView addSubview:self.lb_name];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.star1];
    [self.contentView addSubview:self.star2];
    [self.contentView addSubview:self.star3];
    [self.contentView addSubview:self.star4];
    [self.contentView addSubview:self.star5];
    [self.contentView addSubview:self.dscLb];
    [self.contentView addSubview:self.leadLb];
    [self.contentView addSubview:self.leadLb1];
    [self.contentView addSubview:self.leadLb2];
    [self.contentView addSubview:self.rateLb1];
    [self.contentView addSubview:self.rateLb2];

    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blockView).offset(12 * kScale);
        make.top.equalTo(_blockView).offset(0);
    }];
    
    [self.indexLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blockView).offset(12 * kScale);
        make.top.equalTo(_blockView).offset(13 * kScale);
        make.width.height.equalTo(@(18 * kScale));
    }];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blockView).offset(56 * kScale);
        make.top.equalTo(_blockView).offset(12 * kScale);
    }];
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lb_name);
        make.right.equalTo(_blockView).offset(-10 * kScale);
    }];
    
    [self.star1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blockView).offset(56 * kScale);
        make.top.equalTo(_blockView).offset(36 * kScale);
    }];
    
    [self.star2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star1.mas_right).offset(3 * kScale);
        make.top.equalTo(self.star1);
    }];
    
    [self.star3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star2.mas_right).offset(3 * kScale);
        make.top.equalTo(self.star2);
    }];
    
    [self.star4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star3.mas_right).offset(3 * kScale);
        make.top.equalTo(self.star3);
    }];
    
    [self.star5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star4.mas_right).offset(3 * kScale);
        make.top.equalTo(self.star4);
    }];
    
    [self.dscLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blockView).offset(12 * kScale);
        make.right.equalTo(_blockView).offset(-10 * kScale);
        make.top.equalTo(_star1.mas_bottom).offset(16 * kScale);
    }];
    
    [self.leadLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blockView).offset(12 * kScale);
        make.bottom.equalTo(_blockView.mas_bottom).offset(-12 * kScale);
    }];
    
    [self.leadLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leadLb.mas_right).offset(15 * kScale);
        make.bottom.equalTo(self.leadLb);
    }];
    
    [self.rateLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leadLb);
        make.left.equalTo(self.leadLb1.mas_right).offset(10 * kScale);
    }];
    
    [self.leadLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leadLb);
        make.left.equalTo(self.rateLb1.mas_right).offset(20 * kScale);
    }];
    
    [self.rateLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leadLb);
        make.left.equalTo(self.leadLb2.mas_right).offset(10 * kScale);
    }];


    [self.starArray addObject:self.star1];
    [self.starArray addObject:self.star2];
    [self.starArray addObject:self.star3];
    [self.starArray addObject:self.star4];
    [self.starArray addObject:self.star5];
}

- (void)setModel:(MainThemeModel *)model {
    _model = model;
    
    self.lb_name.text = model.n;
    [self dealWithTt];
    [self dealWithStar];
    [self dealWithSl];
    
    if (model.tm.length > 11) {
        self.timeLb.text = [model.tm substringFromIndex:11];
    }
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    if (index >= 0 && index <= 2 && _model.rmd.integerValue == 1) {
        self.indexLb.hidden = YES;
        self.lb_name.hidden = NO;
        self.leftImg.hidden = NO;
        self.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"theme_ico_%zd",index + 1]];
        if (_model.tm.length > 11) {
            self.timeLb.text = [_model.tm substringWithRange:NSMakeRange(11, _model.tm.length - 11 - 3)];
        }
    } else if (index == -1) {
        self.indexLb.hidden = YES;
        self.lb_name.hidden = YES;
        self.leftImg.hidden = YES;
        if (_model.tm.length > 5) {
            self.timeLb.text = [_model.tm substringWithRange:NSMakeRange(5, _model.tm.length - 5 - 3)];
        }
    } else {
        self.indexLb.hidden = NO;
        self.lb_name.hidden = NO;
        self.leftImg.hidden = YES;
        self.indexLb.text = [NSString stringWithFormat:@"%zd",index + 1];
        if (_model.tm.length > 11) {
            self.timeLb.text = [_model.tm substringWithRange:NSMakeRange(11, _model.tm.length - 11 - 3)];
        }
    }
    
    [self updateCons:index];
}

- (void)setIsLastOne:(BOOL)isLastOne {
    if (isLastOne) {
        [_blockView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(0 * kScale);
        }];
    } else {
        [_blockView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-12 * kScale);
        }];
    }
}

- (void)setStyle:(MainThemeCellStyle)style {
    _style = style;
    if (_style == MainThemeCellStyleBorder) {
        _blockView.layer.borderWidth = 0.5;
        _blockView.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
    } else if (_style == MainThemeCellStyleShadow) {
        _blockView.layer.shadowColor = kUIColorFromRGB(0x666666).CGColor;
        _blockView.layer.shadowRadius = 5;
        _blockView.layer.shadowOpacity = 0.1;
        _blockView.layer.shadowOffset = CGSizeMake(0, 0.5);
    }
}

- (void)updateCons:(NSInteger)index {
    if (index >= 0 && index <= 2 && _model.rmd.integerValue == 1) {
        [self.star1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_blockView).offset(56 * kScale);
            make.top.equalTo(_blockView).offset(36 * kScale);
        }];
        [self.lb_name mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_blockView).offset(56 * kScale);
        }];
    } else if (index == -1) {
        [self.star1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_blockView).offset(12 * kScale);
            make.top.equalTo(_blockView).offset(20 * kScale);
        }];
    } else {
        [self.star1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_blockView).offset(43 * kScale);
            make.top.equalTo(_blockView).offset(36 * kScale);
        }];
        [self.lb_name mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_blockView).offset(43 * kScale);
        }];
    }
    
    [self.contentView layoutIfNeeded];
}

- (void)dealWithTt {
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];

    CGFloat w = [_model.tt boundingRectWithSize:CGSizeMake(MAXFLOAT, _dscLb.font.lineHeight) options:1 attributes:@{NSFontAttributeName : _dscLb.font} context:nil].size.width;
    if (w > _dscLb.frame.size.width) {
        para.lineSpacing = 4;
    } else {
        para.lineSpacing = 0;
    }
    NSAttributedString *nmS = [[NSAttributedString alloc] initWithString:_model.tt attributes:@{NSParagraphStyleAttributeName : para}];
    self.dscLb.attributedText = nmS.copy;
}

- (void)dealWithStar {
    for (UIImageView *iv in self.starArray) {
        iv.image = [UIImage imageNamed:@"theme_star_empty"];
    }
    
    CGFloat count = _model.star.floatValue;
    NSInteger num = count * 2 ;
    for (int i = 0; i < 5; i ++) {
        UIImageView *iv = self.starArray[i];
        if (num >= 2) {
            iv.image = [UIImage imageNamed:@"theme_star_full"];
            num -= 2;
        } else if (num == 1) {
            iv.image = [UIImage imageNamed:@"theme_star_half"];
            break;
        } else {
            break;
        }
    }
}

- (void)dealWithSl {
    NSArray *arr = _model.sl;
    self.leadLb1.text = @"";
    self.leadLb2.text = @"";
    self.rateLb1.text = @"";
    self.rateLb2.text = @"";
    
    if (arr.count >= 2) {
        MainThemeStockModel *model1 = _model.sl[0];
        MainThemeStockModel *model2 = _model.sl[1];
        self.leadLb1.text = model1.n;
        self.leadLb2.text = model2.n;
        self.rateLb1.text = [NSString stringWithFormat:@"%.2lf%%",model1.zdf.floatValue];
        self.rateLb2.text = [NSString stringWithFormat:@"%.2lf%%",model2.zdf.floatValue];
        self.rateLb1.textColor = model1.zdf.floatValue >= 0 ? kUIColorFromRGB(0xff1919) : kUIColorFromRGB(0x009d00);
        self.rateLb2.textColor = model2.zdf.floatValue >= 0 ? kUIColorFromRGB(0xff1919) : kUIColorFromRGB(0x009d00);
    } else if (arr.count == 1) {
        MainThemeStockModel *model1 = _model.sl[0];
        self.leadLb1.text = model1.n;
        self.rateLb1.text = [NSString stringWithFormat:@"%.2lf%%",model1.zdf.floatValue];
        self.rateLb1.textColor = model1.zdf.floatValue >= 0 ? kUIColorFromRGB(0xff1919) : kUIColorFromRGB(0x009d00);
    }
}

#pragma mark aciton

- (void)tap:(UITapGestureRecognizer *)tap {
    MainThemeStockModel *model;
    if (tap.view.tag == 1) {
        model = self.model.sl[0];
    } else if (tap.view.tag == 2) {
        model = self.model.sl[1];
    }
    if ([self.delegate respondsToSelector:@selector(MainThemeCellDelegate:)]) {
        [self.delegate MainThemeCellDelegate:model];
    }
}

#pragma mark lazy loading

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.textColor = kUIColorFromRGB(0x333333);
        _lb_name.font = [UIFont boldSystemFontOfSize:18 * kScale];
    }
    return _lb_name;
}

- (UIImageView *)leftImg {
    if (_leftImg == nil) {
        _leftImg = [[UIImageView alloc] init];
    }
    return _leftImg;
}

- (UIImageView *)star1 {
    if (_star1 == nil) {
        _star1 = [UIImageView new];
    }
    return _star1;
}

- (UIImageView *)star2 {
    if (_star2 == nil) {
        _star2 = [UIImageView new];
    }
    return _star2;
}

- (UIImageView *)star3 {
    if (_star3 == nil) {
        _star3 = [UIImageView new];
    }
    return _star3;
}

- (UIImageView *)star4 {
    if (_star4 == nil) {
        _star4 = [UIImageView new];
    }
    return _star4;
}

- (UIImageView *)star5 {
    if (_star5 == nil) {
        _star5 = [UIImageView new];
    }
    return _star5;
}

- (NSMutableArray *)starArray {
    if (_starArray == nil) {
        _starArray = [NSMutableArray array];
    }
    return _starArray;
}

- (UILabel *)timeLb {
    if (_timeLb == nil) {
        _timeLb = [UILabel new];
        _timeLb.textColor = kUIColorFromRGB(0x999999);
        _timeLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _timeLb;
}

- (UILabel *)dscLb {
    if (_dscLb == nil) {
        _dscLb = [UILabel new];
        _dscLb.textColor = kUIColorFromRGB(0x333333);
        _dscLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
        _dscLb.numberOfLines = 2;
    }
    return _dscLb;
}

- (UILabel *)leadLb {
    if (_leadLb == nil) {
        _leadLb = [UILabel new];
        _leadLb.textColor = kUIColorFromRGB(0x999999);
        _leadLb.font = [UIFont systemFontOfSize:13 * kScale];
        _leadLb.text = @"领涨个股:";
    }
    return _leadLb;
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

- (UIView *)blockView {
    if (_blockView == nil) {
        _blockView = [UIView new];
        _blockView.backgroundColor = [UIColor whiteColor];
        _blockView.layer.cornerRadius = 5;
    }
    return _blockView;
}

- (UILabel *)indexLb {
    if (_indexLb == nil) {
        _indexLb = [UILabel new];
        _indexLb.textColor = kUIColorFromRGB(0x999999);
        _indexLb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        _indexLb.font = [UIFont systemFontOfSize:12 * kScale];
        _indexLb.layer.cornerRadius = 2 * kScale;
        _indexLb.layer.masksToBounds = YES;
        _indexLb.hidden = YES;
        _indexLb.textAlignment = NSTextAlignmentCenter;
    }
    return _indexLb;
}


@end
