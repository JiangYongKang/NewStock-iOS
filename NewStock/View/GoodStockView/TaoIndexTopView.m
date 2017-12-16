//
//  TaoIndexTopView.m
//  NewStock
//
//  Created by 王迪 on 2017/3/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoIndexTopView.h"
#import "Defination.h"
#import <Masonry.h>

@interface TaoIndexTopView ()

@property (nonatomic, strong) UILabel *centerLb;
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, strong) UILabel *hotLb;
@property (nonatomic, strong) UILabel *hotLb1;
@property (nonatomic, strong) UILabel *hotLb2;
@property (nonatomic, strong) UILabel *hotLb3;
@property (nonatomic, strong) UILabel *hotLb4;

@property (nonatomic, strong) NSMutableArray *nmArr;

@end

@implementation TaoIndexTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.centerLb];
    [self addSubview:self.centerBtn];
    [self addSubview:self.hotLb];
    [self addSubview:self.hotLb1];
    [self addSubview:self.hotLb2];
    [self addSubview:self.hotLb3];
    [self addSubview:self.hotLb4];
    
    [self.nmArr addObject:self.hotLb1];
    [self.nmArr addObject:self.hotLb2];
    [self.nmArr addObject:self.hotLb3];
    [self.nmArr addObject:self.hotLb4];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15 * kScale);
        make.centerX.equalTo(self);
    }];
    
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerLb.mas_bottom).offset(10 * kScale);
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(15 * kScale);
        make.right.equalTo(self).offset(-15 * kScale);
        make.height.equalTo(@(30 * kScale));
    }];
    
    [self.hotLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15 * kScale);
        make.top.equalTo(self.centerBtn.mas_bottom).offset(24 * kScale);
    }];
    
    [self.hotLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb.mas_right).offset(15 * kScale);
        make.centerY.equalTo(self.hotLb);
    }];
    
    [self.hotLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb1.mas_right).offset(15 * kScale);
        make.centerY.equalTo(self.hotLb1);
    }];
    
    [self.hotLb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb2.mas_right).offset(15 * kScale);
        make.centerY.equalTo(self.hotLb2);
    }];
    
    [self.hotLb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotLb3.mas_right).offset(15 * kScale);
        make.centerY.equalTo(self.hotLb3);
    }];
    
}

- (void)setHotNameArray:(NSArray *)hotNameArray {
    _hotNameArray = hotNameArray;
    
    if (_hotNameArray.count > 4) {
        NSMutableArray *nmArr = [NSMutableArray arrayWithArray:hotNameArray];
        _hotNameArray = [nmArr subarrayWithRange:NSMakeRange(0, 4)];
    }
    
    for (int i = 0; i < _hotNameArray.count; i ++) {
        TaoHotPeopleModel *model = _hotNameArray[i];
        UILabel *lb = self.nmArr[i];
        lb.text = model.n;
    }
    
}

- (void)btnClick:(UIButton *)btn {
    if (self.pushBlock) {
        self.pushBlock();
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    
    TaoHotPeopleModel *model = self.hotNameArray[index - 1];
    NSString *name = model.n;
    
    if (self.hotLbTapBLock) {
        self.hotLbTapBLock(name);
    }
    
}

- (UILabel *)centerLb {
    if (_centerLb == nil) {
        _centerLb = [UILabel new];
        _centerLb.textColor = kUIColorFromRGB(0xff1919);
        _centerLb.font = [UIFont boldSystemFontOfSize:16 * kScale];
        _centerLb.text = @"牛散达人";
    }
    return _centerLb;
}

- (UIButton *)centerBtn {
    if (_centerBtn == nil) {
        _centerBtn = [UIButton new];
        _centerBtn.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        _centerBtn.layer.cornerRadius = 15 * kScale;
        
        [_centerBtn setImage:[UIImage imageNamed:@"black_search_nor"] forState:UIControlStateNormal];
        [_centerBtn setTitle:@"请输入牛散姓名或股票代码追踪牛散" forState:UIControlStateNormal];
        [_centerBtn.titleLabel setFont:[UIFont systemFontOfSize:14 * kScale]];
        [_centerBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _centerBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_centerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

- (NSMutableArray *)nmArr {
    if (_nmArr == nil) {
        _nmArr = [NSMutableArray array];
    }
    return _nmArr;
}

- (UILabel *)hotLb {
    if (_hotLb == nil) {
        _hotLb = [UILabel new];
        _hotLb.font = [UIFont systemFontOfSize:14 * kScale];
        _hotLb.textColor = kUIColorFromRGB(0x666666);
        _hotLb.text = @"近期热门:  ";
    }
    return _hotLb;
}

- (UILabel *)hotLb1 {
    if (_hotLb1 == nil) {
        _hotLb1 = [UILabel new];
        _hotLb1.font = [UIFont systemFontOfSize:14 * kScale];
        _hotLb1.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb1.tag = 1;
        _hotLb1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_hotLb1 addGestureRecognizer:tap];
    }
    return _hotLb1;
}

- (UILabel *)hotLb2 {
    if (_hotLb2 == nil) {
        _hotLb2 = [UILabel new];
        _hotLb2.font = [UIFont systemFontOfSize:14 * kScale];
        _hotLb2.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb2.tag = 2;
        _hotLb2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_hotLb2 addGestureRecognizer:tap];
    }
    return _hotLb2;
}

- (UILabel *)hotLb3 {
    if (_hotLb3 == nil) {
        _hotLb3 = [UILabel new];
        _hotLb3.font = [UIFont systemFontOfSize:14 * kScale];
        _hotLb3.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb3.tag = 3;
        _hotLb3.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_hotLb3 addGestureRecognizer:tap];
    }
    return _hotLb3;
}

- (UILabel *)hotLb4 {
    if (_hotLb4 == nil) {
        _hotLb4 = [UILabel new];
        _hotLb4.font = [UIFont systemFontOfSize:14 * kScale];
        _hotLb4.textColor = kUIColorFromRGB(0x358ee7);
        _hotLb4.tag = 4;
        _hotLb4.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_hotLb4 addGestureRecognizer:tap];
    }
    return _hotLb4;
}

@end
