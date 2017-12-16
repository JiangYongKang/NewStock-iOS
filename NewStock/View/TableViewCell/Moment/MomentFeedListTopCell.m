//
//  MomentFeedListTopCell.m
//  NewStock
//
//  Created by 王迪 on 2017/3/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentFeedListTopCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface MomentFeedListTopCell ()

@property (nonatomic, strong) UILabel *leftLb;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) NSAttributedString *jingAttr;

@property (nonatomic, strong) NSAttributedString *hotAttr;

@end

@implementation MomentFeedListTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.leftLb];
    [self.contentView addSubview:self.titleLb];

    
    [self.leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(16 * kScale));
        make.width.equalTo(@(28 * kScale));
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLb.mas_right).offset(10 * kScale);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.titleLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 30 * kScale;
    
    UILabel *line = [UILabel new];
    line.layer.masksToBounds = YES;
    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * kScale);
        make.right.equalTo(self.contentView).offset(-15 * kScale);
        make.height.equalTo(@(0.5 * kScale));
        make.bottom.equalTo(self.contentView);
    }];
}


- (void)setModel:(FeedListModel *)model {
    _model = model;
    
    NSString *tt = _model.tt;
    if (tt.length > 20) {
        tt = [tt substringToIndex:20];
        tt = [NSString stringWithFormat:@"%@...",tt];
    }
    
    NSMutableAttributedString *nmAttrS = [[NSMutableAttributedString alloc] initWithString:tt attributes:@{
                                                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:13 * kScale],
                                                                                                                  NSForegroundColorAttributeName : kUIColorFromRGB(0x000000),
                                                                                                                  }];
    
    if (_model.tag.integerValue == 1) {
        [nmAttrS appendAttributedString:self.jingAttr];
    } else if (_model.tag.integerValue == 2) {
        [nmAttrS appendAttributedString:self.hotAttr];
    } else if (_model.tag.integerValue == 3) {
        [nmAttrS appendAttributedString:self.hotAttr];
        [nmAttrS appendAttributedString:self.jingAttr];
    } else {
        
    }
    
    _titleLb.attributedText = nmAttrS;
}

#pragma mark lazy


- (UILabel *)titleLb {
    if (_titleLb == nil) {
        _titleLb = [UILabel new];
        _titleLb.backgroundColor = [UIColor whiteColor];
        _titleLb.layer.masksToBounds = YES;
        _titleLb.textColor = kUIColorFromRGB(0x333333);
        _titleLb.font = [UIFont systemFontOfSize:13 * kScale];
    }
    return _titleLb;
}

- (UILabel *)leftLb {
    if (_leftLb == nil) {
        _leftLb = [UILabel new];
        _leftLb.layer.masksToBounds = YES;
        _leftLb.backgroundColor = [UIColor whiteColor];
        _leftLb.textColor = kUIColorFromRGB(0x358ee7);
        _leftLb.text = @"置顶";
        _leftLb.textAlignment = NSTextAlignmentCenter;
        _leftLb.font = [UIFont systemFontOfSize:10 * kScale];
        _leftLb.layer.borderWidth = 0.5;
        _leftLb.layer.borderColor = kUIColorFromRGB(0x358ee7).CGColor;
    }
    return _leftLb;
}

- (NSAttributedString *)jingAttr {
    if (_jingAttr == nil) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@" " attributes:nil];;
        NSTextAttachment *attachJing = [[NSTextAttachment alloc] init];
        attachJing.image = [UIImage imageNamed:@"ic_forum_jing"];
        attachJing.bounds = CGRectMake(0, -2 * kScale, 13 * kScale, 13 * kScale);
        
        NSAttributedString *attrSJing = [NSAttributedString attributedStringWithAttachment:attachJing];
        [attr appendAttributedString:attrSJing];
        _jingAttr = attr;
    }
    return _jingAttr;
}

- (NSAttributedString *)hotAttr {
    if (_hotAttr == nil) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@" " attributes:nil];;
        NSTextAttachment *attachJing = [[NSTextAttachment alloc] init];
        attachJing.image = [UIImage imageNamed:@"ic_forum_hot"];
        attachJing.bounds = CGRectMake(0, -2 * kScale, 13 * kScale, 13 * kScale);
        
        NSAttributedString *attrSJing = [NSAttributedString attributedStringWithAttachment:attachJing];
        [attr appendAttributedString:attrSJing];
        _hotAttr = attr;
    }
    return _hotAttr;
}


@end
