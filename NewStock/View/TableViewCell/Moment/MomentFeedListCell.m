//
//  MomentFeedListCell.m
//  NewStock
//
//  Created by 王迪 on 2016/12/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MomentFeedListCell.h"
#import "Defination.h"
#import <YYText/YYText.h>
#import <YYLabel.h>
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+getLength.h"
#import "UserInfoInstance.h"
#import "SystemUtil.h"

@interface MomentFeedListCell ()

@property (nonatomic, strong) UIImageView *iconIv;
@property (nonatomic, strong) UIImageView *bigV;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) YYLabel *contentLb;
@property (nonatomic, strong) UILabel *readCountLb;
@property (nonatomic, strong) UILabel *writeComLb;
@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, strong) UIImageView *centerimageView;
@property (nonatomic, strong) NSMutableArray *rangeArray;
@property (nonatomic, strong) NSAttributedString *jingAttr;
@property (nonatomic, strong) NSAttributedString *hotAttr;

@end

@implementation MomentFeedListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.contentView.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.iconIv];
    [self.contentView addSubview:self.bigV];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.contentLb];
    [self.contentView addSubview:self.readCountLb];
    [self.contentView addSubview:self.writeComLb];
    [self.contentView addSubview:self.followBtn];
    [self.contentView addSubview:self.centerimageView];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.footerView];
    
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(10 * kScale));
        make.top.equalTo(self.contentView).offset(0 * kScale);
    }];
    
    [_iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_footerView.mas_bottom).offset(12 * kScale);
        make.left.equalTo(_iconIv.superview).offset(12 * kScale);
        make.height.with.width.equalTo(@(36 * kScale));
    }];
    
    [_bigV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(_iconIv);
    }];
    
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconIv.mas_right).offset(10 * kScale);
        make.top.equalTo(_iconIv).offset(2 * kScale);
    }];
    
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLb);
        make.top.equalTo(_nameLb.mas_bottom).offset(3.5 * kScale);
    }];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(_iconIv.mas_bottom).offset(20 * kScale);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconIv).offset(2);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.width.equalTo(@(54 * kScale));
        make.height.equalTo(@(24 * kScale));
    }];
    
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(_titleLb.mas_bottom).offset(12 * kScale);
    }];
    
    [_centerimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_centerimageView.superview).offset(12 * kScale);
        make.right.equalTo(_centerimageView.superview).offset(-12 * kScale);
        make.top.equalTo(_contentLb.mas_bottom).offset(10 * kScale);
        make.height.equalTo(@(120 * kScale));
    }];
    
    [_readCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLb.mas_bottom).offset(22 * kScale);
        make.left.equalTo(self.contentView).offset(12 * kScale);
    }];
    
    [_writeComLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_readCountLb);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
}

- (void)setModel:(FeedListModel *)model {
    
    _model = model;
    
    if (!_model.contentStr.length) {
        [self dealWithImageAndContent:model.c];
    }
    
    _followBtn.selected = model.u.fld.integerValue == 1;
    _followBtn.layer.borderColor = !_followBtn.isSelected ? kTitleColor.CGColor : kUIColorFromRGB(0xbfbfbf).CGColor;
    _followBtn.hidden = [[UserInfoInstance sharedUserInfoInstance].userInfoModel.userId isEqualToString:model.u.uid];
    
    [self dealWithImg];
    [self dealWithTitleLb];
    [self dealWithContentLb];
    [self dealWithTmAndSrLb];
    
    [_iconIv sd_setImageWithURL:[NSURL URLWithString:(NSString *)(model.u.ico.origin)]];
    _nameLb.text = model.u.n;
    _readCountLb.text = [NSString stringWithFormat:@"阅读 %zd",_model.ss.clk.integerValue];

    [self.contentView layoutIfNeeded];
}

