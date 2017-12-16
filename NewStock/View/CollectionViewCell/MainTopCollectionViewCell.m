//
//  MainTopCollectionViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/3/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainTopCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

@interface MainTopCollectionViewCell ()


@end

@implementation MainTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _bgImgView = [[UIImageView alloc] init];
    _bgImgView.image = [UIImage imageNamed:@"qinhuai_bg"];
    [self.contentView addSubview:_bgImgView];
    _bgImgView.clipsToBounds = YES;
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _bgImgView.userInteractionEnabled = YES;
    
    UIView *contentBg = [[UIView alloc] init];
    contentBg.backgroundColor = [UIColor blackColor];
    contentBg.alpha = 0.3;
    [_bgImgView addSubview:contentBg];
    [contentBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    UIView *borderView1 = [UIView new];
    UIView *borderView2 = [UIView new];
    
    [self.contentView addSubview:borderView1];
    [self.contentView addSubview:borderView2];
    
    borderView1.backgroundColor = [UIColor clearColor];
    borderView2.backgroundColor = [UIColor clearColor];
    
    borderView1.layer.borderWidth = 0.5 * kScale;
    borderView1.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    
    borderView2.layer.borderWidth = 0.5 * kScale;
    borderView2.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    
    [borderView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(70 * kScale));
        make.width.equalTo(@(50 * kScale));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(6 * kScale);
    }];
    
    [borderView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(65 * kScale));
        make.width.equalTo(@(45 * kScale));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(8.5 * kScale);
    }];
    
    UILabel *baguaTitleLb = [[UILabel alloc] init];
    baguaTitleLb.text = @"炒个\n情怀";
    baguaTitleLb.textColor = [UIColor whiteColor];
    baguaTitleLb.font = [UIFont boldSystemFontOfSize:17 * kScale];
    baguaTitleLb.textAlignment = NSTextAlignmentCenter;
    baguaTitleLb.numberOfLines = 2;
    [_bgImgView addSubview:baguaTitleLb];
    [baguaTitleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(borderView2);
        make.centerY.equalTo(self.contentView).offset(-8);
    }];
    
    _tipsLb = [[UILabel alloc] init];
    _tipsLb.text = @"";
    _tipsLb.textColor = [UIColor whiteColor];
    _tipsLb.font = [UIFont systemFontOfSize:11 * kScale];
    _tipsLb.textAlignment = NSTextAlignmentCenter;
    [_bgImgView addSubview:_tipsLb];
    [_tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baguaTitleLb.mas_bottom).offset(5 * kScale);
        make.centerX.equalTo(baguaTitleLb);
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
        make.centerY.equalTo(self.contentView);
    }];
    
    _sourceLb = [[UILabel alloc] init];
//    _sourceLb.backgroundColor = [UIColor redColor];
    _sourceLb.textColor = [UIColor whiteColor];
    _sourceLb.font = [UIFont fontWithName:@"STXingkai" size:15 * kScale];
    _sourceLb.text = @"";
    [_bgImgView addSubview:_sourceLb];
    [_sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
}

- (void)setModel:(ForumModel *)model {
    _model = model;
    if (model == nil) {
        return;
    }
    [self setContent:model.c source:[NSString stringWithFormat:@"%@",model.tt]];
    
    [self setTm:model.tm];
    
    self.fid = model.fid;
    
    if ([model.imgs count] > 0) {
        ImageListModel * imageItem = [model.imgs objectAtIndex:0];
        [self setBgImg:imageItem.origin];
    }
    
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

@end
