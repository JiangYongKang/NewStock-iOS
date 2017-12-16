//
//  TalkStockTableViewCell.m
//  NewStock
//
//  Created by Willey on 16/8/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "TalkStockTableViewCell.h"
#import "Defination.h"

@implementation TalkStockTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        int cellHeight = 120;
        int cellWidth = MAIN_SCREEN_WIDTH;
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, cellWidth, cellHeight-4)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        _headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        _headerImg.image = [UIImage imageNamed:@"headerIcon.png"];
        [bgView addSubview:_headerImg];

        
        _stockNameLb = [[UILabel alloc] initWithFrame:CGRectMake(_headerImg.frame.origin.x+_headerImg.frame.size.width+5, 5, 200, 20)];
        _stockNameLb.backgroundColor = [UIColor clearColor];
        _stockNameLb.textColor = [UIColor blackColor];
        _stockNameLb.font = [UIFont systemFontOfSize:14.0f];
        _stockNameLb.text = @"";
        _stockNameLb.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_stockNameLb];
        
        
        _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(_stockNameLb.frame.origin.x, _stockNameLb.frame.origin.y+_stockNameLb.frame.size.height, 200, 20)];
        _timeLb.backgroundColor = [UIColor clearColor];
        _timeLb.textColor = [UIColor darkGrayColor];
        _timeLb.font = [UIFont systemFontOfSize:12.0f];
        _timeLb.text = @"";
        _timeLb.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_timeLb];
        
        
        _contentLb = [[UILabel alloc] initWithFrame:CGRectMake(10, _headerImg.frame.origin.y+_headerImg.frame.size.height+5, MAIN_SCREEN_WIDTH-20, 25)];
        _contentLb.backgroundColor = [UIColor clearColor];
        _contentLb.textColor = [UIColor darkGrayColor];
        _contentLb.font = [UIFont systemFontOfSize:12.0f];
        _contentLb.numberOfLines = 0;
        _contentLb.text = @"";
        _contentLb.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_contentLb];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _contentLb.frame.origin.y+_contentLb.frame.size.height+5, MAIN_SCREEN_WIDTH, 0.5)];
        line.backgroundColor  = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
        [bgView addSubview:line];

        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(0, line.frame.origin.y+line.frame.size.height+5, MAIN_SCREEN_WIDTH/3, 25);
        [_btn1 setTitle:@"赞(365)" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(btnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn1.tag = 101;
        [self addSubview:_btn1];
        
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(MAIN_SCREEN_WIDTH/3, line.frame.origin.y+line.frame.size.height+5, MAIN_SCREEN_WIDTH/3, 25);
        [_btn2 setTitle:@"回复(35)" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(btnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn2.tag = 102;
        [self addSubview:_btn2];
        
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.frame = CGRectMake(2*MAIN_SCREEN_WIDTH/3, line.frame.origin.y+line.frame.size.height+5, MAIN_SCREEN_WIDTH/3, 25);
        [_btn3 setTitle:@"举报" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_btn3 addTarget:self action:@selector(btnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn3.tag = 103;
        [self addSubview:_btn3];
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (void)setName:(NSString *)name time:(NSString *)time content:(NSString *)content
{
    _stockNameLb.text = name;
    _timeLb.text = time;
    _contentLb.text = content;
    
}
-(void)setModel:(id)model
{
    
}


-(void)btnBtnAction:(UIButton *)sender
{
//    if([delegate respondsToSelector:@selector(stockTitleTableViewCell:selectedIndex:)])
//    {
//        [delegate stockTitleTableViewCell:self selectedIndex:self.tag];
//    }
}

@end
