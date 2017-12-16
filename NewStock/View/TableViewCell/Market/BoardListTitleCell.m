//
//  BoardListTitleCell.m
//  NewStock
//
//  Created by Willey on 16/8/8.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BoardListTitleCell.h"
#import "Defination.h"
#import "MarketConfig.h"

@implementation BoardListTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _stockNameLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
        _stockNameLb.backgroundColor = [UIColor clearColor];
        _stockNameLb.textColor = [UIColor darkGrayColor];
        _stockNameLb.font = [UIFont systemFontOfSize:12.0f];
        _stockNameLb.text = @"";
        //_stockNameLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_stockNameLb];
        
               
        _lbChangeRate = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH/2-60, 0, 100, 30)];
        _lbChangeRate.backgroundColor = [UIColor clearColor];
        _lbChangeRate.textColor = [UIColor darkGrayColor];
        _lbChangeRate.font = [UIFont systemFontOfSize:12.0f];
        _lbChangeRate.text = @"";
        _lbChangeRate.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lbChangeRate];
        
        _leadingStockLb  = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-120, 0, 105, 30)];
        _leadingStockLb.backgroundColor = [UIColor clearColor];
        _leadingStockLb.textColor = [UIColor darkGrayColor];
        _leadingStockLb.font = [UIFont systemFontOfSize:12.0f];
        _leadingStockLb.text = @"";
        _leadingStockLb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_leadingStockLb];
        
        self.contentView.backgroundColor = TITLE_BAR_BG_COLOR;
    }
    return self;
}



- (void)setName:(NSString *)name changeRate:(NSString *)changeRate leadingStock:(NSString *)leadingStock
{
    _stockNameLb.text = name;
    _lbChangeRate.text = changeRate;
    _leadingStockLb.text = leadingStock;

}
@end