- (void)dealWithTitleLb {
    NSString *tt = _model.tt;
    tt = [tt stringByReplacingOccurrencesOfString:@" " withString:@""];
    tt = [tt stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (tt.length == 0) {
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.mas_bottom).offset(0 * kScale);
        }];
        return;
    }
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    
    CGFloat width = [_model.tt boundingRectWithSize:CGSizeMake(MAXFLOAT, _titleLb.font.lineHeight) options:1 attributes:@{NSFontAttributeName : _titleLb.font} context:nil].size.width;
    if (width > _titleLb.bounds.size.width) {
        para.lineSpacing = 4 * kScale;
    } else {
        para.lineSpacing = 0 * kScale;
    }
    
    NSMutableAttributedString *nmAttrS = [[NSMutableAttributedString alloc] initWithString:_model.tt attributes:@{NSParagraphStyleAttributeName : para}];
    
    if (_model.tag.integerValue == 1) {
        [nmAttrS appendAttributedString:self.jingAttr];
    } else if (_model.tag.integerValue == 2) {
        [nmAttrS appendAttributedString:self.hotAttr];
    } else if (_model.tag.integerValue == 3) {
        [nmAttrS appendAttributedString:self.hotAttr];
        [nmAttrS appendAttributedString:self.jingAttr];
    } 
    
    _titleLb.attributedText = nmAttrS;
    
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLb.mas_bottom).offset(12 * kScale);
    }];
    
    [_titleLb sizeToFit];
}

- (void)dealWithContentLb {
    if (_model.saveAttr != nil) {
        _contentLb.attributedText = _model.saveAttr;
        [_contentLb sizeToFit];
        [self.contentView layoutIfNeeded];
        return;
    }
    NSString *content = @"";
    NSInteger count = 80;
    [self.rangeArray removeAllObjects];
    if (_model.contentStr.length > count) {
        content = [_model.contentStr substringToIndex:count];
    } else {
        content = _model.contentStr;
    }
    
    for (FeedListSLModel *slModel in _model.sl) {
        for (NSString *c in slModel.c) {
            NSArray *rangeArr = [SystemUtil rangesOfString:c inString:content];
            [self.rangeArray addObjectsFromArray:rangeArr];
        }
    }

    NSMutableAttributedString *nmAttrs = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15 * kScale], NSForegroundColorAttributeName : kUIColorFromRGB(0x808080)}];
    
//    if (_model.contentStr.length > count) {
//        NSAttributedString *m = [[NSAttributedString alloc] initWithString:@"  ...全文" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],NSForegroundColorAttributeName : kNameColor}];
//        [nmAttrs appendAttributedString:m];
//    }
//    
    for (int i = 0 ; i < self.rangeArray.count ; i ++) {
        NSValue *value = self.rangeArray[i];
        NSRange range = value.rangeValue;
        [nmAttrs yy_setTextHighlightRange:range color:kUIColorFromRGB(0x358ee7) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            text = [text attributedSubstringFromRange:range];
            [self pushToStock:text.string];
        }];
    }
    _model.saveAttr = nmAttrs.copy;
    _contentLb.attributedText = _model.saveAttr;
    [_contentLb sizeToFit];
    [self.contentView layoutIfNeeded];
}

- (CGFloat)dealWithImg {
    if (_model.imgStr.length) {
        [_centerimageView sd_setImageWithURL:[NSURL URLWithString:_model.imgStr]];
        [_centerimageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(175 * kScale));
        }];
        [_readCountLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLb.mas_bottom).offset((18 + 175 + 10) * kScale);
        }];
        return (175 + 10 + 18) * kScale;
    } else {
        _centerimageView.image = nil;
        [_centerimageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0.1));
        }];
        [_readCountLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLb.mas_bottom).offset(18 * kScale);
        }];
        return 18 * kScale;
    }
}

- (void)dealWithTmAndSrLb {
    NSArray *tagArr = _model.u.tag;
    NSMutableString *nmStr = [NSMutableString string];
    for (NSDictionary *dict in tagArr) {
        [nmStr appendString:dict[@"n"]];
        [nmStr appendString:@"、"];
    }
    if (tagArr.count == 1) {
        [nmStr replaceOccurrencesOfString:@"、" withString:@"" options:0 range:NSMakeRange(0, nmStr.length)];
    }
    if (tagArr.count > 1) {
        nmStr = [nmStr substringToIndex:nmStr.length - 1].mutableCopy;
    }
    
    if (_model.tm.length > 5) {
        NSString *timeStr = [SystemUtil getDateString:_model.tm];
        _timeLb.text = [NSString stringWithFormat:@"%@ %@",timeStr,nmStr.copy];
    }
}

