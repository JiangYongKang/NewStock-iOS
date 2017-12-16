//
//  TieTableViewCell.m
//  NewStock
//
//  Created by Willey on 16/9/1.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "TieTableViewCell.h"
#import "Defination.h"
#import "MarketConfig.h"
#import "Masonry.h"


@implementation TieTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _contentLb = [[UILabel alloc] init];
        _contentLb.backgroundColor = [UIColor clearColor];
        _contentLb.textColor = kUIColorFromRGB(0x333333);
        _contentLb.font = [UIFont systemFontOfSize:16.0f];
        _contentLb.text = @"";
        _contentLb.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_contentLb];
        
        _tagLb = [[UILabel alloc] init];
        _tagLb.backgroundColor = [UIColor clearColor];
        _tagLb.textColor = [UIColor orangeColor];
        _tagLb.font = [UIFont systemFontOfSize:10.0f];
        _tagLb.text = @"原创";
        _tagLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_tagLb];
        [[_tagLb layer] setBorderWidth:0.8];
        [[_tagLb layer] setBorderColor:[UIColor orangeColor].CGColor];
        _tagLb.layer.cornerRadius = 3.0;

        
        _readNumLb = [[UILabel alloc] init];
        _readNumLb.backgroundColor = [UIColor clearColor];
        _readNumLb.textColor = kUIColorFromRGB(0x808080);
        _readNumLb.font = [UIFont systemFontOfSize:11.0f];
        _readNumLb.text = @"阅读";
        _readNumLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_readNumLb];
        
        _sepLine1 = [[UIView alloc] init];
        _sepLine1.backgroundColor = kUIColorFromRGB(0x808080);
        [self.contentView addSubview:_sepLine1];
        
        _comNumLb = [[UILabel alloc] init];
        _comNumLb.backgroundColor = [UIColor clearColor];
        _comNumLb.textColor = kUIColorFromRGB(0x808080);
        _comNumLb.font = [UIFont systemFontOfSize:11.0f];
        _comNumLb.text = @"评论";
        _comNumLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_comNumLb];
        
        _sepLine2 = [[UIView alloc] init];
        _sepLine2.backgroundColor = kUIColorFromRGB(0x808080);
        [self.contentView addSubview:_sepLine2];
        
        _praiseNumLb = [[UILabel alloc] init];
        _praiseNumLb.backgroundColor = [UIColor clearColor];
        _praiseNumLb.textColor = kUIColorFromRGB(0x808080);
        _praiseNumLb.font = [UIFont systemFontOfSize:11.0f];
        _praiseNumLb.text = @"赞";
        _praiseNumLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_praiseNumLb];
        
        
        //self.contentView.backgroundColor = TITLE_BAR_BG_COLOR;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_contentLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-30);
    }];
    
    [_tagLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLb.mas_bottom).offset(1);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(17);
    }];
    
    [_readNumLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagLb.mas_top).offset(0);
        make.bottom.equalTo(_tagLb.mas_bottom).offset(0);
        make.left.equalTo(_tagLb.mas_right).offset(10);
        make.width.mas_equalTo(60);
    }];
    
    
    [_sepLine1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagLb.mas_top).offset(4);
        make.bottom.equalTo(_tagLb.mas_bottom).offset(-4);
        make.left.equalTo(_readNumLb.mas_right).offset(0);
        make.width.mas_equalTo(0.5);
    }];
    
    
    [_comNumLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagLb.mas_top).offset(0);
        make.bottom.equalTo(_tagLb.mas_bottom).offset(0);
        make.left.equalTo(_readNumLb.mas_right);
        make.width.mas_equalTo(60);
    }];
    
    
    [_sepLine2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagLb.mas_top).offset(4);
        make.bottom.equalTo(_tagLb.mas_bottom).offset(-4);
        make.left.equalTo(_comNumLb.mas_right).offset(0);
        make.width.mas_equalTo(0.5);
    }];
    
    [_praiseNumLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagLb.mas_top).offset(0);
        make.bottom.equalTo(_tagLb.mas_bottom).offset(0);
        make.left.equalTo(_comNumLb.mas_right);
        make.width.mas_equalTo(60);
    }];
}

- (void)setContent:(NSString *)content tagType:(NSString *)tagType readNum:(NSString *)readNum comNum:(NSString *)comNum praiseNum:(NSString *)praiseNum {
    _contentLb.text = content;
    
    //_tagLb.text
    if ([tagType isEqualToString:@"yc"])
    {
        _tagLb.textColor = kUIColorFromRGB(0xffac4e);
        [[_tagLb layer] setBorderColor:kUIColorFromRGB(0xffac4e).CGColor];
        _tagLb.text = @"原创";
    }
    else if ([tagType isEqualToString:@"zz"])
    {
        _tagLb.textColor = kUIColorFromRGB(0x358ee7);
        [[_tagLb layer] setBorderColor:kUIColorFromRGB(0x358ee7).CGColor];
        _tagLb.text = @"转载";
    }
    else if ([tagType isEqualToString:@"bl"])
    {
        _tagLb.textColor = kUIColorFromRGB(0xff1919);
        [[_tagLb layer] setBorderColor:kUIColorFromRGB(0xff1919).CGColor];
        _tagLb.text = @"爆料";
    }

    
    _readNumLb.text = [NSString stringWithFormat:@"阅读%@",readNum];
    _comNumLb.text = [NSString stringWithFormat:@"评论%@",comNum];
    _praiseNumLb.text = [NSString stringWithFormat:@"赞%@",praiseNum];
}

@end
