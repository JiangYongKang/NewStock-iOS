//
//  UserInfoHeaderBottomView.m
//  NewStock
//
//  Created by 王迪 on 2017/4/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "UserInfoHeaderBottomView.h"
#import "Defination.h"
#import <Masonry.h>

@interface UserInfoHeaderBottomView ()

@property (nonatomic) UILabel *leftLb;

@property (nonatomic) UILabel *centerLb;

@end

@implementation UserInfoHeaderBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setHasList:(BOOL)hasList {
    _hasList = hasList;
    
    if (_hasList) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftLb.hidden = NO;
        self.centerLb.hidden = YES;
    } else {
        self.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        self.leftLb.hidden = YES;
        self.centerLb.hidden = NO;
    }
}

- (void)setupUI {

    [self addSubview:self.centerLb];
    [self addSubview:self.leftLb];
    
    [self.leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
    }];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (UILabel *)centerLb {
    if (_centerLb == nil) {
        _centerLb = [UILabel new];
//        _centerLb.backgroundColor = [UIColor whiteColor];
        _centerLb.textAlignment = NSTextAlignmentCenter;
        _centerLb.text = @"您未关注大V,暂无大V动态哦~";
        _centerLb.font = [UIFont boldSystemFontOfSize:11 * kScale];
        _centerLb.textColor = kUIColorFromRGB(0x666666);
        _centerLb.hidden = YES;
    }
    return _centerLb;
}

- (UILabel *)leftLb {
    if (_leftLb == nil) {
        _leftLb = [UILabel new];
//        _leftLb.backgroundColor = [UIColor whiteColor];
        _leftLb.textAlignment = NSTextAlignmentLeft;
        _leftLb.text = @"     你关注的大V动态";
        _leftLb.font = [UIFont boldSystemFontOfSize:11 * kScale];
        _leftLb.textColor = kUIColorFromRGB(0x666666);
    }
    return _leftLb;
}




@end
