//
//  NewsTableViewCell.m
//  NewStock
//
//  Created by Willey on 16/8/4.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "Defination.h"
#import "MarketConfig.h"
#import <Masonry.h>

@implementation NewsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _stockNameLb = [[UILabel alloc] init];
        _stockNameLb.textColor = kUIColorFromRGB(0x358ee7);
        _stockNameLb.font = [UIFont systemFontOfSize:13.0f * kScale];
        _stockNameLb.text = @"";
        _stockNameLb.textAlignment = NSTextAlignmentLeft;
        _stockNameLb.userInteractionEnabled = YES;
        [self.contentView addSubview:_stockNameLb];
        
        [_stockNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-8 * kScale);
            make.left.equalTo(self.contentView).offset(12 * kScale);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
        [_stockNameLb addGestureRecognizer:tap];
        
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = kUIColorFromRGB(0xb2b2b2);
        _timeLb.font = [UIFont systemFontOfSize:10 * kScale];
        _timeLb.text = @"";
        _timeLb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLb];
        
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-10 * kScale);
            make.right.equalTo(self.contentView).offset(-12 * kScale);
        }];
        
        _contentLb = [[UILabel alloc] init];
        _contentLb.textColor = kUIColorFromRGB(0x333333);
        _contentLb.font = [UIFont systemFontOfSize:15 * kScale];
        _contentLb.numberOfLines = 2;
        _contentLb.text = @"";
        _contentLb.textAlignment = NSTextAlignmentLeft;
        [_contentLb setContentMode:UIViewContentModeTopLeft];
        [self.contentView addSubview:_contentLb];
        
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12 * kScale);
            make.right.equalTo(self.contentView).offset(-12 * kScale);
            make.top.equalTo(self.contentView).offset(12 * kScale);
        }];
        
    }
    return self;
}

- (void)setName:(NSString *)name time:(NSString *)time content:(NSString *)content {
    _stockNameLb.text = name;
    _timeLb.text = time;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4 * kScale];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    _contentLb.attributedText = attributedString;
    
}

#pragma mark - Button Actions

- (void)btnAction:(UIButton*)sender {
    if([_delegate respondsToSelector:@selector(newsTableViewCell:selectedIndex:)]) {
        [_delegate newsTableViewCell:self selectedIndex:self.tag];
    }
}

@end
