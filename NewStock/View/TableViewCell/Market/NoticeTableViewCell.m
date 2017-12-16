//
//  NoticeTableViewCell.m
//  NewStock
//
//  Created by Willey on 16/8/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "NoticeTableViewCell.h"
#import "Defination.h"

@implementation NoticeTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        int cellHeight = 80;
        int cellWidth = MAIN_SCREEN_WIDTH;
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, cellWidth, cellHeight-4)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        _contentLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, MAIN_SCREEN_WIDTH-20, 45)];
        _contentLb.backgroundColor = [UIColor clearColor];
        _contentLb.textColor = [UIColor blackColor];
        _contentLb.font = [UIFont systemFontOfSize:14.0f];
        _contentLb.numberOfLines = 0;
        _contentLb.text = @"";
        _contentLb.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_contentLb];

        
        _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-100, _contentLb.frame.origin.y+_contentLb.frame.size.height, 100, 20)];
        _timeLb.backgroundColor = [UIColor clearColor];
        _timeLb.textColor = [UIColor darkGrayColor];
        _timeLb.font = [UIFont systemFontOfSize:12.0f];
        _timeLb.text = @"";
        _timeLb.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_timeLb];
        
      
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (void)setContent:(NSString *)content time:(NSString *)time
{
    _timeLb.text = time;
    _contentLb.text = content;
    
}
-(void)setModel:(id)model
{
    
}


@end
