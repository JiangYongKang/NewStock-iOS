//
//  StockTitleTableViewCell.m
//  NewStock
//
//  Created by Willey on 16/7/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockTitleTableViewCell.h"
#import "Defination.h"

@implementation StockTitleTableViewCell
@synthesize delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame = CGRectMake(MAIN_SCREEN_WIDTH-50, 12, 50, 30);
        [_moreBtn setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreBtn];
        
        self.backgroundColor = kUIColorFromRGB(0xffffff);
        self.textLabel.backgroundColor = [UIColor clearColor];
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 10)];
        topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        [self.contentView addSubview:topView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect adjustedFrame = self.accessoryView.frame;
    adjustedFrame.origin.x = 10.0f;
    adjustedFrame = CGRectMake(5, 16, 20, 20);
    self.accessoryView.frame = adjustedFrame;
    
    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.origin.x += 15;
    textLabelFrame.origin.y += 7;
    
    self.textLabel.frame = textLabelFrame;
    
    
}

-(void)moreBtnAction:(UIButton *)sender
{
    if([delegate respondsToSelector:@selector(stockTitleTableViewCell:selectedIndex:)])
    {
        [delegate stockTitleTableViewCell:self selectedIndex:self.tag];
    }
}

@end
