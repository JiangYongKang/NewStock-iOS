//
//  DrawLotsView.m
//  NewStock
//
//  Created by Willey on 16/11/10.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "DrawLotsView.h"
#import "Masonry.h"
#import "Defination.h"
#import "MarketConfig.h"

@implementation DrawLotsView

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
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = [UIColor whiteColor];
        [self addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
//        [[bg layer] setBorderWidth:0.5];
//        [[bg layer] setBorderColor:SEP_LINE_COLOR.CGColor];
        
        //drawTitleBg
        UIImageView *drawTitleBg = [[UIImageView alloc] init];
        drawTitleBg.image = [UIImage imageNamed:@"drawTitleBg"];
        [self addSubview:drawTitleBg];
        [drawTitleBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(bg).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(21);
        }];
        
        UILabel *drawTitleBgLb = [[UILabel alloc] init];
        drawTitleBgLb.backgroundColor = [UIColor clearColor];
        drawTitleBgLb.textAlignment = NSTextAlignmentCenter;
        drawTitleBgLb.textColor = [UIColor whiteColor];
        drawTitleBgLb.font = [UIFont systemFontOfSize:11];
        drawTitleBgLb.text = @"股中取乐";
        [drawTitleBg addSubview:drawTitleBgLb];
        [drawTitleBgLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(drawTitleBgLb.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
        }];
        
       
        
        //
        UIImageView *headerImgView = [[UIImageView alloc] init];
        headerImgView.image = [UIImage imageNamed:@"LuckyCat"];
        [bg addSubview:headerImgView];
        [headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bg).offset(20);
            make.left.equalTo(bg).offset(10);
            make.width.mas_equalTo(60 * kScale);
            make.height.mas_equalTo(60 * kScale);
        }];
        
        UILabel *drawSubTitleBgLb = [[UILabel alloc] init];
        drawSubTitleBgLb.backgroundColor = [UIColor clearColor];
        drawSubTitleBgLb.textAlignment = NSTextAlignmentCenter;
        drawSubTitleBgLb.textColor = kUIColorFromRGB(0x333333);
        drawSubTitleBgLb.font = [UIFont boldSystemFontOfSize:11];
        drawSubTitleBgLb.text = @"摇一摇";
        [bg addSubview:drawSubTitleBgLb];
        [drawSubTitleBgLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerImgView.mas_bottom).offset(10);
            make.left.equalTo(headerImgView);
            make.width.equalTo(headerImgView);
            make.height.mas_equalTo(15);
        }];
        UILabel *drawSubTitleBgLb2 = [[UILabel alloc] init];
        drawSubTitleBgLb2.backgroundColor = [UIColor clearColor];
        drawSubTitleBgLb2.textAlignment = NSTextAlignmentCenter;
        drawSubTitleBgLb2.textColor = kUIColorFromRGB(0x333333);
        drawSubTitleBgLb2.font = [UIFont boldSystemFontOfSize:12];
        drawSubTitleBgLb2.text = @"今日财运";
        [bg addSubview:drawSubTitleBgLb2];
        [drawSubTitleBgLb2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(drawSubTitleBgLb.mas_bottom).offset(2);
            make.left.equalTo(headerImgView);
            make.width.equalTo(headerImgView);
            make.height.mas_equalTo(15);
        }];
        
        
        
        UIImageView *tailImgView = [[UIImageView alloc] init];
        tailImgView.image = [UIImage imageNamed:@"drawLots"];
        [bg addSubview:tailImgView];
        [tailImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bg).offset(10 * kScale);
            make.right.equalTo(bg).offset(-5 * kScale);
            make.width.mas_equalTo(60 * kScale);
            make.height.mas_equalTo(90 * kScale);
        }];
        tailImgView.hidden = YES;
        
        //
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundImage:[UIImage imageNamed:@"drawLots"] forState:UIControlStateNormal];
        //[_likeBtn setImage:[UIImage imageNamed:@"ic_zan_pre"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bg).offset(10);
            make.right.equalTo(bg).offset(-5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(90);
        }];
        
        
        UILabel *tailTitleLb = [[UILabel alloc] init];
        tailTitleLb.backgroundColor = [UIColor clearColor];
        tailTitleLb.textAlignment = NSTextAlignmentCenter;
        tailTitleLb.textColor = kUIColorFromRGB(0x333333);
        tailTitleLb.font = [UIFont boldSystemFontOfSize:11 * kScale];
        tailTitleLb.text = @"财神爷灵签";
        [bg addSubview:tailTitleLb];
        
        [tailTitleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(drawSubTitleBgLb2).offset(0);
            make.right.equalTo(self).offset(-7 * kScale);
            make.height.mas_equalTo(15 * kScale);
        }];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor clearColor];//SEP_LINE_COLOR;
        [bg addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bg).offset(25);
            make.left.equalTo(tailImgView.mas_left).offset(-5 * kScale);
            make.bottom.equalTo(bg).offset(-20);
            make.width.mas_equalTo(0.5);
        }];
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = kUIColorFromRGB(0x333333);
        _titleLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
        _titleLb.text = @"";
        [bg addSubview:_titleLb];
        [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bg).offset(25);
            make.left.equalTo(headerImgView.mas_right).offset(5);
            make.right.equalTo(tailImgView.mas_left).offset(-5);
            make.height.equalTo(_titleLb.superview).multipliedBy(0.2);
            //make.edges.equalTo(_bgImgView.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
        }];
        
        _descLb = [[UILabel alloc] init];
        _descLb.backgroundColor = [UIColor clearColor];
        _descLb.font = [UIFont systemFontOfSize:14.0f * kScale];
        _descLb.numberOfLines = 0;
        _descLb.textAlignment = NSTextAlignmentCenter;
        _descLb.textColor = kUIColorFromRGB(0x666666);
        _descLb.text = @"";
        [bg addSubview:_descLb];
        [_descLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.mas_bottom).offset(5);
            make.left.equalTo(headerImgView.mas_right).offset(5);
            make.right.equalTo(tailImgView.mas_left).offset(-5);
            make.height.equalTo(_titleLb.superview).multipliedBy(0.4);
        }];

        
        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        gensture.delegate = self;
        [self addGestureRecognizer:gensture];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title content:(NSString *)content {
    _titleLb.text = title;
    
    _descLb.text = content;
}

#pragma mark 
- (void)tapAction
{
    if([self.delegate respondsToSelector:@selector(drawLotsView:drawId:)])
    {
        [self.delegate drawLotsView:self drawId:@""];
    }
}

- (void)btnAction
{
    if([self.delegate respondsToSelector:@selector(drawLotsView:)])
    {
        [self.delegate drawLotsView:self];
    }
}

@end
