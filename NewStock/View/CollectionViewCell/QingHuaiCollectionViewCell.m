//
//  QingHuaiCollectionViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/1/11.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "QingHuaiCollectionViewCell.h"
#import <Masonry.h>
#import "Defination.h"
#import <UIImageView+WebCache.h>

@interface QingHuaiCollectionViewCell ()

@property (nonatomic, strong) UIImageView *qh_img;

@property (nonatomic, strong) UIImageView *center_img;

@property (nonatomic, strong) UIImageView *left_comImg;

@property (nonatomic, strong) UIImageView *right_comImg;

@property (nonatomic, strong) UILabel *content_lb;

@property (nonatomic, strong) UILabel *name_lb;

@property (nonatomic, strong) UIButton *likeBtn;

@property (nonatomic, strong) UIView *borderView;

@end

@implementation QingHuaiCollectionViewCell

- (UIButton *)likeBtn {
    
    if (_likeBtn == nil) {
        _likeBtn = [[UIButton alloc] init];
        
        [_likeBtn setImage:[UIImage imageNamed:@"ic_zan_nor"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"ic_zan_pre"] forState:UIControlStateSelected];
        [_likeBtn setImage:[UIImage imageNamed:@"ic_zan_pre"] forState:UIControlStateHighlighted | UIControlStateSelected];
        [_likeBtn setTitleColor:kUIColorFromRGB(0xf99421) forState:UIControlStateSelected];
        [_likeBtn setTitleColor:kUIColorFromRGB(0xf99421) forState:UIControlStateHighlighted |UIControlStateSelected];
        [_likeBtn setTitleColor:kUIColorFromRGB(0xaaaaaa) forState:UIControlStateNormal];
        [_likeBtn setAdjustsImageWhenHighlighted:NO];
        [_likeBtn setTitle:@"0" forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_likeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        [_likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_likeBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

- (UIImageView *)qh_img {
    if (_qh_img == nil) {
        _qh_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_qinghuai"]];
    }
    return _qh_img;
}

- (UIImageView *)center_img {
    if (_center_img == nil) {
        _center_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qinhuai_bg"]];
    }
    return _center_img;
}

- (UIImageView *)left_comImg {
    if (_left_comImg == nil) {
        _left_comImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_yinhao1"]];
        _left_comImg.alpha = 0.5;
    }
    return _left_comImg;
}

- (UIImageView *)right_comImg {
    if (_right_comImg == nil) {
        _right_comImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_yinhao2"]];
        _right_comImg.alpha = 0.5;
    }
    return _right_comImg;
}

- (UILabel *)content_lb {
    if (_content_lb == nil) {
        _content_lb = [UILabel new];
        _content_lb.textColor = kUIColorFromRGB(0x333333);
        _content_lb.font = [UIFont systemFontOfSize:15 * kScale];
        _content_lb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH * 0.7;
        _content_lb.numberOfLines = 0;
    }
    return _content_lb;
}

- (UILabel *)name_lb {
    if (_name_lb == nil) {
        _name_lb = [UILabel new];
        _name_lb.textColor = kUIColorFromRGB(0x333333);
        NSLog(@"%@",[UIFont familyNames]);//
        _name_lb.font = [UIFont fontWithName:@"STXingkai" size:15 * kScale];
    }
    return _name_lb;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.borderView = [UIView new];
        self.borderView.layer.cornerRadius = 5;
        self.borderView.layer.masksToBounds = YES;
        self.borderView.backgroundColor = [UIColor whiteColor];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.borderView];
        [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(10 * kScale);
            make.right.equalTo(self.contentView).offset(-10 * kScale);
        }];
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    [self.borderView addSubview:self.center_img];
    [self.borderView addSubview:self.left_comImg];
    [self.borderView addSubview:self.right_comImg];
    [self.borderView addSubview:self.content_lb];
    [self.borderView addSubview:self.name_lb];
    [self.borderView addSubview:self.likeBtn];
    [self.borderView addSubview:self.qh_img];
    
    [self.qh_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.borderView).offset(10);
    }];
    
    [self.center_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.borderView);
        make.top.equalTo(self.borderView).offset(69 * kScale);
        make.height.equalTo(@(206 * kScale));
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.center_img.mas_bottom).offset(15);
        make.right.equalTo(self.center_img).offset(-20);
//        make.width.equalTo(@40);
    }];
    
    [self.left_comImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.center_img.mas_bottom).offset(10 * kScale);
        make.left.equalTo(self.borderView).offset(10);
        make.width.height.equalTo(@(40 * kScale));
    }];
    
    [self.right_comImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.borderView).offset(-10);
        make.bottom.equalTo(self.borderView).offset(-10 * kScale);
        make.width.height.equalTo(@(40 * kScale));
    }];
    
    [self.content_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.borderView);
        make.top.equalTo(self.left_comImg.mas_bottom).offset(10 * kScale);
    }];
    
    [self.name_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.content_lb);
        make.top.equalTo(self.content_lb.mas_bottom).offset(10 * kScale);
    }];
}

- (void)btnAction {
    
    if(_likeBtn.selected == NO) {
        _likeBtn.selected = YES;
        
        int num = [_likeBtn.titleLabel.text intValue] + 1;
        [_likeBtn setTitle:[NSString stringWithFormat:@"%d",num] forState:UIControlStateNormal];
        
        if ([self.delegate respondsToSelector:@selector(qingHuaiCollectionViewCellLikeBtnClick:)]) {
            [self.delegate qingHuaiCollectionViewCellLikeBtnClick:self];
        }
    }
}

- (void)setModel:(ForumModel *)model {

    _model = model;
    
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.lkd] forState:UIControlStateNormal];
    
    self.likeBtn.selected = model.hlkd;
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 3;
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:model.c attributes:@{NSParagraphStyleAttributeName : para}];
    
    self.content_lb.attributedText = nmAttrStr.copy;
    self.name_lb.text = model.tt;
    
    if (model.imgs.count > 0) {
        ImageListModel *imgModel = model.imgs[0];
        [self.center_img sd_setImageWithURL:[NSURL URLWithString:imgModel.origin]];
    }

    
}




@end
