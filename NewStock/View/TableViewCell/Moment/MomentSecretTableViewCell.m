//
//  MomentSecretTableViewCell.m
//  NewStock
//
//  Created by 王迪 on 2017/3/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentSecretTableViewCell.h"
#import "NSString+getLength.h"
#import "EmotionModel.h"
#import "Defination.h"
#import "SystemUtil.h"
#import <YYLabel.h>
#import <Masonry.h>
#import <YYText/YYText.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MomentSecretTableViewCell ()

@property (nonatomic, strong) UIImageView *iconIv;
@property (nonatomic, strong) UIImageView *bigV;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) YYLabel *contentLb;
@property (nonatomic, strong) UIButton *writeComBtn;
@property (nonatomic, strong) UILabel *readCountLb;

@property (nonatomic, strong) UIImageView *centerImg;
@property (nonatomic, copy) NSString *imgStr;
@property (nonatomic, strong) NSArray *emojiDataArray;

@property (nonatomic, strong) NSMutableArray *rangeArray;

//topic

@property (nonatomic, strong) UIImageView *topicImg;
@property (nonatomic, strong) UILabel *topicTitle;
@property (nonatomic, strong) UILabel *topicDsc;
@property (nonatomic, strong) UIButton *topicBtn1;
@property (nonatomic, strong) UIButton *topicBtn2;

@end

@implementation MomentSecretTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.clipsToBounds = YES;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.contentLb];
    
    [self.contentView addSubview:self.centerImg];
    [self.contentView addSubview:self.iconIv];
    [self.contentView addSubview:self.bigV];
    [self.contentView addSubview:self.readCountLb];
    [self.contentView addSubview:self.writeComBtn];
    
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.topView.mas_bottom).offset(12 * kScale);
        make.width.height.equalTo(@(36 * kScale));
    }];
    
    [self.bigV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.iconIv);
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconIv.mas_right).offset(10 * kScale);
        make.centerY.equalTo(self.iconIv);
    }];
    
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconIv.mas_bottom).offset(20 * kScale);
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
    [self.centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.contentLb.mas_bottom).offset(18 * kScale);
        make.height.equalTo(@(0.01));
        make.width.equalTo(@(0.01));
    }];
    
    [self.readCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12 * kScale);
        make.top.equalTo(self.centerImg.mas_bottom).offset(15 * kScale);
    }];
    
    [self.writeComBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12 * kScale);
        make.top.equalTo(self.readCountLb);
    }];
    
    //ty == 2
    [self.contentView addSubview:self.topicImg];
    [self.topicImg addSubview:self.topicTitle];
    [self.topicImg addSubview:self.topicDsc];
    [self.topicImg addSubview:self.topicBtn1];
    [self.topicImg addSubview:self.topicBtn2];
    
    [self.topicImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(5 * kScale);
    }];
    
    [self.topicBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicImg).offset(36 * kScale);
        make.bottom.equalTo(self.topicImg).offset(-18 * kScale);
        make.width.equalTo(@(125 * kScale));
        make.height.equalTo(@(40 * kScale));
    }];
    
    [self.topicBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.equalTo(self.topicBtn1);
        make.right.equalTo(self.topicImg).offset(-36 * kScale);
    }];
}

- (void)setModel:(FeedListModel *)model {
    _model = model;
    
    if (model.ty.integerValue == 2) {
        [self dealWithty];
        return;
    }
    self.topicImg.hidden = YES;
    
    [self dealWithArr:model.c];
    [self dealWithImage];
    [self.iconIv sd_setImageWithURL:[NSURL URLWithString:model.u.ico.origin]];

    self.nameLb.text = model.u.n;
    _readCountLb.text = [NSString stringWithFormat:@"阅读 %zd",_model.ss.clk.integerValue];
    if ([model.ctm.ams isEqualToString:@"Y"]) {
        self.bigV.hidden = YES;
    } else {
        self.bigV.hidden = !(model.u.aty.integerValue == 3 || model.u.aty.integerValue == 4);
    }
    
}

- (void)dealWithty {
    self.topicImg.hidden = NO;
    [self.topicImg sd_setImageWithURL:[NSURL URLWithString:_model.imgs[0][@"origin"]]];
}

- (void)setImgStr:(NSString *)imgStr {
    _imgStr = imgStr;
    
    if (_imgStr.length == 0) {
        return;
    }
    
    [self.centerImg sd_setImageWithURL:[NSURL URLWithString:_imgStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [self dealWithSize:image.size];
    }];
}

