//
//  NotLoggedInView.m
//  NewStock
//
//  Created by Willey on 16/9/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "NotLoggedInView.h"

@implementation NotLoggedInView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/5,frame.size.width/5)];
        _headerImgView.center = CGPointMake(frame.size.width/2, 100);
        _headerImgView.image = [UIImage imageNamed:@"no_login_header"];
        _headerImgView.alpha = 0.8;
        [self addSubview:_headerImgView];
        
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, _headerImgView.frame.origin.y+_headerImgView.frame.size.height+10, frame.size.width,30)];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = [UIColor lightGrayColor];
        _titleLb.font = [UIFont boldSystemFontOfSize:14];
        _titleLb.text = @"未登录，没有数据！";
        _titleLb.numberOfLines = 0;
        [self addSubview:_titleLb];
        
      
    }
    return self;
}

//

@end
