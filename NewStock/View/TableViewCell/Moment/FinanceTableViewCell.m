//
//  FinanceTableViewCell.m
//  NewStock
//
//  Created by Willey on 16/8/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "FinanceTableViewCell.h"
#import "Defination.h"

@implementation FinanceTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        int cellHeight = 160;
        int cellWidth = MAIN_SCREEN_WIDTH;
        
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, cellWidth, cellHeight-4)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        
        
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = [UIFont systemFontOfSize:14.0f];
        _titleLb.text = @"";
        _titleLb.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_titleLb];
        
        
        _titleLb2 = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-120, 5,120, 25)];
        _titleLb2.backgroundColor = [UIColor clearColor];
        _titleLb2.textColor = [UIColor darkGrayColor];
        _titleLb2.font = [UIFont systemFontOfSize:12.0f];
        _titleLb2.text = @"";
        _titleLb2.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_titleLb2];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35, MAIN_SCREEN_WIDTH, 0.5)];
        line.backgroundColor  = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
        [_bgView addSubview:line];
        
        _contentLb = [[UILabel alloc] initWithFrame:CGRectMake(10, line.frame.origin.y+5, MAIN_SCREEN_WIDTH-20, cellHeight-line.frame.origin.y-10)];
        _contentLb.backgroundColor = [UIColor clearColor];
        _contentLb.textColor = [UIColor darkGrayColor];
        _contentLb.font = [UIFont systemFontOfSize:12.0f];
        _contentLb.numberOfLines = 0;
        _contentLb.text = @"";
        _contentLb.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_contentLb];
        
        
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (void)setTitle:(NSString *)title title2:(NSString *)title2 content:(NSDictionary *)contentDic
{
    _titleLb.text = title;
    _titleLb2.text = title2;

    //NSMutableString *str = [[NSMutableString alloc] init];

    //for (NSString *key in contentDic)
    //{
        
        //[str appendString:[NSString stringWithFormat:@"  %@  %@        ",key,[dic objectForKey:key]]];
    //}
}
-(void)setModel:(id)model
{
    
}

@end
