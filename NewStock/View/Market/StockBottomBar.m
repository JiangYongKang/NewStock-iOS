//
//  StockBottomBar.m
//  NewStock
//
//  Created by 王迪 on 2017/6/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockBottomBar.h"
#import "TaoIndexLeftBtn.h"
#import "UIView+Masonry_Arrange.h"
#import "Defination.h"
#import <Masonry.h>
#import "MarketConfig.h"

@interface StockBottomBar ()

@property (nonatomic) TaoIndexLeftBtn *buyBtn;
@property (nonatomic) TaoIndexLeftBtn *saleBtn;
@property (nonatomic) TaoIndexLeftBtn *addBtn;
@property (nonatomic) TaoIndexLeftBtn *moreBtn;
@property (nonatomic) TaoIndexLeftBtn *dealBtn;

@property (nonatomic) STOCK_BAR_TYPE type;

@property (nonatomic) UILabel *line1;
@property (nonatomic) UILabel *line2;
@property (nonatomic) UILabel *line3;
@property (nonatomic) UILabel *line4;
@property (nonatomic) UILabel *line5;

@property (nonatomic) UILabel *bottomLine;

@end

@implementation StockBottomBar

- (instancetype)initWithType:(STOCK_BAR_TYPE)type {
    if (self = [super initWithFrame:CGRectZero]) {
        _type = type;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (_type == STOCK_BAR_TYPE_INDEX) {
        
        [self addSubview:self.dealBtn];
        [self addSubview:self.addBtn];
        [self addSubview:self.moreBtn];
        
        [_dealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.33);
        }];
        
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.34);
        }];
        
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.33);
        }];
        
        [self distributeSpacingHorizontallyWith:@[_dealBtn,_addBtn,_moreBtn]];
        
    } else if (_type == STOCK_BAR_TYPE_STOCK) {
        
        [self addSubview:self.buyBtn];
        [self addSubview:self.saleBtn];
        [self addSubview:self.addBtn];
        [self addSubview:self.moreBtn];

        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.equalTo(@(MAIN_SCREEN_WIDTH / 4));
            make.left.equalTo(self);
        }];
        
        [_saleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.equalTo(@(MAIN_SCREEN_WIDTH / 4));
            make.left.equalTo(_buyBtn.mas_right);
        }];
        
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.bottom.equalTo(self);
            make.width.equalTo(@(MAIN_SCREEN_WIDTH / 4));
            make.left.equalTo(_saleBtn.mas_right);
        }];
        
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(@(MAIN_SCREEN_WIDTH / 4));
            make.right.equalTo(self);
        }];
    }
    
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
}

#pragma mark action

- (void)setIsAdd:(BOOL)isAdd {
    _addBtn.title = !isAdd ? @"添加自选" : @"删除自选";
    _addBtn.imgStr = !isAdd ? @"ic_bottombar_add_stock" : @"ic_bottombar_del_stock";
}

- (void)btnClick:(UIButton *)btn {
    NSInteger index = btn.tag;
    
    if (![self.delegate respondsToSelector:@selector(stockBottomBarDelegatePushTo:)]) {
        return;
    }
    
    if (index == 1) {
        [self.delegate stockBottomBarDelegatePushTo:@"买入"];
    } else if (index == 2) {
        [self.delegate stockBottomBarDelegatePushTo:@"卖出"];
    } else if (index == 3) {
        [self.delegate stockBottomBarDelegatePushTo:@"+自选"];
    } else if (index == 4) {
        [self.delegate stockBottomBarDelegatePushTo:@"更多"];
    } else if (index == 5) {
        [self.delegate stockBottomBarDelegatePushTo:@"交易"];
    } else if (index == 6) {
        [self.delegate stockBottomBarDelegatePushTo:@"上证"];
    }
}

#pragma mark lazy loading

- (UILabel *)line1 {
    if (_line1 == nil) {
        _line1 = [UILabel new];
        _line1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line1;
}

- (UILabel *)line2 {
    if (_line2 == nil) {
        _line2 = [UILabel new];
        _line2.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line2;
}

- (UILabel *)line3 {
    if (_line3 == nil) {
        _line3 = [UILabel new];
        _line3.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line3;
}

- (UILabel *)line4 {
    if (_line4 == nil) {
        _line4 = [UILabel new];
        _line4.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line4;
}

- (UILabel *)line5 {
    if (_line5 == nil) {
        _line5 = [UILabel new];
        _line5.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _line5;
}

- (UILabel *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [UILabel new];
        _bottomLine.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _bottomLine;
}

- (TaoIndexLeftBtn *)dealBtn {
    if (_dealBtn == nil) {
        _dealBtn = [TaoIndexLeftBtn new];
        _dealBtn.backgroundColor = kTitleColor;
        [_dealBtn setTitle:@"交易"];
        _dealBtn.titleLb.textColor = kUIColorFromRGB(0xffffff);
        [_dealBtn setImgStr:@"ic_bottombar_deal"];
        _dealBtn.tag = 5;
        [_dealBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_dealBtn addSubview:self.line5];
        [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.equalTo(_dealBtn);
            make.width.equalTo(@(0.5 * kScale));
        }];
    }
    return _dealBtn;
}

- (TaoIndexLeftBtn *)buyBtn {
    if (_buyBtn == nil) {
        _buyBtn = [TaoIndexLeftBtn new];
        _buyBtn.backgroundColor = kTitleColor;
        [_buyBtn setTitle:@"买入"];
        _buyBtn.titleLb.textColor = kUIColorFromRGB(0xffffff);
        [_buyBtn setImgStr:@"ic_bottombar_down"];
        _buyBtn.tag = 1;
        [_buyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        [_buyBtn addSubview:self.line2];
//        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.bottom.top.equalTo(_buyBtn);
//            make.width.equalTo(@(0.5 * kScale));
//        }];
    }
    return _buyBtn;
}

- (TaoIndexLeftBtn *)saleBtn {
    if (_saleBtn == nil) {
        _saleBtn = [TaoIndexLeftBtn new];
        _saleBtn.backgroundColor = kUIColorFromRGB(0x358ee7);
        [_saleBtn setTitle:@"卖出"];
        _saleBtn.tag = 2;
        [_saleBtn setImgStr:@"ic_bottombar_up"];
        _saleBtn.titleLb.textColor = kUIColorFromRGB(0xffffff);
        [_saleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_saleBtn addSubview:self.line3];
        [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(_saleBtn);
            make.width.equalTo(@(0.5 * kScale));
        }];
    }
    return _saleBtn;
}

- (TaoIndexLeftBtn *)addBtn {
    if (_addBtn == nil) {
        _addBtn = [TaoIndexLeftBtn new];
        _addBtn.backgroundColor = kUIColorFromRGB(0xffffff);
        [_addBtn setTitle:@"添加自选"];
        _addBtn.tag = 3;
        [_addBtn setImgStr:@"ic_bottombar_add_stock"];
        _addBtn.titleLb.textColor = kUIColorFromRGB(0x666666);
        [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_addBtn addSubview:self.line4];
        [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(_addBtn);
            make.width.equalTo(@(0.5 * kScale));
        }];
    }
    return _addBtn;
}

- (TaoIndexLeftBtn *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [TaoIndexLeftBtn new];
        _moreBtn.backgroundColor = kUIColorFromRGB(0xffffff);
        _moreBtn.titleLb.textColor = kUIColorFromRGB(0x666666);
        [_moreBtn setTitle:@"更多"];
        _moreBtn.tag = 4;
        [_moreBtn setImgStr:@"ic_bottombar_more"];
        [_moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

@end
