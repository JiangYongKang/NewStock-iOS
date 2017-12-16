//
//  TalkView.m
//  NewStock
//
//  Created by Willey on 16/8/16.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "TalkView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Defination.h"
#import "MarketConfig.h"

@implementation TalkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
//        [[self layer] setBorderWidth:0.5];
//        [[self layer] setBorderColor:kUIColorFromRGB(0xd3d3d3).CGColor];//SEP_BG_COLOR.CGColor
//        
        //[[self layer] setShadowOffset:CGSizeMake(1, 1)];
//        [[self layer] setShadowRadius:5];
        //[[self layer] setShadowOpacity:1];
       // [[self layer] setShadowColor:[UIColor lightGrayColor].CGColor];
        
        
        _headerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 30, 30)];
        _headerIcon.image = [UIImage imageNamed:@"header_placeholder"];
        [self addSubview:_headerIcon];
        _headerIcon.layer.cornerRadius = 15;
        _headerIcon.layer.masksToBounds = YES;
        
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(_headerIcon.frame.origin.x+_headerIcon.frame.size.width+10, 10, self.frame.size.width-60,15)];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = kUIColorFromRGB(0x666666);//(0x666666);//[UIColor blackColor];
        _titleLb.font = [UIFont systemFontOfSize:12];
        _titleLb.text = @"";
        [self addSubview:_titleLb];

        _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(_headerIcon.frame.origin.x+_headerIcon.frame.size.width+10, 25, self.frame.size.width-60,15)];
        _timeLb.backgroundColor = [UIColor clearColor];
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.textColor = kUIColorFromRGB(0xb2b2b2);
        _timeLb.font = [UIFont systemFontOfSize:10];
        _timeLb.text = @"";
        [self addSubview:_timeLb];
        
        
     
        
        _descLb = [[UILabel alloc] initWithFrame:CGRectMake(15, _headerIcon.frame.origin.y+_headerIcon.frame.size.height+3, self.frame.size.width-30,frame.size.height-50)];
        _descLb.backgroundColor = [UIColor clearColor];
        _descLb.textColor = kUIColorFromRGB(0x333333);//(0x333333);
        _descLb.font = [UIFont systemFontOfSize:13];
        _descLb.numberOfLines = 6;
        _descLb.textAlignment = NSTextAlignmentLeft;
        _descLb.text = @"";
        [self addSubview:_descLb];
//        [_descLb mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_titleLb.mas_bottom).offset(10);
//            make.left.equalTo(_descLb.superview).offset(10);
//            make.right.equalTo(_descLb.superview).offset(-10);
//            make.height.equalTo(_descLb.superview).multipliedBy(0.4);
//        }];
    
    

    }
    return self;
}

-(void)setHeaderImg:(NSString *)url
{
    [_headerIcon sd_setImageWithURL:[NSURL URLWithString:url]
                  placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
}

-(void)setTitle:(NSString *)title timeStr:(NSString *)timeStr content:(NSString *)content
{
    _titleLb.text = title;
    //_timeLb.text = timeStr;
    //_descLb.text = content;
    
    
//    if ([timeStr length]>5) {
//        _timeLb.text = [timeStr substringFromIndex:[timeStr length]-5];
//    }
    _timeLb.text = timeStr;

    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    _descLb.attributedText = attributedString;
}

@end
