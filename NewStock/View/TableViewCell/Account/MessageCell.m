//
//  MessageCell.m
//  NewStock
//
//  Created by Willey on 16/10/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MessageCell.h"
#import "Defination.h"
#import "UIImageView+WebCache.h"

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        int cellHeight = 70;
        int cellWidth = MAIN_SCREEN_WIDTH;
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        _headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        _headerImg.image = [UIImage imageNamed:@"shareLogo"];
        [bgView addSubview:_headerImg];
        
        
        _stockNameLb = [[UILabel alloc] initWithFrame:CGRectMake(_headerImg.frame.origin.x+_headerImg.frame.size.width+15, 15, 120, 20)];
        _stockNameLb.backgroundColor = [UIColor clearColor];
        _stockNameLb.textColor = kUIColorFromRGB(0x358ee7);
        _stockNameLb.font = [UIFont systemFontOfSize:15.0f];
        _stockNameLb.text = @"";
        _stockNameLb.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_stockNameLb];
        
        
        _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth-135, 15, 120, 20)];
        _timeLb.backgroundColor = [UIColor clearColor];
        _timeLb.textColor = kUIColorFromRGB(0xb2b2b2);
        _timeLb.font = [UIFont systemFontOfSize:11.0f];
        _timeLb.text = @"";
        _timeLb.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:_timeLb];
        
        
        _contentLb = [[UILabel alloc] initWithFrame:CGRectMake(_headerImg.frame.origin.x+_headerImg.frame.size.width+15, _stockNameLb.frame.origin.y+_stockNameLb.frame.size.height, MAIN_SCREEN_WIDTH-90, 20)];
        _contentLb.backgroundColor = [UIColor clearColor];
        _contentLb.textColor = kUIColorFromRGB(0x999999);
        _contentLb.font = [UIFont systemFontOfSize:12.0f];
        _contentLb.numberOfLines = 0;
        _contentLb.text = @"";
        _contentLb.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_contentLb];
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (void)setName:(NSString *)name time:(NSString *)time content:(NSString *)content {
    _stockNameLb.text = name;
    _timeLb.text = time;
    _contentLb.text = content;
    
}

- (void)setHeader:(NSString *)str {
    
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:str]
                  placeholderImage:[UIImage imageNamed:@"shareLogo"]];
}

@end
