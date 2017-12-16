//
//  StrategyView.m
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StrategyView.h"
#import "Masonry.h"
#import "Defination.h"
#import "MarketConfig.h"

@implementation StrategyView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _bgImgView = [[UIImageView alloc] init];
        [self addSubview:_bgImgView];
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bgImgView.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
        }];
        
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = [UIColor blackColor];
        bg.alpha = 0.6;
        [self addSubview:bg];
        [bg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bgImgView.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
        }];
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.font = [UIFont boldSystemFontOfSize:14];
        _titleLb.text = @"";
        [self addSubview:_titleLb];
        [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.superview).offset(10);
            make.left.equalTo(_titleLb.superview).offset(5);
            make.right.equalTo(_titleLb.superview).offset(-5);
            make.height.equalTo(_titleLb.superview).multipliedBy(0.4);
            //make.edges.equalTo(_bgImgView.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
        }];
        
        _descLb = [[UILabel alloc] init];
        _descLb.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        //_descLb.textColor = RISE_COLOR;
        _descLb.font = [UIFont boldSystemFontOfSize:12.0f];
        _descLb.numberOfLines = 0;
        _descLb.textAlignment = NSTextAlignmentCenter;
        _descLb.text = @"";
        [self addSubview:_descLb];
        [_descLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.mas_bottom).offset(0);
            make.centerX.equalTo(_titleLb.mas_centerX);
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/3-4);
            make.height.mas_equalTo(32);
        }];
        _descLb.layer.cornerRadius = 16;
        _descLb.layer.masksToBounds = YES;
        
//        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//        gensture.delegate = self;
//        [self addGestureRecognizer:gensture];
    }
    return self;
}

- (void)setDelegate:(id)theDelegate tag:(int)tag
{
    self.delegate = theDelegate;
    self.tag = tag;
}

-(void)setImgUrl:(NSString *)url
{
    [_bgImgView sd_setImageWithURL:[NSURL URLWithString:url]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
-(void)setTitle:(NSString *)title content:(NSString *)content
{
    _titleLb.text = title;
    
    if ([content floatValue]>0.000001)
    {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"累计涨幅:%@",content]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,5)];
        [str addAttribute:NSForegroundColorAttributeName value:RISE_COLOR range:NSMakeRange(5,str.length-5)];
        _descLb.attributedText = str;
        
        //_descLb.textColor = RISE_COLOR;
        //_descLb.text = [NSString stringWithFormat:@"累计涨幅:%@",content];
    }
    else if ([content floatValue]<0.000001)
    {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"累计涨幅:%@",content]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,5)];
        [str addAttribute:NSForegroundColorAttributeName value:FALL_COLOR range:NSMakeRange(5,str.length-5)];
        _descLb.attributedText = str;
        
        //_descLb.textColor = FALL_COLOR;
        //_descLb.text = [NSString stringWithFormat:@"累计涨幅:%@",content];
    }
    else
    {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"累计涨幅:%@",content]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,5)];
        [str addAttribute:NSForegroundColorAttributeName value:PLAN_COLOR range:NSMakeRange(5,str.length-5)];
        _descLb.attributedText = str;
    }
}

#pragma mark - IndexBlockDelegate
- (void)tapAction
{
    if([delegate respondsToSelector:@selector(strategyView:tag:)])
    {
        [delegate strategyView:self tag:self.tag];
    }
}


@end
