//
//  NavBar.m
//  YZLoan
//
//  Created by Willey Wang on 6/4/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "NavBar.h"
#import "Defination.h"
#import "SystemUtil.h"

@implementation NavBar

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];//[SystemUtil hexStringToColor:@"#005dae"];
        
        _background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBar_bg.png"]];
        _background.frame = self.bounds;
        [self addSubview:_background];
        
        int nY = IOS7_OR_LATER ? 20 : 0;
        
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake((int)(self.bounds.size.width - 220 * kScale)/2, nY + (int)(self.bounds.size.height - nY - 40)/2, 220 * kScale, 40)];
        _titleLb.text = @"";
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = [UIFont boldSystemFontOfSize:18];
        _titleLb.textColor = kUIColorFromRGB(0x333333);//[UIColor whiteColor];
        [self addSubview:_titleLb];
        
        _subTitleLb = [[UILabel alloc] initWithFrame:CGRectMake((int)(self.bounds.size.width - 190)/2, nY + (int)(self.bounds.size.height - nY - 40)/2, 190, 40)];
        _subTitleLb.text = @"";
        _subTitleLb.backgroundColor = [UIColor clearColor];
        _subTitleLb.textAlignment = NSTextAlignmentCenter;
        _subTitleLb.font = [UIFont systemFontOfSize:11];
        _subTitleLb.textColor = kUIColorFromRGB(0x333333);//[UIColor whiteColor];
        [self addSubview:_subTitleLb];
        _subTitleLb.hidden = YES;
        
        //right btn
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [UIImage imageNamed:@"navbar_back"];
        [_leftButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_leftButton setImage:icon forState:UIControlStateNormal];
        [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(7, 12, 7, 12)];
        _leftButton.frame = CGRectMake(0,nY+2,50,40);//(15, nY + 10, 16, 24);
        [_leftButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
        //left btn
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon1 = [UIImage imageNamed:@"navBar_settings.png"];
        [_rightButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_rightButton setImage:icon1 forState:UIControlStateNormal];
        [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(7, 22, 7, 2)];
        [_rightButton setContentMode:UIViewContentModeRight];
        [_rightButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        //[_rightButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 15)];
        _rightButton.frame = CGRectMake(frame.size.width - 60, nY + 2, 50, 40);
        [_rightButton addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        
        //right btn 1 2
        _rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton1.frame = CGRectMake(frame.size.width-90, nY + 2, 35, 40);
        _rightButton1.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton1 setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_rightButton1 addTarget:self action:@selector(rightBtn1Action:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton1];
        _rightButton1.hidden = YES;
        
        _rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton2.frame = CGRectMake(frame.size.width-42, nY + 2, 35, 40);
        _rightButton2.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_rightButton2 setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_rightButton2 addTarget:self action:@selector(rightBtn2Action:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton2];
        _rightButton2.hidden = YES;
        
        //未读消息提示
        _bageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_icon_message_num_bg.png"]];
        [_bageView setFrame:CGRectMake(frame.size.width-25, nY + 5, 18, 18)];
        [self addSubview:_bageView];
        
        _bageNumber=[[UILabel alloc]initWithFrame:CGRectMake(0,0, _bageView.frame.size.width, _bageView.frame.size.height)];
        [_bageNumber setBackgroundColor:[UIColor clearColor]];
        [_bageNumber setTextAlignment:NSTextAlignmentCenter];
        [_bageNumber setTextColor:[UIColor whiteColor]];
        [_bageNumber setFont:[UIFont boldSystemFontOfSize:10]];
        [_bageView addSubview:_bageNumber];
        _bageNumber.text = @"";
        
        _bageView.hidden = YES;
        
        self.line_view = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, MAIN_SCREEN_WIDTH, 0.5)];
        self.line_view.backgroundColor = kUIColorFromRGB(0xd3d3d3);
        
        [self addSubview:_line_view];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
	if(title) {
        _titleLb.text = title;
    }
}

