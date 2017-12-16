//
//  BaguaCell.m
//  NewStock
//
//  Created by 王迪 on 2017/1/6.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaguaCell.h"
#import "Defination.h"
#import "MarketConfig.h"
#import <Masonry.h>
#import "UIView+Masonry_Arrange.h"
#import <UIImageView+WebCache.h>

@interface BaguaCell (){

    UILabel *_titleLb;
    UILabel *_contentLb;
    UILabel *_timeLb;
    UILabel *_readCountLb;
    
    UIImageView *_iconIv;
    UIImageView *_bigV;
    UILabel *_nameLb;
    UIImageView *_eyeImg;
    
    UIImageView *_imgView1;
    UIImageView *_imgView2;
    UIImageView *_imgView3;
    
    UIView *_topView;
}

@end

@implementation BaguaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    NSString *urlStr = [NSString stringWithFormat:@"%@jiabei/MY9902?id=%@",API_URL,_model.uid];
    
    if (self.pushBlock) {
        self.pushBlock(urlStr);
    }
}

- (void)setupUI {
    
    _iconIv = [[UIImageView alloc] init];
    _bigV = [[UIImageView alloc] init];
    _nameLb = [UILabel new];
    _titleLb = [[UILabel alloc] init];
    _contentLb = [[UILabel alloc] init];
    _timeLb = [[UILabel alloc] init];
    _readCountLb = [[UILabel alloc] init];
    _eyeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_eye_black"]];
    
    [self.contentView addSubview:_nameLb];
    [self.contentView addSubview:_iconIv];
    [self.contentView addSubview:_bigV];
    [self.contentView addSubview:_nameLb];
    [self.contentView addSubview:_titleLb];
    [self.contentView addSubview:_contentLb];
    [self.contentView addSubview:_timeLb];
    [self.contentView addSubview:_eyeImg];
    [self.contentView addSubview:_readCountLb];
    
    _titleLb.textColor = kUIColorFromRGB(0x000000);
    _titleLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
    _titleLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.numberOfLines = 2;
    
    _contentLb.textColor = kUIColorFromRGB(0x666666);
    _contentLb.font = [UIFont systemFontOfSize:14 * kScale];
    _contentLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:14 * kScale];
    _contentLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
    _contentLb.numberOfLines = 2;
    
    _iconIv.layer.cornerRadius = 14 * kScale;
    _iconIv.clipsToBounds = YES;
    _iconIv.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_iconIv addGestureRecognizer:tap];

    _bigV.image = [UIImage imageNamed:@"bigV"];
    _bigV.hidden = YES;
    
    _nameLb.textColor = kNameColor;
    _nameLb.font = [UIFont systemFontOfSize:12 * kScale];
    _nameLb.textAlignment = NSTextAlignmentLeft;
    
    _timeLb.textColor = kUIColorFromRGB(0xb2b2b2);
    _timeLb.font = [UIFont systemFontOfSize:12 * kScale];
    
    _readCountLb.textColor = kUIColorFromRGB(0xb2b2b2);
    _readCountLb.font = [UIFont systemFontOfSize:11 * kScale];
    

    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16 * kScale);
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12 * kScale);
        make.trailing.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(_titleLb.mas_bottom).offset(10 * kScale);
    }];
    
    [_iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLb.mas_bottom).offset(114 * kScale);
        make.left.equalTo(_iconIv.superview).offset(12 * kScale);
        make.height.with.width.equalTo(@(28 * kScale));
    }];
    
    [_bigV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(_iconIv);
    }];
    
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconIv.mas_right).offset(10 * kScale);
        make.centerY.equalTo(_iconIv);
    }];
    
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconIv);
        make.left.equalTo(_nameLb.mas_right).offset(10);
    }];
    
    [_readCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentLb);
        make.top.equalTo(_timeLb);
    }];
    
    [_eyeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_readCountLb);
        make.right.equalTo(_readCountLb.mas_left).offset(-5 * kScale);
    }];

    int imgWidth = (MAIN_SCREEN_WIDTH - 24 * kScale - 10 * kScale) / 3;
    int imgHeight = 90 * kScale;
    
    _imgView1 = [[UIImageView alloc] init];
    _imgView1.backgroundColor = [UIColor lightGrayColor];
    _imgView1.contentMode = UIViewContentModeScaleAspectFill;
    _imgView1.clipsToBounds = YES;
    [self.contentView addSubview:_imgView1];
    
    _imgView2 = [[UIImageView alloc] init];
    _imgView2.backgroundColor = [UIColor lightGrayColor];
    _imgView2.contentMode = UIViewContentModeScaleAspectFill;
    _imgView2.clipsToBounds = YES;
    [self.contentView addSubview:_imgView2];
    
    _imgView3 = [[UIImageView alloc] init];
    _imgView3.backgroundColor = [UIColor lightGrayColor];
    _imgView3.contentMode = UIViewContentModeScaleAspectFill;
    _imgView3.clipsToBounds = YES;
    [self.contentView addSubview:_imgView3];
    
    [_imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLb.mas_bottom).offset(10 * kScale);
        make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
        make.left.equalTo(self.contentView).offset(12 * kScale);
    }];
    [_imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLb.mas_bottom).offset(10 * kScale);
        make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
        make.centerX.equalTo(self.contentView);
    }];
    [_imgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLb.mas_bottom).offset(10 * kScale);
        make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
