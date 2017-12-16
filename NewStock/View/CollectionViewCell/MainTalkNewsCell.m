//
//  MainTalkNewsCell.m
//  NewStock
//
//  Created by 王迪 on 2017/4/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainTalkNewsCell.h"
#import "Defination.h"
#import <Masonry.h>

@interface MainTalkNewsCell ()

@property (nonatomic, strong) UILabel *newsLb1;

@end

@implementation MainTalkNewsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.newsLb1];
    [_newsLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(6 * kScale);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12 * kScale);
    }];
    
}

- (void)setModel:(NewsModel *)model {
    _model = model;
    [self updateNewLb:model andIndex:0];
}

- (void)updateNewLb:(NewsModel *)model andIndex:(int)index {
    self.newsLb1.text = [self matchSpan:model.tt];
}

- (NSString *)matchSpan:(NSString *)str {
    
    NSMutableString *nmSy = [NSMutableString string];
    __block NSInteger index = 0;
    
    NSString *patten = @"<span style=\"color:(.*?);\">(.*?)</span>";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    
    [regular enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSRange cRange = [result rangeAtIndex:2];
        NSRange matchRange = [result rangeAtIndex:0];
        
        NSString *leftStr = [str substringWithRange:NSMakeRange(index, matchRange.location - index)];
        NSString *cStr = [str substringWithRange:cRange];
        
        index = matchRange.location + matchRange.length;
        [nmSy appendString:leftStr];
        [nmSy appendString:cStr];
    }];
    
    if (nmSy.length != 0) {
        return nmSy.copy;
    } else {
        return str;
    }
}


- (UILabel *)newsLb1 {
    if (_newsLb1 == nil) {
        _newsLb1 = [UILabel new];
        _newsLb1.textColor = kUIColorFromRGB(0x000000);
        _newsLb1.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _newsLb1;
}
@end