- (void)setSubTitle:(NSString *)title {
    if (title) {
        _subTitleLb.hidden = NO;

        _subTitleLb.text = title;
        
        _titleLb.font = [UIFont systemFontOfSize:16];

        _titleLb.frame = CGRectMake((int)(self.bounds.size.width - 190)/2, 20 + (int)(self.bounds.size.height - 20 - 35)/2, 190, 20);
        _subTitleLb.frame = CGRectMake((int)(self.bounds.size.width - 190)/2, _titleLb.frame.origin.y+_titleLb.frame.size.height, 190, 15);
    }
}

- (void)setNavBg:(UIImage *)image {
    [_background setImage:image];
}

- (void)setLeftBtnImg:(UIImage *)image {
    if (image == nil)
    {
        _leftButton.hidden = YES;
    }
    else
    {
        _leftButton.hidden = NO;
        [_leftButton setTitle:nil forState:UIControlStateNormal];
        [_leftButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_leftButton setImage:image forState:UIControlStateNormal];
    }
}

- (void)setRightBtnImg:(UIImage *)image {
    _bageView.hidden = YES;

    if (image == nil) {
        _rightButton.hidden = YES;
    } else {
        _rightButton.hidden = NO;
        [_rightButton setImage:image forState:UIControlStateNormal];
    }
}

- (void)setRIghtImageFrame:(CGRect)frame {
//    int nY = IOS7_OR_LATER ? 20 : 0;
    _rightButton.frame = frame;

}

- (void)setLeftBtnTitle:(NSString *)title {
    if (title == nil)
    {
        _leftButton.hidden = YES;
    }
    else
    {
        _leftButton.hidden = NO;

        [_leftButton setImage:nil forState:UIControlStateNormal];
        [_leftButton setContentEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 5)];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftButton setTitle:title forState:UIControlStateNormal];
        //[_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
}

- (void)setRightBtnTitle:(NSString *)title {
    if (title == nil)
    {
        _rightButton.hidden = YES;
    }
    else
    {
        _rightButton.hidden = NO;

        [_rightButton setContentEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 5)];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitle:title forState:UIControlStateNormal];
    }
    
}

- (void)setRightBtnTitle1:(NSString *)title1 title2:(NSString *)title2 {
    _rightButton1.hidden = NO;
    _rightButton2.hidden = NO;
    [_rightButton1 setTitle:title1 forState:UIControlStateNormal];
    [_rightButton2 setTitle:title2 forState:UIControlStateNormal];

}

- (void)setRightBtnImg:(UIImage *)image withNum:(int)num {
    _bageView.hidden = YES;

    if (image == nil)
    {
        _rightButton.hidden = YES;
    }
    else
    {
        _rightButton.hidden = NO;
        [_rightButton setImage:image forState:UIControlStateNormal];
        
        if (num>0)
        {
            _bageView.hidden = NO;
            _bageNumber.text = [NSString stringWithFormat:@"%d", num];
        }
    }
}

#pragma mark - Button Actions

- (void)leftBtnAction:(UIButton*)sender {
    if([_delegate respondsToSelector:@selector(navBar:leftButtonTapped:)])
    {
        [_delegate navBar:self leftButtonTapped:sender];
    }
}

- (void)rightBtnAction:(UIButton*)sender {
    if([_delegate respondsToSelector:@selector(navBar:rightButtonTapped:)])
    {
        [_delegate navBar:self rightButtonTapped:sender];
    }
}

- (void)rightBtn1Action:(UIButton*)sender {
    if([_delegate respondsToSelector:@selector(navBar:rightButton1Tapped:)])
    {
        [_delegate navBar:self rightButton1Tapped:sender];
    }
}

- (void)rightBtn2Action:(UIButton*)sender {
    if([_delegate respondsToSelector:@selector(navBar:rightButton2Tapped:)])
    {
        [_delegate navBar:self rightButton2Tapped:sender];
    }
}

@end
