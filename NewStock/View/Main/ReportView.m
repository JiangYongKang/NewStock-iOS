//
//  ReportView.m
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ReportView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Defination.h"
#import "MarketConfig.h"

@implementation ReportView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
//        [[self layer] setBorderWidth:0.5];
//        [[self layer] setBorderColor:SEP_BG_COLOR.CGColor];
        
        [[self layer] setShadowOffset:CGSizeMake(1, 1)];
//        [[self layer] setShadowRadius:5];
        [[self layer] setShadowOpacity:1];
        [[self layer] setShadowColor:[UIColor lightGrayColor].CGColor];
        
        
        _headerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 30, 30)];
        _headerIcon.image = [UIImage imageNamed:@"header_placeholder"];
        [self addSubview:_headerIcon];
        _headerIcon.layer.cornerRadius = 15;
        _headerIcon.layer.masksToBounds = YES;
        
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(_headerIcon.frame.origin.x+_headerIcon.frame.size.width+10, 10, self.frame.size.width-60,15)];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = kUIColorFromRGB(0x666666);//[UIColor blackColor];
        _titleLb.font = [UIFont systemFontOfSize:12];
        _titleLb.text = @"";
        [self addSubview:_titleLb];

        _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(_headerIcon.frame.origin.x+_headerIcon.frame.size.width+10, 25, self.frame.size.width-60,15)];
        _timeLb.backgroundColor = [UIColor clearColor];
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.textColor = kUIColorFromRGB(0xb2b2b2);
        _timeLb.font = [UIFont systemFontOfSize:11];
        _timeLb.text = @"";
        [self addSubview:_timeLb];
        
        
        _tipsLb = [[UILabel alloc] initWithFrame:CGRectMake(_headerIcon.frame.origin.x+_headerIcon.frame.size.width+10, 10, self.frame.size.width-60,30)];
        _tipsLb.backgroundColor = [UIColor clearColor];
        _tipsLb.textAlignment = NSTextAlignmentRight;
        _tipsLb.textColor = kUIColorFromRGB(0xb2b2b2);
        _tipsLb.font = [UIFont systemFontOfSize:11];
        _tipsLb.text = @"";
        [self addSubview:_tipsLb];
        
        _descLb = [[UILabel alloc] initWithFrame:CGRectMake(10, _headerIcon.frame.origin.y+_headerIcon.frame.size.height+5, self.frame.size.width-20,50)];
        _descLb.backgroundColor = [UIColor clearColor];
        _descLb.textColor = kUIColorFromRGB(0x333333);
        _descLb.font = [UIFont systemFontOfSize:12];
        _descLb.numberOfLines = 3;
        _descLb.textAlignment = NSTextAlignmentLeft;
        _descLb.text = @"";
        [self addSubview:_descLb];
//        [_descLb mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_titleLb.mas_bottom).offset(10);
//            make.left.equalTo(_descLb.superview).offset(10);
//            make.right.equalTo(_descLb.superview).offset(-10);
//            make.height.equalTo(_descLb.superview).multipliedBy(0.4);
//        }];
    
        int imgHeight = self.frame.size.height - 110;
        int imgWidth = (self.frame.size.width-20-10)/3;
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, _descLb.frame.origin.y+_descLb.frame.size.height+5, imgWidth,imgHeight)];
        [self addSubview:_imgView1];
        
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10+imgWidth+5, _descLb.frame.origin.y+_descLb.frame.size.height+5, imgWidth,imgHeight)];
        [self addSubview:_imgView2];
        
        _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10+imgWidth*2+5*2, _descLb.frame.origin.y+_descLb.frame.size.height+5, imgWidth,imgHeight)];
        [self addSubview:_imgView3];
        
        
        
        _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(_imgView1.frame.origin.x, _imgView1.frame.origin.y+_imgView1.frame.size.height+5, _imgView1.frame.size.width, 25)];
        [_btn1 setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
        [_btn1 setTitle:@"(0)" forState:UIControlStateNormal];
        [_btn1 setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:12];
//        [_btn1 setImageEdgeInsets:UIEdgeInsetsMake(3, 15, 20, 15)];
//        [_btn1 setTitleEdgeInsets:UIEdgeInsetsMake(20, -30, 0, 0)];
        _btn1.tag = 1;
        [_btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn1];
        _btn1.userInteractionEnabled = NO;
        _btn1.hidden = YES;
        
        _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(_imgView2.frame.origin.x, _imgView2.frame.origin.y+_imgView2.frame.size.height+5, _imgView2.frame.size.width, 25)];
        [_btn2 setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_btn2 setTitle:@"(0)" forState:UIControlStateNormal];
        [_btn2 setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:12];
        _btn2.tag = 2;
        [_btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn2];
        _btn2.userInteractionEnabled = NO;
        _btn2.hidden = YES;

        _btn3 = [[UIButton alloc] initWithFrame:CGRectMake(_imgView3.frame.origin.x, _imgView3.frame.origin.y+_imgView3.frame.size.height+5, _imgView3.frame.size.width, 25)];
        [_btn3 setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
        [_btn3 setTitle:@"(0)" forState:UIControlStateNormal];
        [_btn3 setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont systemFontOfSize:12];
        _btn3.tag = 3;
        [_btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn3];
        _btn3.userInteractionEnabled = NO;
        _btn3.hidden = YES;

    }
    return self;
}

-(void)setHeaderImg:(NSString *)url
{
    [_headerIcon sd_setImageWithURL:[NSURL URLWithString:url]
                  placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
}

-(void)setImg1Url:(NSString *)url
{
    [_imgView1 sd_setImageWithURL:[NSURL URLWithString:url]
                  placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
-(void)setImg2Url:(NSString *)url
{
    [_imgView2 sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
-(void)setImg3Url:(NSString *)url
{
    [_imgView3 sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
-(void)setTitle:(NSString *)title timeStr:(NSString *)timeStr content:(NSString *)content
{
    _titleLb.text = title;
    //_timeLb.text = timeStr;
    //_descLb.text = content;
    
    
    if ([timeStr length]>5) {
        _timeLb.text = [timeStr substringFromIndex:[timeStr length]-5];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3.0];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    _descLb.attributedText = attributedString;
}

-(void)setLkd:(NSString *)lkd cs:(NSString *)cs fd:(NSString *)fd
{
    _tipsLb.text = [NSString stringWithFormat:@"阅读%@ | 点赞%@",cs,lkd];
    [_btn1 setTitle:[NSString stringWithFormat:@"（%@）",lkd] forState:UIControlStateNormal];
    [_btn2 setTitle:[NSString stringWithFormat:@"（%@）",cs] forState:UIControlStateNormal];
    [_btn3 setTitle:[NSString stringWithFormat:@"（%@）",fd] forState:UIControlStateNormal];
}

#pragma mark - Button Actions
- (void)btnAction:(UIButton*)sender
{
    if([delegate respondsToSelector:@selector(reportView:actionIndex:)])
    {
        if (sender.tag == 0)
        {
            [delegate reportView:self actionIndex:REPORTVIEW_ACTION_LKD];
        }
        else if(sender.tag == 1)
        {
            [delegate reportView:self actionIndex:REPORTVIEW_ACTION_CS];
        }
        else if(sender.tag == 2)
        {
            [delegate reportView:self actionIndex:REPORTVIEW_ACTION_FD];
        }
    }

    
}

@end
