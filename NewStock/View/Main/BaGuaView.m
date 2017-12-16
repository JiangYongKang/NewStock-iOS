//
//  BaGuaView.m
//  NewStock
//
//  Created by Willey on 16/11/10.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaGuaView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "UIView+Masonry_Arrange.h"

@implementation BaGuaView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
       
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = [UIColor whiteColor];
        [self addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10 * kScale);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];

        _headerView = [[UIImageView alloc] init];
        _headerView.image = [UIImage imageNamed:@"bagua_bg"];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        _headerView.layer.masksToBounds = YES;
        [bg addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bg).offset(0);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.height.mas_equalTo(120 * kScale);
        }];
        
        UIView *headerBg = [[UIView alloc] init];
        headerBg.backgroundColor = [UIColor blackColor];
        headerBg.alpha = 0.4;
        [_headerView addSubview:headerBg];
        [headerBg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_headerView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
        UIView *tipsBg = [[UIView alloc] init];
        tipsBg.backgroundColor = [UIColor clearColor];
        
        [_headerView addSubview:tipsBg];
        [tipsBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView).offset(0);
            make.left.equalTo(_headerView).offset(0);
            make.width.mas_equalTo(70 * kScale);
            make.bottom.equalTo(_headerView);
        }];

        UIView *borderView = [UIView new];
        borderView.backgroundColor = [UIColor clearColor];
        borderView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
        borderView.layer.borderWidth = 1;
        [_headerView addSubview:borderView];
        
        [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(56 * kScale));
            make.height.equalTo(@(77 * kScale));
            make.left.equalTo(_headerView).offset(5 * kScale);
            make.centerY.equalTo(_headerView);
        }];
        
        UILabel *baguaTitleLb = [[UILabel alloc] init];
        baguaTitleLb.backgroundColor = [UIColor clearColor];
        
        NSString *baguaStr = @"金融\n八卦";
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 6 * kScale;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:baguaStr attributes:@{NSParagraphStyleAttributeName : paraStyle}];
        baguaTitleLb.attributedText = attrStr;
        baguaTitleLb.textColor = [UIColor whiteColor];
        baguaTitleLb.font = [UIFont boldSystemFontOfSize:22 * kScale];
        baguaTitleLb.textAlignment = NSTextAlignmentCenter;
        baguaTitleLb.numberOfLines = 2;
        [borderView addSubview:baguaTitleLb];
        [baguaTitleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(borderView).offset(3 * kScale);
            make.centerX.equalTo(borderView);
        }];
        
        UILabel *tipsLb = [[UILabel alloc] init];
        tipsLb.text = @"深阅读";
        tipsLb.textColor = [UIColor whiteColor];
        tipsLb.font = [UIFont systemFontOfSize:10 * kScale];
        tipsLb.backgroundColor = kUIColorFromRGB(0x358ee7);
        tipsLb.layer.cornerRadius = 3 * kScale;
        tipsLb.layer.masksToBounds = YES;
        tipsLb.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:tipsLb];
        [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(borderView.mas_bottom).offset(-10 * kScale);
            make.centerX.equalTo(borderView);
            make.width.mas_equalTo(45 * kScale);
            make.height.mas_equalTo(20 * kScale);
        }];
        
        _titleLb = [[UILabel alloc] init];
        _titleLb.numberOfLines = 2;
        _titleLb.preferredMaxLayoutWidth = 95 * kScale;
        _titleLb.backgroundColor = [UIColor clearColor];
        
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.font = [UIFont boldSystemFontOfSize:20 * kScale];
        _titleLb.text = @"";
        [bg addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipsBg).offset(25 * kScale);
            make.left.equalTo(tipsBg.mas_right).offset(15 * kScale);
            make.right.equalTo(bg).offset(-10 * kScale);
            make.height.mas_equalTo(60 * kScale);
        }];
        
        
        _readCountLb = [[UILabel alloc]init];
        _readCountLb.textColor = kUIColorFromRGB(0xffffff);
        _readCountLb.font = [UIFont systemFontOfSize:11 * kScale];
        _readCountLb.text = @"";
        _readCountLb.textAlignment = NSTextAlignmentRight;
        [bg addSubview:_readCountLb];
        [_readCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerBg).offset(-10 * kScale);
            make.bottom.equalTo(headerBg).offset(-10 * kScale);
