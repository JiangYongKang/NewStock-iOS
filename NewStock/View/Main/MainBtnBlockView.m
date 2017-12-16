//
//  MainBtnBlockView.m
//  NewStock
//
//  Created by 王迪 on 2017/3/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MainBtnBlockView.h"
#import "Defination.h"
#import "MainLinkButton.h"
#import "UIView+Masonry_Arrange.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <Masonry.h>

@interface MainBtnBlockView ()

@property (nonatomic, strong) MainLinkButton *btn1;
@property (nonatomic, strong) MainLinkButton *btn2;
@property (nonatomic, strong) MainLinkButton *btn3;
@property (nonatomic, strong) MainLinkButton *btn4;
@property (nonatomic, strong) MainLinkButton *btn5;
@property (nonatomic, strong) MainLinkButton *btn6;
@property (nonatomic, strong) MainLinkButton *btn7;
@property (nonatomic, strong) MainLinkButton *btn8;
@property (nonatomic, strong) NSMutableArray *nmArr;

@end

@implementation MainBtnBlockView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.btn1];
    [self addSubview:self.btn2];
    [self addSubview:self.btn3];
    [self addSubview:self.btn4];
    [self addSubview:self.btn5];
    [self addSubview:self.btn6];
    [self addSubview:self.btn7];
    [self addSubview:self.btn8];
    
    [self.nmArr addObject:self.btn1];
    [self.nmArr addObject:self.btn2];
    [self.nmArr addObject:self.btn3];
    [self.nmArr addObject:self.btn4];
    [self.nmArr addObject:self.btn5];
    [self.nmArr addObject:self.btn6];
    [self.nmArr addObject:self.btn7];
    [self.nmArr addObject:self.btn8];
    
    CGFloat topM = 20;
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topM * kScale);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 60 * kScale));
    }];

    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topM * kScale);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 60 * kScale));
    }];

    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topM * kScale);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 60 * kScale));
    }];

    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topM * kScale);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 60 * kScale));
    }];
    
    [self distributeSpacingHorizontallyWith:@[_btn1 , _btn2 , _btn3 , _btn4]];
    
    [self.btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn1.mas_bottom).offset(15 * kScale);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 60 * kScale));
    }];
    
    [self.btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn5);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 60 * kScale));
    }];
    
    [self.btn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn5);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 60 * kScale));
    }];
    
    [self.btn8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn5);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_WIDTH * 0.25, 60 * kScale));
    }];
    
    [self distributeSpacingHorizontallyWith:@[_btn5 , _btn6 , _btn7, _btn8]];
    
//    UILabel *lb = [UILabel new];
//    lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
//    [self addSubview:lb];
//    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self).offset(1);
//        make.height.equalTo(@(0.5));
//    }];
    
    UILabel *bottomLb = [UILabel new];
    bottomLb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self addSubview:bottomLb];
    [bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-1);
        make.height.equalTo(@(0.5));
    }];
}

- (void)setArray:(NSArray<LinksModel *> *)array {
    
    if (array.count < 8) {
        return;
    }
    _array = array;
    
    for (int i = 0; i < 8; i ++) {
        MainLinkButton *btn = self.nmArr[i];
        LinksModel *model = array[i];
        btn.title = model.n;
        btn.imgURL = model.ico;
    }
    
}

- (void)btnClick:(UIButton *)btn {
    LinksModel *model = _array[btn.tag];
    if (self.pushBlock) {
        self.pushBlock(model.url);
    }
}

- (MainLinkButton *)btn1 {
    if (_btn1 == nil) {
        _btn1 = [MainLinkButton new];
        _btn1.tag = 0;
        _btn1.imgStr = @"ic_hushen_nor";
        _btn1.title = @"沪深行情";
        [_btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (MainLinkButton *)btn2 {
    if (_btn2 == nil) {
        _btn2 = [MainLinkButton new];
        _btn2.tag = 1;
        _btn2.imgStr = @"ic_niusan_nor";
        _btn2.title = @"牛散达人";
        [_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (MainLinkButton *)btn3 {
    if (_btn3 == nil) {
        _btn3 = [MainLinkButton new];
        _btn3.imgStr = @"ic_longhubang";
        _btn3.title = @"深度龙虎榜";
        _btn3.tag = 2;
        [_btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

- (MainLinkButton *)btn4 {
    if (_btn4 == nil) {
        _btn4 = [MainLinkButton new];
        _btn4.imgStr = @"ic_chouqian_nor";
        _btn4.title = @"财神签";
        _btn4.tag = 3;
        [_btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn4;
}
- (MainLinkButton *)btn5 {
    if (_btn5 == nil) {
        _btn5 = [MainLinkButton new];
        _btn5.imgStr = @"ic_chouqian_nor";
        _btn5.title = @"财神签";
        _btn5.tag = 4;
        [_btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn5;
}

- (MainLinkButton *)btn6 {
    if (_btn6 == nil) {
        _btn6 = [MainLinkButton new];
        _btn6.imgStr = @"ic_chouqian_nor";
        _btn6.title = @"财神签";
        _btn6.tag = 5;
        [_btn6 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn6;
}

- (MainLinkButton *)btn7 {
    if (_btn7 == nil) {
        _btn7 = [MainLinkButton new];
        _btn7.imgStr = @"ic_chouqian_nor";
        _btn7.title = @"财神签";
        _btn7.tag = 6;
        [_btn7 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn7;
}
- (MainLinkButton *)btn8 {
    if (_btn8 == nil) {
        _btn8 = [MainLinkButton new];
        _btn8.imgStr = @"ic_chouqian_nor";
        _btn8.title = @"财神签";
        _btn8.tag = 7;
        [_btn8 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn8;
}

- (NSMutableArray *)nmArr {
    if (_nmArr == nil) {
        _nmArr = [NSMutableArray array];
    }
    return _nmArr;
}


@end