- (void)dealWithSize:(CGSize)size {
    
    if (size.height == 0 || size.width == 0) {
        CGFloat radis = size.height / 160 * kScale;
        CGFloat width = size.width / radis;
        [self.centerImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(160 * kScale));
            make.width.equalTo(@(width));
        }];
        return;
    }
    
    if (size.width >= size.height) {
        if (size.width > 160 * kScale) {
            CGFloat radis = size.width / (160 * kScale);
            size.width = 160 * kScale;
            size.height = size.height / radis;
        }
    } else {
        if (size.height > 160 * kScale) {
            CGFloat radis = size.height / (160 * kScale);
            size.height = 160 * kScale;
            size.width = size.width / radis;
        }
    }
    
    [self.centerImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(size.height));
        make.width.equalTo(@(size.width));
    }];
}

- (void)dealWithImage {
    if (_imgStr.length) {
        [self.centerImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLb.mas_bottom).offset(18 * kScale);
        }];
        NSDictionary *dict = _model.imgs.firstObject;
        NSString *widthS = [dict objectForKey:@"w"];
        NSString *heightS = [dict objectForKey:@"h"];
        CGFloat width = widthS.floatValue;
        CGFloat height = heightS.floatValue;
        [self dealWithSize:CGSizeMake(width, height)];
    } else {
        [self.centerImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0.01));
            make.width.equalTo(@(0.01));
            make.top.equalTo(self.contentLb.mas_bottom).offset(0);
        }];
    }
}

- (void)dealWithArr:(NSString *)content {
    
    if (_model.imgStr.length) {
        self.imgStr = _model.imgStr;
        [self dealWithContentLbEmotion:_model.c];
        return;
    }
    if (self.model.imgs.count > 0) {
        NSDictionary *dic = self.model.imgs.firstObject;
        NSString *imgStr = dic[@"origin"];
        self.imgStr = imgStr;
        _model.imgStr = _imgStr;
    } else {
        _imgStr = @"";
    }
    
    [self dealWithContentLbEmotion:_model.c];
}

- (NSMutableAttributedString *)dealWithContentLbEmotion:(NSString *)content {
    
    if (_model.saveAttr.length) {
        self.contentLb.attributedText = _model.saveAttr;
        return _model.saveAttr;
    }
    
    [self.rangeArray removeAllObjects];
#pragma mark emotion
    NSString *pattren = @"\\[.*?\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattren options:0 error:nil];
    
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] init];
    NSMutableString *tempStr = [NSMutableString string];
    
    __block NSInteger index = 0;
    [regex enumerateMatchesInString:content options:0 range:NSMakeRange(0, content.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        NSRange range = [result rangeAtIndex:0];
        NSString *str = [content substringWithRange:NSMakeRange(index, range.location - index)];
        [tempStr appendString:str];
        NSAttributedString *attrS = [[NSAttributedString alloc] initWithString:str];
        [nmAttrStr appendAttributedString:attrS];
        
        index = range.location + range.length;
        
        NSString *chs = [content substringWithRange:range];
        UIImage *img = [self getChsImage:chs];
        if (img == nil) {
            NSAttributedString *attrS1 = [[NSAttributedString alloc] initWithString:chs];
            [nmAttrStr appendAttributedString:attrS1];
            [tempStr appendString:chs];
        } else {
            NSAttributedString *attrS1 = [NSAttributedString yy_attachmentStringWithEmojiImage:img fontSize:17 * kScale];
            [nmAttrStr appendAttributedString:attrS1];
            [tempStr appendString:@"好"];
        }
    }];
    
    if (index < content.length) {
        NSString *str = [content substringWithRange:NSMakeRange(index, content.length - index)];
        NSAttributedString *attrS = [[NSAttributedString alloc] initWithString:str];
        [nmAttrStr appendAttributedString:attrS];
        [tempStr appendString:str];
    }
    
    if (nmAttrStr.length == 0) {
        [nmAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:content]];
        tempStr = [NSMutableString stringWithString:content];
    }
    
#pragma mark 拿到高亮范围
    
    for (FeedListSLModel *slModel in _model.sl) {
        for (NSString *c in slModel.c) {
            NSArray *rangeArr = [SystemUtil rangesOfString:c inString:tempStr];
            [self.rangeArray addObjectsFromArray:rangeArr];
        }
    }
    
