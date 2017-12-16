//
//  TaoIndexSkillBottomView.m
//  NewStock
//
//  Created by 王迪 on 2017/6/22.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoIndexSkillBottomView.h"
#import "MarketConfig.h"
#import "Defination.h"
#import <Masonry.h>
#import "TaoIndexModel.h"

@interface TaoIndexSkillBottomView ()

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) UIFont *font;

@end

@implementation TaoIndexSkillBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = kUIColorFromRGB(0xffffff);
    }
    return self;
}

- (void)setupUI {
    
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    CGFloat x = 12 * kScale;
    CGFloat y = 12 * kScale;
    
    for (UIButton *btn in self.btnArray) {
        [btn removeFromSuperview];
    }
    [_btnArray removeAllObjects];
    
    for (TaoIndexModelListClild *model in _dataArray) {
        TaoIndexSkillBottomButton *btn = [self getBtn:model];
        [self addSubview:btn];
        if ((btn.frame.size.width + x) > MAIN_SCREEN_WIDTH) {
            x = 12 * kScale;
            y = y + (30 + 12) * kScale;
        }
        btn.frame = CGRectMake(x, y, btn.frame.size.width, 30 * kScale);
        x = btn.frame.origin.x + btn.frame.size.width + 12 * kScale;
        [_btnArray addObject:btn];
    }
    
}

- (TaoIndexSkillBottomButton *)getBtn:(TaoIndexModelListClild *)model {
    
    TaoIndexSkillBottomButton *btn = [TaoIndexSkillBottomButton new];
    
    btn.title = model.n;
    NSString *btnStr = [NSString stringWithFormat:@"%@ (%zd)",model.n,model.count.integerValue];
    btn.code = model.ids;
    [btn setTitle:btnStr forState:UIControlStateNormal];
    btn.titleLabel.font = self.font;
    [btn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, [self getStrWidth:btnStr], 0);
    btn.layer.cornerRadius = 4 * kScale;
//    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = kTitleColor.CGColor;
    btn.layer.borderWidth = 0.8;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

#pragma mark function

- (void)btnClick:(TaoIndexSkillBottomButton *)btn {
    if ([self.delegate respondsToSelector:@selector(taoIndexSkillBottomViewDelegatePushTo:title:)]) {
        [self.delegate taoIndexSkillBottomViewDelegatePushTo:btn.code title:btn.title];
    }
}

- (CGFloat)getStrWidth:(NSString *)str {
    return [str boundingRectWithSize:CGSizeMake(MAXFLOAT, self.font.lineHeight) options:1 attributes:@{NSFontAttributeName : self.font} context:nil].size.width + 10 * kScale + 2;
}

#pragma mark

- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (UIFont *)font {
    if (_font == nil) {
        _font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _font;
}

@end

@implementation TaoIndexSkillBottomButton



@end