//    [self.contentView distributeSpacingHorizontallyWith:@[_imgView1,_imgView2,_imgView3]];
    self.contentView.clipsToBounds = YES;
    
}

- (void)setModel:(ForumModel *)model {

    _model = model;
    
    [self dealWithIsForum:model];
    
    if (model.imgs.count > 2) {
        _imgView1.hidden = NO;
        _imgView2.hidden = NO;
        _imgView3.hidden = NO;
        
        [_iconIv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLb.mas_bottom).offset(114 * kScale);
        }];
        
        ImageListModel *imgModel1 = model.imgs[0];
        ImageListModel *imgModel2 = model.imgs[1];
        ImageListModel *imgModel3 = model.imgs[2];
        
        [_imgView1 sd_setImageWithURL:[NSURL URLWithString:imgModel1.origin]];
        [_imgView2 sd_setImageWithURL:[NSURL URLWithString:imgModel2.origin]];
        [_imgView3 sd_setImageWithURL:[NSURL URLWithString:imgModel3.origin]];
  
    }else {
        _imgView1.hidden = YES;
        _imgView2.hidden = YES;
        _imgView3.hidden = YES;
        
        [_iconIv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLb.mas_bottom).offset(10 * kScale);
        }];
        
    }
    
    _titleLb.text = model.tt;
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 4 * kScale;
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:model.c attributes:@{NSParagraphStyleAttributeName : para}];
    _contentLb.attributedText = nmAttrStr.copy;
    
    if (model.tm.length > 11) {
        NSString *tm = [model.tm substringWithRange:NSMakeRange(2, 8)];
        if ([tm hasPrefix:@"17-"]) {
            tm = [tm substringFromIndex:3];
        }
        _timeLb.text = tm;
    }
    _readCountLb.text = [NSString stringWithFormat:@"%lld",model.clk.longLongValue];

    if (model.c.length) {
        [_contentLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.mas_bottom).offset(10 * kScale);
        }];
    } else {
        [_contentLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.mas_bottom).offset(0 * kScale);
        }];
    }
    
    [self.contentView layoutIfNeeded];
    
}

- (void)dealWithIsForum:(ForumModel *)model {
    if (_isForum) {
        _iconIv.hidden = NO;
        _nameLb.hidden = NO;
        
        [_timeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_iconIv);
            make.left.equalTo(_nameLb.mas_right).offset(10);
        }];

        [_iconIv sd_setImageWithURL:[NSURL URLWithString:(NSString *)(model.uico)]];
        
        _nameLb.text = model.un;
        if (model.uaty.integerValue == 3 || model.uaty.integerValue == 4) {
            _bigV.hidden = NO;
        }else {
            _bigV.hidden = YES;
        }
        
    } else {
        _iconIv.hidden = YES;
        _nameLb.hidden = YES;
        _bigV.hidden = YES;
        [_timeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLb.mas_bottom).offset(114 * kScale);
            make.left.equalTo(self.contentView).offset(12);
        }];
    }
    
}


@end
