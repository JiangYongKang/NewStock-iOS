//
//  HalfCellView.m
//  NewStock
//
//  Created by 王迪 on 2017/2/15.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "HalfCellView.h"
#import "Defination.h"
#import <Masonry.h>

@interface HalfCellView ()

@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *rateLb;

@end

@implementation HalfCellView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    [self addSubview:self.nameLb];
    [self addSubview:self.rateLb];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15 * kScale);
        make.centerY.equalTo(self);
    }];
    
    [self.rateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10 * kScale);
        make.centerY.equalTo(self);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(HalfCellViewDelegate:)]) {
        [self.delegate HalfCellViewDelegate:self];
    }
}

- (void)setModel:(TaoIndexModelClildStock *)model {
    _model = model;
    
    if (model == nil) {
        self.nameLb.text = @"";
        self.rateLb.text = @"";
        return;
    }
    
    NSString *name = model.n;
    NSString *rate = [NSString stringWithFormat:@"%.2lf%%",model.zdf.floatValue];
 
    self.nameLb.text = name;
    self.rateLb.text = rate;
    
    if (rate.floatValue > 0) {
        self.rateLb.textColor = kUIColorFromRGB(0xff1919);
    } else if (rate.floatValue < 0) {
        self.rateLb.textColor = kUIColorFromRGB(0x009d00);
    } else {
        self.rateLb.textColor = kUIColorFromRGB(0x666666);
    }
    
}



- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel new];
        _nameLb.textColor = kUIColorFromRGB(0x333333);
        _nameLb.font = [UIFont systemFontOfSize:16 * kScale];
    }
    return _nameLb;
}

- (UILabel *)rateLb {
    if (_rateLb == nil) {
        _rateLb = [UILabel new];
        _rateLb.font = [UIFont boldSystemFontOfSize:17 * kScale];
    }
    return _rateLb;
}

@end
