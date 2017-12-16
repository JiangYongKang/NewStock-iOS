//
//  QinHuaiView.m
//  NewStock
//
//  Created by Willey on 16/11/11.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "QinHuaiView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

@implementation QinHuaiView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = [UIImage imageNamed:@"qinhuai_bg"];
        [self addSubview:_bgImgView];
        _bgImgView.clipsToBounds = YES;
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _bgImgView.userInteractionEnabled = YES;
        
        UIView *contentBg = [[UIView alloc] init];
        contentBg.backgroundColor = [UIColor blackColor];
        contentBg.alpha = 0.4;
        [_bgImgView addSubview:contentBg];
        [contentBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView *borderView1 = [UIView new];
        UIView *borderView2 = [UIView new];
        
        [self addSubview:borderView1];
        [self addSubview:borderView2];
        
        borderView1.backgroundColor = [UIColor clearColor];
        borderView2.backgroundColor = [UIColor clearColor];
        
        borderView1.layer.borderWidth = 0.5 * kScale;
        borderView1.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
        
        borderView2.layer.borderWidth = 0.5 * kScale;
        borderView2.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
        
        [borderView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(90 * kScale));
            make.width.equalTo(@(60 * kScale));
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(6 * kScale);
        }];
        
        [borderView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(85 * kScale));
            make.width.equalTo(@(55 * kScale));
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(8.5 * kScale);
        }];
        
        
        UILabel *baguaTitleLb = [[UILabel alloc] init];
        baguaTitleLb.backgroundColor = [UIColor clearColor];
        baguaTitleLb.text = @"炒个\n情怀";
        baguaTitleLb.textColor = [UIColor whiteColor];
        baguaTitleLb.font = [UIFont boldSystemFontOfSize:22 * kScale];
        baguaTitleLb.textAlignment = NSTextAlignmentCenter;
        baguaTitleLb.numberOfLines = 2;
        [borderView2 addSubview:baguaTitleLb];
        [baguaTitleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(borderView2);
            make.top.equalTo(borderView2).offset(5 * kScale);
            make.width.mas_equalTo(55 * kScale);
            make.height.equalTo(@(60 * kScale));
        }];
        
        _tipsLb = [[UILabel alloc] init];
        _tipsLb.text = @"";
        _tipsLb.textColor = [UIColor whiteColor];
        _tipsLb.font = [UIFont systemFontOfSize:11 * kScale];
        _tipsLb.textAlignment = NSTextAlignmentCenter;
        [_bgImgView addSubview:_tipsLb];
        [_tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(borderView2).offset(-5 * kScale);
            make.centerX.equalTo(borderView2);
        }];
        
        _descLb  = [[UILabel alloc] init];
        _descLb.backgroundColor = [UIColor clearColor];
        _descLb.textAlignment = NSTextAlignmentLeft;
        _descLb.textColor = [UIColor whiteColor];
        _descLb.font = [UIFont systemFontOfSize:15 * kScale];
        _descLb.numberOfLines = 0;
        _descLb.text = @"";
        [_bgImgView addSubview:_descLb];
        [_descLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tipsLb.mas_right).offset(30 * kScale);
            make.right.equalTo(contentBg).offset(-5 * kScale);
            make.centerY.equalTo(self);
        }];
        
        _sourceLb = [[UILabel alloc] init];
        _sourceLb.backgroundColor = [UIColor clearColor];
        _sourceLb.textColor = [UIColor whiteColor];
        _sourceLb.font = [UIFont fontWithName:@"STXingkai" size:15 * kScale];
        _sourceLb.text = @"";
        [self addSubview:_sourceLb];
        [_sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-20 * kScale);
            make.left.equalTo(_descLb).offset(0 * kScale);
            make.width.mas_equalTo(150 * kScale);
            make.height.mas_equalTo(25 * kScale);
        }];
        
        _likeBtn = [[UIButton alloc] init];
        [_likeBtn setImage:[UIImage imageNamed:@"ic_zan_nor"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"ic_zan_pre"] forState:UIControlStateSelected];
        [_likeBtn setImage:[UIImage imageNamed:@"ic_zan_pre"] forState:UIControlStateHighlighted | UIControlStateSelected];
        [_likeBtn setTitleColor:kUIColorFromRGB(0xf99421) forState:UIControlStateSelected];
        [_likeBtn setTitleColor:kUIColorFromRGB(0xf99421) forState:UIControlStateHighlighted | UIControlStateSelected];
        [_likeBtn setTitleColor:kUIColorFromRGB(0xaaaaaa) forState:UIControlStateNormal];
        [_likeBtn setTitle:@"0" forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14 * kScale];
        [_likeBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 5, 8, 5)];
        [_likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(8, 10, 8, 0)];
        [_likeBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bgImgView addSubview:_likeBtn];
        
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_sourceLb);
            make.right.equalTo(self).offset(-10 * kScale);
            make.width.mas_equalTo(80 * kScale);
            make.height.mas_equalTo(45 * kScale);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setBgImg:(NSString *)url {
    [_bgImgView sd_setImageWithURL:[NSURL URLWithString:url]
                  placeholderImage:[UIImage imageNamed:@"qinhuai_bg"]];
}

- (void)setTm:(NSString *)tm {
    _tipsLb.text = [tm substringWithRange:NSMakeRange(5, 5)];
}

- (void)setContent:(NSString *)content source:(NSString *)source {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4.0 * kScale];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    _descLb.attributedText = attributedString;
    [_descLb sizeToFit];
    [_descLb layoutIfNeeded];
    
    _sourceLb.text = source;
}

- (void)setLikeNum:(NSString *)num {
    [_likeBtn setTitle:num forState:UIControlStateNormal];
}

- (void)setLkd:(BOOL)b {
    _likeBtn.selected = b;
}

- (void)btnAction {
    
    if (self.fid) {
        
        if(_likeBtn.selected == NO) {
            _likeBtn.selected = YES;
            
            int num = [_likeBtn.titleLabel.text intValue] + 1;
            
            [_likeBtn setTitle:[NSString stringWithFormat:@"%d",num] forState:UIControlStateNormal];
            
            if([self.delegate respondsToSelector:@selector(qinHuaiView:fid:)]) {
                [self.delegate qinHuaiView:self fid:self.fid];
            }
        }
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(qinghuaiViewClick)]) {
        [self.delegate qinghuaiViewClick];
    }
}



@end