- (void)dealWithImageAndContent:(NSString *)content {
    NSError *error = NULL;
    NSString *partten = @"<img src=\"(.*?)\".*?/>";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:partten options:0 error:&error];
    
    if (_model.imgs.count) {
        _model.imgStr = _model.imgs[0][@"origin"];
    } else {
        NSArray *resArr = [regex matchesInString:content options:0 range:NSMakeRange(0, content.length)];
        if (resArr.count > 0) {
            NSTextCheckingResult *res = resArr[0];
            NSString *imgStr = [content substringWithRange:[res rangeAtIndex:1]];
            _model.imgStr = imgStr;
        }
    }
    
    NSMutableString *nmStr = [NSMutableString stringWithString:content];
    [regex replaceMatchesInString:nmStr options:0 range:NSMakeRange(0, content.length) withTemplate:@""];
    _model.contentStr = nmStr.copy;
}

#pragma mark aciton

- (void)pushToStock:(NSString *)str {
    for (FeedListSLModel *model in _model.sl) {
        for (NSString *c in model.c) {
            if ([str isEqualToString:c]) {
                if (self.pushStock) {
                    self.pushStock(model);
                    return;
                }
            }
        }
    }
}

- (void)iconTap:(UITapGestureRecognizer *)tap {
    NSString *urlStr = [NSString stringWithFormat:@"%@jiabei/MY9902?id=%@",API_URL,_model.u.uid];

    if (self.pushBlock) {
        self.pushBlock(urlStr);
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    if (self.centerimageView.image == nil) {
        return;
    }

    if (self.photoBlock) {
        self.photoBlock(tap.view.tag,@[self.centerimageView]);
    }
}

- (void)followBtnClick:(UIButton *)btn {
    if (![SystemUtil isSignIn]) {
        if (self.pushToLoginVC) {
            self.pushToLoginVC();
        }
        return;
    }
    _followBtn.layer.borderColor = !_followBtn.isSelected ? kTitleColor.CGColor : kUIColorFromRGB(0xbfbfbf).CGColor;
    if (self.followBlock) {
        self.followBlock(btn.isSelected,_model.u.uid,btn);
    }
}

#pragma mark lazy loading

- (UIImageView *)iconIv {
    if (_iconIv == nil) {
        _iconIv = [[UIImageView alloc] init];
        _iconIv.contentMode = UIViewContentModeScaleAspectFill;
        _iconIv.layer.cornerRadius = 18 * kScale;
        _iconIv.clipsToBounds = YES;
        _iconIv.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap:)];
        [_iconIv addGestureRecognizer:tap];
    }
    return _iconIv;
}

- (UIImageView *)bigV {
    if (_bigV == nil) {
        _bigV = [[UIImageView alloc] init];
        _bigV.image = [UIImage imageNamed:@"bigV"];
    }
    return _bigV;
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x333333);
        _nameLb.layer.masksToBounds = YES;
        _nameLb.backgroundColor = [UIColor whiteColor];
        _nameLb.font = [UIFont systemFontOfSize:14 * kScale];
        _nameLb.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLb;
}

- (UILabel *)titleLb {
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.layer.masksToBounds = YES;
        _titleLb.backgroundColor = [UIColor whiteColor];
        _titleLb.textColor = kUIColorFromRGB(0x333333);
        _titleLb.font = [UIFont boldSystemFontOfSize:18 * kScale];
        _titleLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
        _titleLb.numberOfLines = 2;
    }
    return _titleLb;
}

