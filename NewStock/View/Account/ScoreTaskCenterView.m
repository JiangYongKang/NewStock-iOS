//
//  ScoreTaskCenterView.m
//  NewStock
//
//  Created by 王迪 on 2017/4/17.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "ScoreTaskCenterView.h"
#import "Defination.h"
#import <Masonry.h>
#import "UIView+Masonry_Arrange.h"
#import "ScoreTaskButton.h"


@interface ScoreTaskCenterView ()

@property (nonatomic, strong) UILabel *centerBlockLb;
@property (nonatomic, strong) UILabel *centerDailyLb;
@property (nonatomic, strong) UILabel *centerDscLb;
@property (nonatomic, strong) UILabel *centerTopLineLb;

@property (nonatomic, strong) ScoreTaskButton *centerBtn1;
@property (nonatomic, strong) ScoreTaskButton *centerBtn2;
@property (nonatomic, strong) ScoreTaskButton *centerBtn3;
@property (nonatomic, strong) ScoreTaskButton *centerBtn4;
@property (nonatomic, strong) ScoreTaskButton *centerBtn5;

@property (nonatomic, strong) NSMutableArray <ScoreTaskButton *> *btnArray;

@end

@implementation ScoreTaskCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.centerBlockLb];
    [self addSubview:self.centerDailyLb];
    [self addSubview:self.centerDscLb];
    [self addSubview:self.centerTopLineLb];
    
    [self.centerBlockLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12 * kScale);
        make.top.equalTo(self).offset(8);
        make.width.equalTo(@(3 * kScale));
        make.height.equalTo(@(14 * kScale));
    }];
    
    [self.centerDailyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerBlockLb);
        make.left.equalTo(self.centerBlockLb.mas_right).offset(8 * kScale);
    }];
    
    [self.centerDscLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerDailyLb.mas_right).offset(12 * kScale);
        make.centerY.equalTo(self.centerBlockLb);
    }];
    
    [self.centerTopLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@(0.5));
        make.top.equalTo(self).offset(32 * kScale);
    }];
    
    [self addSubview:self.centerBtn1];
    [self addSubview:self.centerBtn2];
    [self addSubview:self.centerBtn3];
    [self addSubview:self.centerBtn4];
    [self addSubview:self.centerBtn5];
    
    [self.btnArray addObject:_centerBtn1];
    [self.btnArray addObject:_centerBtn2];
    [self.btnArray addObject:_centerBtn3];
    [self.btnArray addObject:_centerBtn4];
    [self.btnArray addObject:_centerBtn5];
    
    CGFloat width = MAIN_SCREEN_WIDTH * 0.2;
    CGFloat height = 83 * kScale;
    
    [self.centerBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.top.equalTo(@(52 * kScale));
    }];
    
    [self.centerBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.top.equalTo(@(52 * kScale));
    }];
    
    [self.centerBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.top.equalTo(@(52 * kScale));
    }];
    
    [self.centerBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.top.equalTo(@(52 * kScale));
    }];
    
    [self.centerBtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.top.equalTo(@(52 * kScale));
    }];
    
    [self distributeSpacingHorizontallyWith:@[_centerBtn1,_centerBtn2,_centerBtn3,_centerBtn4,_centerBtn5]];
}

- (void)setArray:(NSArray<MyScoreDayModel *> *)array {
    _array = array;
    
    for (int i = 0; i < array.count; i ++) {
        if (i == 5) {
            break;
        }
        MyScoreDayModel *model = array[i];
        ScoreTaskButton *btn = self.btnArray[i];
        [btn setCenterStr:model.n];
        [btn setImgUrl:model.p];
        btn.url = model.url;
        [btn setBottomLbStr:[NSString stringWithFormat:@"+%zd/%zd",model.sc.integerValue,model.t.integerValue]];
        if (model.sc.integerValue == model.t.integerValue) {
            [btn setIsCompleted:YES];
        } else {
            [btn setIsCompleted:NO];
        }
    }
}

- (void)btnClick:(ScoreTaskButton *)btn {
    if (btn.isCompleted) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(ScoreTaskCenterViewBtnClick:)]) {
        [self.delegate ScoreTaskCenterViewBtnClick:btn.url];
    }
}

#pragma mark lazyloading 

- (UILabel *)centerBlockLb {
    if (_centerBlockLb == nil) {
        _centerBlockLb = [UILabel new];
        _centerBlockLb.backgroundColor = kButtonBGColor;
    }
    return _centerBlockLb;
}

- (UILabel *)centerDailyLb {
    if (_centerDailyLb == nil) {
        _centerDailyLb = [UILabel new];
        _centerDailyLb.textColor = kUIColorFromRGB(0x333333);
        _centerDailyLb.font = [UIFont systemFontOfSize:14 * kScale];
        _centerDailyLb.text = @"每日任务";
    }
    return _centerDailyLb;
}

- (UILabel *)centerDscLb {
    if (_centerDscLb == nil) {
        _centerDscLb = [UILabel new];
        _centerDscLb.text = nil;//@"全部完成可获取双倍积分";
        _centerDscLb.textColor = kUIColorFromRGB(0xb2b2b2);
        _centerDscLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:11 * kScale];
    }
    return _centerDscLb;
}

- (UILabel *)centerTopLineLb {
    if (_centerTopLineLb == nil) {
        _centerTopLineLb = [UILabel new];
        _centerTopLineLb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _centerTopLineLb;
}

- (ScoreTaskButton *)centerBtn1 {
    if (_centerBtn1 == nil) {
        _centerBtn1 = [ScoreTaskButton new];
        _centerBtn1.imgStr = @"score_completed_icon";
        _centerBtn1.centerStr = @"打开客户端";
        _centerBtn1.bottomLbStr = @"+5/5";
        _centerBtn1.isCompleted = YES;
        [_centerBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn1;
}

- (ScoreTaskButton *)centerBtn2 {
    if (_centerBtn2 == nil) {
        _centerBtn2 = [ScoreTaskButton new];
        _centerBtn2.imgStr = @"score_commend_icon";
        _centerBtn2.centerStr = @"发表评论";
        _centerBtn2.bottomLbStr = @"+0/10";
        _centerBtn2.isCompleted = NO;
        [_centerBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn2;
}

- (ScoreTaskButton *)centerBtn3 {
    if (_centerBtn3 == nil) {
        _centerBtn3 = [ScoreTaskButton new];
        _centerBtn3.imgStr = @"score_shareForum_icon";
        _centerBtn3.centerStr = @"分享文章";
        _centerBtn3.bottomLbStr = @"+0/10";
        _centerBtn3.isCompleted = NO;
        [_centerBtn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn3;
}

- (ScoreTaskButton *)centerBtn4 {
    if (_centerBtn4 == nil) {
        _centerBtn4 = [ScoreTaskButton new];
        _centerBtn4.imgStr = @"score_postSecret_icon";
        _centerBtn4.centerStr = @"发匿名说";
        _centerBtn4.bottomLbStr = @"+0/10";
        _centerBtn4.isCompleted = NO;
        [_centerBtn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn4;
}

- (ScoreTaskButton *)centerBtn5 {
    if (_centerBtn5 == nil) {
        _centerBtn5 = [ScoreTaskButton new];
        _centerBtn5.imgStr = @"score_shareFriend_icon";
        _centerBtn5.centerStr = @"邀请好友";
        _centerBtn5.bottomLbStr = @"+0/10";
        _centerBtn5.isCompleted = NO;
        [_centerBtn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn5;
}

- (NSMutableArray<ScoreTaskButton *> *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

@end