#pragma mark 行间距 和 字号
    
    NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
    para.lineSpacing = nmAttrStr.length > 19 ? 9 * kScale : 0;
    
    [nmAttrStr addAttributes:@{
                               NSParagraphStyleAttributeName : para,
                               NSFontAttributeName : _contentLb.font,
                               } range:NSMakeRange(0, nmAttrStr.length)];
    
#pragma mark 正则处理完成 给文字加高亮点击事件
    for (int i = 0 ; i < self.rangeArray.count ; i ++) {
        NSValue *value = self.rangeArray[i];
        NSRange range = value.rangeValue;
        [nmAttrStr yy_setTextHighlightRange:range color:kUIColorFromRGB(0x358ee7) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            text = [text attributedSubstringFromRange:range];
            [self pushToStock:text.string];
        }];
    }
    
    _model.saveAttr = nmAttrStr.copy;
    self.contentLb.attributedText = nmAttrStr;
    [self.contentLb sizeToFit];
    return nmAttrStr;
}

- (CGFloat)getRowHeight:(FeedListModel *)model {
    if (model == nil) {
        return 0;
    }
    if (model.ty.integerValue == 2) {
        return 198 * kScale;
    }
    NSMutableAttributedString *getEmtionAttrS = [self dealWithContentLbEmotion:model.c];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(MAIN_SCREEN_WIDTH - 24 * kScale, MAXFLOAT)];
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:getEmtionAttrS];
    
    CGRect rect = layout.textBoundingRect;
    
    CGFloat contentHeight = model.c.length == 0 ? -18 * kScale : (rect.size.height);
    if (model.imgs.count == 0) {
        CGFloat height = 115 * kScale + contentHeight;
        model.height = height;
        return height;
    }
    
    NSDictionary *dict = model.imgs.firstObject;
    NSString *widthS = [dict objectForKey:@"w"] == NULL ? nil : [dict objectForKey:@"w"];
    NSString *heightS = [dict objectForKey:@"h"] == NULL ? nil : [dict objectForKey:@"h"];

    CGFloat width = widthS.floatValue;
    CGFloat height = heightS.floatValue;
    
    if (width == 0 || height == 0) {
        return 115 * kScale + contentHeight + 18 * kScale + 160 * kScale;
    }
    
    if (width >= height) {
        if (width > 160 * kScale) {
            CGFloat radis = width / (160 * kScale);
            width = 160 * kScale;
            height = height / radis;
        }
    } else {
        if (height > 160 * kScale) {
            CGFloat radis = height / (160 * kScale);
            height = 160 * kScale;
            width = width / radis;
        }
    }
    
    return 115 * kScale + contentHeight + height + 18 * kScale;
}

- (UIImage *)getChsImage:(NSString *)chs {
    for (EmotionModel *model in self.emojiDataArray) {
        if ([model.chs isEqualToString:chs]) {
            NSString *bundleStr = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil];
            NSBundle *bundle = [[NSBundle alloc] initWithPath:bundleStr];
            NSString *imgPath = [NSString stringWithFormat:@"default/%@",model.png];
            UIImage *image = [UIImage imageNamed:imgPath inBundle:bundle compatibleWithTraitCollection:nil];
            return image;
        }
    }
    return nil;
}

#pragma action

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.imgStr.length == 0) {
        return;
    }
    
    CGRect rect = self.centerImg.frame;
    
    if (self.photoBlock && self.centerImg.image != nil) {
        self.photoBlock(self.centerImg,rect);
    }
    
}

- (void)iconTap:(UITapGestureRecognizer *)tap {
    NSString *urlStr = [NSString stringWithFormat:@"%@jiabei/MY9902?id=%@",API_URL,_model.u.uid];
    
    if (self.pushBlock) {
        self.pushBlock(urlStr);
    }
}

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

- (void)topicBtnClick:(UIButton *)btn {
    if([self.delegate respondsToSelector:@selector(momentSecretTableViewCellTopicDelegate:andModel:)]) {
        [self.delegate momentSecretTableViewCellTopicDelegate:btn.tag andModel:_model];
    }
}

#pragma function 

//- (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
//    NSMutableArray *result = [NSMutableArray array];
//    NSRange searchRange = NSMakeRange(0, str.length);
//    NSRange range;
//    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
//        [result addObject:[NSValue valueWithRange:range]];
//        searchRange = NSMakeRange(NSMaxRange(range), str.length - NSMaxRange(range));
//    }
//    return result;
//}

#pragma mark delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%.2lf",scrollView.contentOffset.y);
}

#pragma mark lazy loading