- (YYLabel *)contentLb {
    if (_contentLb == nil) {
        _contentLb = [[YYLabel alloc] init];
        _contentLb.layer.masksToBounds = YES;
        _contentLb.backgroundColor = [UIColor whiteColor];
        _contentLb.font = [UIFont systemFontOfSize:15 * kScale];
        _contentLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
        _contentLb.numberOfLines = 3;
        _contentLb.textColor = kUIColorFromRGB(0x888888);
        YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
        modifier.fixedLineHeight = _contentLb.font.lineHeight + 2;
        _contentLb.linePositionModifier = modifier;
    }
    return _contentLb;
}

- (UILabel *)timeLb {
    if (_timeLb == nil) {
        _timeLb = [UILabel new];
        _timeLb.layer.masksToBounds = YES;
        _timeLb.backgroundColor = [UIColor whiteColor];
        _timeLb.font = [UIFont systemFontOfSize:11 * kScale];
        _timeLb.textColor = kUIColorFromRGB(0xb2b2b2);
    }
    return _timeLb;
}

- (UIButton *)followBtn {
    if (_followBtn == nil) {
        _followBtn = [UIButton new];
        _followBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        _followBtn.adjustsImageWhenHighlighted = NO;
        [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_followBtn setTitle:@"已关注" forState:UIControlStateSelected];
        [_followBtn setTitle:@"已关注" forState:UIControlStateHighlighted | UIControlStateSelected];
        
        [_followBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_followBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateSelected];
        [_followBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateHighlighted | UIControlStateSelected];
        _followBtn.layer.borderColor = kTitleColor.CGColor;
        _followBtn.layer.cornerRadius = 2 * kScale;
        _followBtn.layer.borderWidth = 0.5;
        _followBtn.titleLabel.backgroundColor = [UIColor whiteColor];
        _followBtn.titleLabel.layer.masksToBounds = YES;
        [_followBtn addTarget:self action:@selector(followBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}

- (UIView *)footerView {
    if (_footerView == nil) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _footerView;
}

- (UILabel *)readCountLb {
    if (_readCountLb == nil) {
        _readCountLb = [UILabel new];
        _readCountLb.layer.masksToBounds = YES;
        _readCountLb.backgroundColor = [UIColor whiteColor];
        _readCountLb.text = @"阅读数:";
        _readCountLb.font = [UIFont systemFontOfSize:12 * kScale];
        _readCountLb.textColor = kUIColorFromRGB(0xb2b2b2);
    }
    return _readCountLb;
}

- (UILabel *)writeComLb {
    if (_writeComLb == nil) {
        _writeComLb = [UILabel new];
        _writeComLb.layer.masksToBounds = YES;
        _writeComLb.backgroundColor = [UIColor whiteColor];
        _writeComLb.text = @"写评论";
        _writeComLb.textColor = kUIColorFromRGB(0xb2b2b2);
        _writeComLb.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _writeComLb;
}

- (UIImageView *)centerimageView {
    if (_centerimageView == nil) {
        _centerimageView = [[UIImageView alloc] init];
        _centerimageView.contentMode = UIViewContentModeScaleAspectFill;
        _centerimageView.clipsToBounds = YES;
        _centerimageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_centerimageView addGestureRecognizer:tap];
    }
    return _centerimageView;
}

- (NSAttributedString *)jingAttr {
    if (_jingAttr == nil) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@" " attributes:nil];;
        NSTextAttachment *attachJing = [[NSTextAttachment alloc] init];
        attachJing.image = [UIImage imageNamed:@"ic_forum_jing"];
        attachJing.bounds = CGRectMake(0, -1.5 * kScale, 16 * kScale, 16 * kScale);
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
        attachJing.bounds = CGRectMake(0, -1.5 * kScale, 16 * kScale, 16 * kScale);
        NSAttributedString *attrSJing = [NSAttributedString attributedStringWithAttachment:attachJing];
        [attr appendAttributedString:attrSJing];
        _hotAttr = attr;
    }
    return _hotAttr;
}

- (NSMutableArray *)rangeArray {
    if (_rangeArray == nil) {
        _rangeArray = [NSMutableArray array];
    }
    return _rangeArray;
}

@end
