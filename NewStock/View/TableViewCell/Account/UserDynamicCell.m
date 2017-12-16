//
//  UserDynamicCell.m
//  NewStock
//
//  Created by 王迪 on 2017/1/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "UserDynamicCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "Defination.h"
#import "EmotionModel.h"

@interface UserDynamicCell ()

@property (nonatomic, strong) UIImageView *userIcon;

@property (nonatomic, strong) UIImageView *bigVIcon;

@property (nonatomic, strong) UILabel *name_lb;

@property (nonatomic, strong) UILabel *content_lb;

@property (nonatomic, strong) UILabel *time_lb;

@property (nonatomic, strong) UILabel *desc_lb;

@property (nonatomic, strong) UIButton *delete_btn;

@property (nonatomic, strong) NSArray *emojiDataArray;

@end

@implementation UserDynamicCell

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

- (UILabel *)desc_lb {
    if (_desc_lb == nil) {
        _desc_lb = [UILabel new];
        _desc_lb.backgroundColor = kUIColorFromRGB(0xf5f5f5);
        _desc_lb.font = [UIFont systemFontOfSize:12];
        _desc_lb.textColor = kUIColorFromRGB(0x666666);
    }
    return _desc_lb;
}

- (UIImageView *)userIcon {
    if (_userIcon == nil) {
        _userIcon = [[UIImageView alloc] init];
        _userIcon.userInteractionEnabled = YES;
        _userIcon.layer.cornerRadius = 16;
        _userIcon.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_userIcon addGestureRecognizer:tap];
    }
    return _userIcon;
}

- (UIImageView *)bigVIcon {
    if (_bigVIcon == nil) {
        _bigVIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bigV"]];
    }
    return _bigVIcon;
}

- (UILabel *)name_lb {
    if (_name_lb == nil) {
        _name_lb = [UILabel new];
        _name_lb.font = [UIFont systemFontOfSize:14];
        _name_lb.textColor = kUIColorFromRGB(0x333333);
    }
    return _name_lb;
}

- (UILabel *)time_lb {
    if (_time_lb == nil) {
        _time_lb = [UILabel new];
        _time_lb.textColor = kUIColorFromRGB(0xb2b2b2);
        _time_lb.font = [UIFont systemFontOfSize:12];
    }
    return _time_lb;
}

- (UILabel *)content_lb {
    if (_content_lb == nil) {
        _content_lb = [UILabel new];
        _content_lb.textColor = kUIColorFromRGB(0x666666);
        _content_lb.font = [UIFont systemFontOfSize:16];
    }
    return _content_lb;
}

- (UIButton *)delete_btn {
    if (_delete_btn == nil) {
        _delete_btn = [[UIButton alloc] init];
        NSMutableAttributedString *nmAttrString = [[NSMutableAttributedString alloc]initWithString:@"删除" attributes:@{
                            NSForegroundColorAttributeName:kUIColorFromRGB(0x666666),
                            NSFontAttributeName : [UIFont systemFontOfSize:11],                                       }];
        [_delete_btn setAttributedTitle:nmAttrString.copy forState:UIControlStateNormal];
        [_delete_btn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_delete_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delete_btn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.name_lb];
    [self.contentView addSubview:self.content_lb];
    [self.contentView addSubview:self.userIcon];
    [self.contentView addSubview:self.time_lb];
    [self.contentView addSubview:self.delete_btn];
    [self.contentView addSubview:self.desc_lb];
    [self.contentView addSubview:self.bigVIcon];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.width.height.equalTo(@32);
    }];
    
    [self.bigVIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.userIcon);
    }];
    
    [self.name_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userIcon);
        make.left.equalTo(self.userIcon.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(15);
    }];
    
    [self.content_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.name_lb);
        make.top.equalTo(self.userIcon.mas_bottom).offset(5);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.time_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.name_lb);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.delete_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@16);
        make.width.equalTo(@25);
    }];
    
    [self.desc_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.name_lb);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.time_lb.mas_top).offset(-13);
        make.height.equalTo(@24);
    }];
    
}

- (void)setModel:(UserDynamicModel *)model {

    _model = model;
    UserDynamicList *listModel = model.listArray[0];

    self.time_lb.text = model.tm;
    self.name_lb.text = model.userName;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.origin]];
    self.bigVIcon.hidden = !(model.aty.integerValue == 3 || model.aty.integerValue == 4);
    NSString *content = [NSString stringWithFormat:@"%@%@",model.n,model.sn];
    if (listModel.tt.length) {
        NSMutableAttributedString *nmAttrString = [[NSMutableAttributedString alloc] initWithString:content attributes:@{
                    NSFontAttributeName:[UIFont systemFontOfSize:16],
                    NSForegroundColorAttributeName:kUIColorFromRGB(0x666666),
                                                                                                                         }];
        
        NSMutableAttributedString *nmAttrs = [self dealWithSy:listModel.tt :_content_lb.font.lineHeight];
        [nmAttrs addAttributes:@{
                                 NSForegroundColorAttributeName:kUIColorFromRGB(0x5299df),
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 }
                         range:NSMakeRange(0, nmAttrs.length)];
        [nmAttrString appendAttributedString:nmAttrs];
        
        self.content_lb.attributedText = nmAttrString;
    }else {
        self.content_lb.text = content;
    }

    if ([model.ty isEqualToString:@"O_COMMENT"]) {
        self.desc_lb.hidden = NO;
        NSAttributedString *sy = [self dealWithSy:listModel.sy :_desc_lb.font.lineHeight].copy;
        self.desc_lb.attributedText = sy;
    }else {
        self.desc_lb.hidden = YES;
        self.desc_lb.text = @"";
    }
    
}

- (NSMutableAttributedString *)dealWithSy:(NSString *)sy :(CGFloat)lineHeight {
    
    NSString *pattren = @"\\[.*?\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattren options:0 error:nil];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:@""];
    
    __block NSInteger index = 0;
    [regex enumerateMatchesInString:sy options:0 range:NSMakeRange(0, sy.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        NSRange range = [result rangeAtIndex:0];
        NSString *str = [sy substringWithRange:NSMakeRange(index, range.location - index)];
        NSAttributedString *attrS = [[NSAttributedString alloc] initWithString:str];
        [nmAttrStr appendAttributedString:attrS];
        
        index = range.location + range.length;
        
        NSString *chs = [sy substringWithRange:range];
        UIImage *img = [self getChsImage:chs];
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = img;
        attach.bounds = CGRectMake(0, -3, lineHeight, lineHeight);
        NSAttributedString *attrS1 = [NSAttributedString attributedStringWithAttachment:attach];
        [nmAttrStr appendAttributedString:attrS1];
        
    }];
    
    return (nmAttrStr.length != 0) ? nmAttrStr : [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@",sy]];
}

- (void)btnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(userDynamicCellDelegateClick:ids:index:)]) {
        [self.delegate userDynamicCellDelegateClick:1 ids:self.model.ids index:self.index];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(userDynamicCellDelegateClick:ids:index:)]) {
        [self.delegate userDynamicCellDelegateClick:2 ids:self.model.uid index:self.index];
    }
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

@end
