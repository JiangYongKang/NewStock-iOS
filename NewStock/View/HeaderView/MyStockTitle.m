//
//  MyStockTitle.m
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MyStockTitle.h"
#import "Defination.h"
#import "MarketConfig.h"
#import <Masonry.h>

@implementation MyStockTitle

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        int Xcenter = MAIN_SCREEN_WIDTH / 2;
        
        _stockNameLb = [[UILabel alloc] init];
        _stockNameLb.backgroundColor = [UIColor clearColor];
        _stockNameLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
        _stockNameLb.font = [UIFont systemFontOfSize:13.0f * kScale];
        _stockNameLb.text = @"";
        //_stockNameLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_stockNameLb];
        
        [_stockNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@(12 * kScale));
        }];
        
        _valueLb = [[UILabel alloc] init];
        _valueLb.backgroundColor = [UIColor clearColor];
        _valueLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
        _valueLb.font = [UIFont systemFontOfSize:13.0f * kScale];
        _valueLb.text = @"";
        _valueLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_valueLb];
        
        [_valueLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        _lbChangeRate = [[UILabel alloc] init];
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        _lbChangeRate.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
        _lbChangeRate.font = [UIFont systemFontOfSize:13.0f * kScale];
        _lbChangeRate.text = @"";
        _lbChangeRate.textAlignment = NSTextAlignmentRight;
        [self addSubview:_lbChangeRate];
        [_lbChangeRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(- 25 * kScale);
        }];
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [UIImage imageNamed:@"ic_myStock_edit_nor"];
        [_editBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [_editBtn setImage:icon forState:UIControlStateNormal];
        [_editBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -17, 0, 7)];
//        _editBtn.backgroundColor = [UIColor redColor];r
        [_editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_editBtn];
        _editBtn.hidden = YES;
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(12 * kScale);
            make.width.equalTo(@(40 * kScale));
        }];
        
        
        _sortType = STOCK_SORT_NORMAL;
        _sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sortBtn setImageEdgeInsets:UIEdgeInsetsMake(9, 28, 9, 60)];
        [_sortBtn setImage:[UIImage imageNamed:@"sort_nor"] forState:UIControlStateNormal];
        [_sortBtn addTarget:self action:@selector(sortBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sortBtn];
        [_sortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12 * kScale);
            make.centerY.equalTo(self);
            make.width.equalTo(@(100 * kScale));
            make.height.equalTo(@(30 * kScale));
        }];
        _sortBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 42 * kScale, 0, - 42 * kScale);
        
        self.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return self;
}

- (void)setName:(NSString *)name value:(NSString *)value changeRate:(NSString *)changeRate {
    _stockNameLb.text = name;
    _valueLb.text = value;
    _lbChangeRate.text = changeRate;
}

- (void)setEditBtn:(UIImage *)img {
    if (img == nil)
    {
        _editBtn.hidden = YES;
    }
    else
    {
        _editBtn.hidden = NO;
        [_editBtn setImage:img forState:UIControlStateNormal];
    }
}

#pragma mark - Button Actions

- (void)editBtnAction:(UIButton*)sender {
    if([_delegate respondsToSelector:@selector(myStockTitle:selectedIndex:)])
    {
        [_delegate myStockTitle:self selectedIndex:self.tag];
    }
}

- (void)sortBtnAction:(UIButton*)sender {
    if (_sortType == STOCK_SORT_NORMAL)
    {
        [_sortBtn setImage:[UIImage imageNamed:@"sort_down"] forState:UIControlStateNormal];
        _sortType = STOCK_SORT_DOWN;
    }
    else if (_sortType == STOCK_SORT_DOWN)
    {
        [_sortBtn setImage:[UIImage imageNamed:@"sort_up"] forState:UIControlStateNormal];
        _sortType = STOCK_SORT_UP;
    }
    else
    {
        [_sortBtn setImage:[UIImage imageNamed:@"sort_nor"] forState:UIControlStateNormal];
        _sortType = STOCK_SORT_NORMAL;
    }
    
    if([_delegate respondsToSelector:@selector(myStockTitle:sortType:)])
    {
        [_delegate myStockTitle:self sortType:_sortType];
    }
}

@end
