//
//  MomentNewsBottomStockView.m
//  NewStock
//
//  Created by 王迪 on 2017/5/25.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentNewsBottomStockView.h"
#import "Defination.h"
#import "MarketConfig.h"
#import <Masonry.h>

@interface MomentNewsBottomStockView ()

@property (nonatomic, strong) UILabel *name_lb;
@property (nonatomic, strong) UILabel *rate_lb;

@end

@implementation MomentNewsBottomStockView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.name_lb];
    [self addSubview:self.rate_lb];
    
    [self.name_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self);
        make.width.equalTo(@(86 * kScale));
    }];
    
    [self.rate_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(_name_lb.mas_right);
    }];
}

- (void)setStock:(MomentNewsAnalysisStockModel *)stock {
    _stock = stock;
    self.name_lb.text = stock.n;
}

- (void)setRate:(NSString *)zdf {
    self.rate_lb.text = [NSString stringWithFormat:@"%.2lf%%",zdf.floatValue];
    UIColor *color = kUIColorFromRGB(0xb2b2b2);
    if (zdf.floatValue > 0) {
        color = RISE_COLOR;
    } else if (zdf.floatValue < 0) {
        color = FALL_COLOR;
    }
    self.layer.borderColor = color.CGColor;
    self.rate_lb.backgroundColor = color;
}

- (void)tap {
    if ([self.delegate respondsToSelector:@selector(MomentNewsBottomStockViewDelegate:)]) {
        [self.delegate MomentNewsBottomStockViewDelegate:_stock];
    }
}

- (UILabel *)name_lb {
    if (_name_lb == nil) {
        _name_lb = [UILabel new];
        _name_lb.textColor = kUIColorFromRGB(0x333333);
        _name_lb.font = [UIFont systemFontOfSize:12 * kScale];
        _name_lb.textAlignment = NSTextAlignmentCenter;
        _name_lb.backgroundColor = [UIColor clearColor];
    }
    return _name_lb;
}

- (UILabel *)rate_lb {
    if (_rate_lb == nil) {
        _rate_lb = [UILabel new];
        _rate_lb.textColor = kUIColorFromRGB(0xffffff);
        _rate_lb.textAlignment = NSTextAlignmentCenter;
        _rate_lb.font = [UIFont boldSystemFontOfSize:12 * kScale];
        _rate_lb.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    }
    return _rate_lb;
}

@end
