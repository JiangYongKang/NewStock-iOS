//
//  StockListTitleCell.m
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockListTitleCell.h"
#import "Defination.h"
#import "MarketConfig.h"

@implementation StockListTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        int Xcenter = MAIN_SCREEN_WIDTH / 2;
        
        _stockNameLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
        _stockNameLb.backgroundColor = [UIColor clearColor];
        _stockNameLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
        _stockNameLb.font = [UIFont systemFontOfSize:12.0f];
        _stockNameLb.text = @"";
        //_stockNameLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_stockNameLb];
        
        
        _valueLb = [[UILabel alloc] initWithFrame:CGRectMake(Xcenter-75, 0, 150, 30)];
        _valueLb.backgroundColor = [UIColor clearColor];
        _valueLb.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
        _valueLb.font = [UIFont systemFontOfSize:12.0f];
        _valueLb.text = @"";
        _valueLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_valueLb];
        
        _lbChangeRate = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-120, 0, 100, 30)];
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        _lbChangeRate.textColor = kUIColorFromRGB(0x666666);//[UIColor darkGrayColor];
        _lbChangeRate.font = [UIFont systemFontOfSize:12.0f];
        _lbChangeRate.text = @"";
        _lbChangeRate.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lbChangeRate];
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [UIImage imageNamed:@""];
        [_editBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [_editBtn setImage:icon forState:UIControlStateNormal];
        [_editBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
        _editBtn.frame = CGRectMake(MAIN_SCREEN_WIDTH-40,0,40,30);
        [_editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_editBtn];
        _editBtn.hidden = YES;
        
        self.contentView.backgroundColor = TITLE_BAR_BG_COLOR;
    }
    return self;
}



- (void)setName:(NSString *)name value:(NSString *)value changeRate:(NSString *)changeRate {
    _stockNameLb.text = name;
    _valueLb.text = value;
    _lbChangeRate.text = changeRate;
    
}

- (void)setEditBtn:(UIImage *)img {
    if (img == nil) {
        _editBtn.hidden = YES;
    } else {
        _editBtn.hidden = NO;
        [_editBtn setImage:img forState:UIControlStateNormal];
    }
}

#pragma mark - Button Actions

- (void)editBtnAction:(UIButton *)sender {
    if([_delegate respondsToSelector:@selector(stockListTitleCell:selectedIndex:)]) {
        [_delegate stockListTitleCell:self selectedIndex:self.tag];
    }
}


@end