//            make.width.mas_equalTo(150 * kScale);
//            make.height.mas_equalTo(20 * kScale);
        }];
        
        _eyeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_eye_white"]];
        [bg addSubview:_eyeImg];
        [_eyeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_readCountLb);
            make.right.equalTo(_readCountLb.mas_left).offset(-5 * kScale);
        }];
        
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = kUIColorFromRGB(0xffffff);
        _timeLb.font = [UIFont systemFontOfSize:11 * kScale];
        _timeLb.text = @"";
        _timeLb.textAlignment = NSTextAlignmentRight;
        [bg addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_readCountLb);
            make.right.equalTo(_eyeImg.mas_left).offset(-15 * kScale);
        }];
        
        _descLb = [[UILabel alloc] init];
        _descLb.textColor = kUIColorFromRGB(0x666666);
        _descLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:14 * kScale];
        _descLb.numberOfLines = 2;
        _descLb.textAlignment = NSTextAlignmentLeft;
        _descLb.text = @"";
        [self addSubview:_descLb];
        [_descLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_bottom).offset(10 * kScale);
            make.left.equalTo(self).offset(12 * kScale);
            make.right.equalTo(self).offset(-12 * kScale);
        }];
        
        
        int imgWidth = (MAIN_SCREEN_WIDTH - 34 * kScale) / 3;
        int imgHeight = 90 * kScale;
 
        _imgView1 = [[UIImageView alloc] init];
        _imgView1.backgroundColor = [UIColor lightGrayColor];
        _imgView1.contentMode = UIViewContentModeScaleAspectFill;
        _imgView1.clipsToBounds = YES;
        [self addSubview:_imgView1];
        
        _imgView2 = [[UIImageView alloc] init];
        _imgView2.backgroundColor = [UIColor lightGrayColor];
        _imgView2.contentMode = UIViewContentModeScaleAspectFill;
        _imgView2.clipsToBounds = YES;
        [self addSubview:_imgView2];
        
        _imgView3 = [[UIImageView alloc] init];
        _imgView3.backgroundColor = [UIColor lightGrayColor];
        _imgView3.contentMode = UIViewContentModeScaleAspectFill;
        _imgView3.clipsToBounds = YES;
        [self addSubview:_imgView3];

        [_imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-15 * kScale);
            make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
            make.left.equalTo(self).offset(12 * kScale);
        }];
        [_imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-15 * kScale);
            make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
            make.centerX.equalTo(self);
        }];
        [_imgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-15 * kScale);
            make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
            make.right.equalTo(self).offset(-12 * kScale);
        }];
//        [self distributeSpacingHorizontallyWith:@[_imgView1,_imgView2,_imgView3]];
        
        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        gensture.delegate = self;
        [self addGestureRecognizer:gensture];
    
    }
    return self;
}

- (void)setModel:(ForumModel *)model {

    _model = model;
    
    [self setTitle:model.tt content:model.c];
    self.funcUrl = model.funcUrl;
    NSString *timeStr;
    if (model.tm.length > 11) {
        timeStr = [model.tm substringWithRange:NSMakeRange(2, 8)];
        if ([timeStr hasPrefix:@"17-"]) {
            timeStr = [timeStr substringFromIndex:3];
        }
    }
    _timeLb.text = timeStr;
    _readCountLb.text = [NSString stringWithFormat:@"%lld",model.clk.longLongValue];
//    NSString *readCountStr = [NSString stringWithFormat:@"%@  阅读数%lld",timeStr,model.clk.longLongValue];
//    [self setValue:readCountStr forKeyPath:@"_readCountLb.text"];
    
    if ([model.imgs count] > 3) {
        ImageListModel * imageItem1 = [model.imgs objectAtIndex:0];
        ImageListModel * imageItem2 = [model.imgs objectAtIndex:1];
        ImageListModel * imageItem3 = [model.imgs objectAtIndex:2];
        ImageListModel * imageItem4 = [model.imgs objectAtIndex:3];
        
        [self setHeaderImg:imageItem1.origin];
        [self setImg1:imageItem2.origin img2:imageItem3.origin img3:imageItem4.origin];
    }
    else if ([model.imgs count] > 2) {
        ImageListModel * imageItem1 = [model.imgs objectAtIndex:0];
        ImageListModel * imageItem2 = [model.imgs objectAtIndex:1];
        ImageListModel * imageItem3 = [model.imgs objectAtIndex:2];
        
        [self setHeaderImg:imageItem1.origin];
        [self setImg1:imageItem2.origin img2:imageItem3.origin img3:imageItem2.origin];
    }
    else if([model.imgs count] > 1) {
        ImageListModel * imageItem1 = [model.imgs objectAtIndex:0];
        ImageListModel * imageItem2 = [model.imgs objectAtIndex:1];
        
        [self setHeaderImg:imageItem1.origin];
        [self setImg1:imageItem2.origin img2:imageItem2.origin img3:imageItem2.origin];
    }
    else if([model.imgs count] > 0) {
        ImageListModel * imageItem1 = [model.imgs objectAtIndex:0];
        
        [self setHeaderImg:imageItem1.origin];
    }

}

- (void)setHeaderImg:(NSString *)url {
    [_headerView sd_setImageWithURL:[NSURL URLWithString:url]
                   placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
}

- (void)setTitle:(NSString *)title content:(NSString *)content {
    _titleLb.text = title;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4.0 * kScale];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    _descLb.attributedText = attributedString;
}

- (void)setImg1:(NSString *)url1 img2:(NSString *)url2 img3:(NSString *)url3 {
    [_imgView1 sd_setImageWithURL:[NSURL URLWithString:url1]
                  placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    [_imgView2 sd_setImageWithURL:[NSURL URLWithString:url2]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    [_imgView3 sd_setImageWithURL:[NSURL URLWithString:url3]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)tapAction {

    if([self.delegate respondsToSelector:@selector(baGuaView:funcUrl:)]) {
        [self.delegate baGuaView:self funcUrl:self.funcUrl];
    }
}

@end