- (UIImageView *)iconIv {
    if (_iconIv == nil) {
        _iconIv = [[UIImageView alloc] init];
        _iconIv.contentMode = UIViewContentModeScaleAspectFill;
        _iconIv.layer.cornerRadius = 18 * kScale;
        _iconIv.clipsToBounds = YES;
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

- (UIImageView *)centerImg {
    if (_centerImg == nil) {
        _centerImg = [UIImageView new];
        _centerImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_centerImg addGestureRecognizer:tap];
    }
    return _centerImg;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 5 * kScale)];
        _topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _topView;
}

- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kNameColor;
        _nameLb.font = [UIFont systemFontOfSize:15 * kScale];
    }
    return _nameLb;
}

- (YYLabel *)contentLb {
    if (_contentLb == nil) {
        _contentLb = [[YYLabel alloc] init];
        _contentLb.numberOfLines = 0;
        _contentLb.textColor = kUIColorFromRGB(0x333333);
        _contentLb.font = [UIFont systemFontOfSize:17 * kScale];
        _contentLb.preferredMaxLayoutWidth = MAIN_SCREEN_WIDTH - 24 * kScale;
    }
    return _contentLb;
}

- (UILabel *)readCountLb {
    if (_readCountLb == nil) {
        _readCountLb = [UILabel new];
        _readCountLb.font = [UIFont systemFontOfSize:11 * kScale];
        _readCountLb.textColor = kUIColorFromRGB(0x808080);
    }
    return _readCountLb;
}

- (UIButton *)writeComBtn {
    if (_writeComBtn == nil) {
        _writeComBtn = [UIButton new];
        [_writeComBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_writeComBtn setTitleColor:kUIColorFromRGB(0xb2b2b2) forState:UIControlStateNormal];
        [_writeComBtn setImage:[UIImage imageNamed:@"moment_common_ico"] forState:UIControlStateNormal];
        [_writeComBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
        _writeComBtn.titleLabel.font = [UIFont systemFontOfSize:11 * kScale];
        _writeComBtn.userInteractionEnabled = NO;
    }
    return _writeComBtn;
}

- (NSArray *)emojiDataArray {
    if (_emojiDataArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil];
        NSBundle *bundle = [[NSBundle alloc] initWithPath:path];
        _emojiDataArray = [NSArray arrayWithContentsOfFile:[bundle pathForResource:@"default/EmoInfo.plist" ofType:nil]];
        NSMutableArray *nmArr = [NSMutableArray array];
        for (NSDictionary *dic in _emojiDataArray) {
            EmotionModel *model = [EmotionModel new];
            [model setValuesForKeysWithDictionary:dic];
            [nmArr addObject:model];
        }
        _emojiDataArray = nmArr.copy;
    }
    return _emojiDataArray;
}

- (NSMutableArray *)rangeArray {
    if (_rangeArray == nil) {
        _rangeArray = [NSMutableArray array];
    }
    return _rangeArray;
}

#pragma mark topic

- (UIImageView *)topicImg {
    if (_topicImg == nil) {
        _topicImg = [UIImageView new];
        _topicImg.userInteractionEnabled = YES;
        _topicImg.contentMode = UIViewContentModeScaleAspectFill;
        _topicImg.clipsToBounds = YES;
    }
    return _topicImg;
}

- (UIButton *)topicBtn1 {
    if (_topicBtn1 == nil) {
        _topicBtn1 = [UIButton new];
        _topicBtn1.backgroundColor = kButtonBGColor;
        [_topicBtn1 setTitle:@"匿名回答" forState:UIControlStateNormal];
        [_topicBtn1 setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        _topicBtn1.titleLabel.font = [UIFont systemFontOfSize:15 * kScale];
        _topicBtn1.tag = 1;
        [_topicBtn1 addTarget:self action:@selector(topicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topicBtn1;
}

- (UIButton *)topicBtn2 {
    if (_topicBtn2 == nil) {
        _topicBtn2 = [UIButton new];
        _topicBtn2.backgroundColor = kUIColorFromRGB(0xffffff);
        [_topicBtn2 setTitle:@"让朋友回答" forState:UIControlStateNormal];
        [_topicBtn2 setTitleColor:kTitleColor forState:UIControlStateNormal];
        _topicBtn2.titleLabel.font = [UIFont systemFontOfSize:15 * kScale];
        _topicBtn2.tag = 2;
        [_topicBtn2 addTarget:self action:@selector(topicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topicBtn2;
}

@end
