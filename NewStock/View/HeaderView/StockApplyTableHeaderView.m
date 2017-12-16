//
//  StockApplyTableHeaderView.m
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "StockApplyTableHeaderView.h"
#import "Defination.h"
#import <Masonry.h>

@interface StockApplyTableHeaderView ()

@property (nonatomic, strong) UILabel *lb_tm;
@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_code;
@property (nonatomic, strong) UILabel *lb_pr;
@property (nonatomic, strong) UILabel *lb_pe;
@property (nonatomic, strong) UILabel *lb_mx;
@property (nonatomic, strong) UILabel *todayLb;

@property (nonatomic, strong) UIButton *applyBtn;

@end

@implementation StockApplyTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = kUIColorFromRGB(0xffffff);
    
    [self addSubview:topView];
    [self addSubview:bottomView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(32 * kScale));
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(topView.mas_bottom);
    }];
    
    [topView addSubview:self.lb_tm];
    [topView addSubview:self.applyBtn];
    [topView addSubview:self.todayLb];
    
    [self.todayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).offset(12);
        make.width.equalTo(@(36 * kScale));
        make.height.equalTo(@(16 * kScale));
    }];
    
    [self.lb_tm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.todayLb.mas_right).offset(5 * kScale);
        make.centerY.equalTo(topView);
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12 * kScale);
        make.centerY.equalTo(topView);
        make.width.equalTo(@(60 * kScale));
        make.height.equalTo(@(18 * kScale));
    }];
    
    [bottomView addSubview:self.lb_name];
    [bottomView addSubview:self.lb_code];
    [bottomView addSubview:self.lb_pr];
    [bottomView addSubview:self.lb_pe];
    [bottomView addSubview:self.lb_mx];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12 * kScale);
        make.bottom.equalTo(bottomView.mas_centerY).offset(-2);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_name);
        make.top.equalTo(bottomView.mas_centerY).offset(2);
    }];
    
    [self.lb_pr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lb_name);
        make.right.equalTo(self.mas_centerX).offset(10);
    }];
    
    [self.lb_pe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_code);
        make.right.equalTo(self.lb_pr);
    }];
    
    [self.lb_mx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12 * kScale);
        make.centerY.equalTo(bottomView);
    }];
    
//    UILabel *line = [UILabel new];
//    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
//    [bottomView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(12 * kScale);
//        make.right.equalTo(self).offset(-12 * kScale);
//        make.height.equalTo(@(0.5));
//        make.bottom.equalTo(bottomView);
//    }];
    
}

#pragma makr action

- (void)setModel:(StockApplyModel *)model {
    _model = model;
    
    if ([self isToday:_model.tm]) {
        
        self.applyBtn.hidden = NO;
        self.lb_tm.text = [NSString stringWithFormat:@"可申购 %zd支",model.count.integerValue];
        [self.todayLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(36 * kScale));
        }];
    } else {
        
        self.applyBtn.hidden = YES;
        self.lb_tm.text = [NSString stringWithFormat:@"%@ %@ %zd支",model.tm,model.wk,model.count.integerValue];
        [self.todayLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(0 * kScale));
        }];
    }
    

}

- (BOOL)isToday:(NSString *)tm {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateTm = [formatter stringFromDate:[NSDate date]];
    if ([dateTm isEqualToString:tm]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)applyBtnClick:(UIButton *)bnt {
    if ([self.delegate respondsToSelector:@selector(stockApplyTableHeaderViewClick)]) {
        [self.delegate stockApplyTableHeaderViewClick];
    }
}

#pragma mark lazyloading

- (UILabel *)lb_tm {
    if (_lb_tm == nil) {
        _lb_tm = [UILabel new];
        _lb_tm.textColor = kUIColorFromRGB(0x666666);
        _lb_tm.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _lb_tm;
}

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.textColor = kUIColorFromRGB(0x838383);
        _lb_name.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_name.text = @"名称";
    }
    return _lb_name;
}

- (UILabel *)lb_code {
    if (_lb_code == nil) {
        _lb_code = [UILabel new];
        _lb_code.text = @"代码";
        _lb_code.textColor = kUIColorFromRGB(0x838383);
        _lb_code.font = [UIFont systemFontOfSize:12 * kScale];
    }
    return _lb_code;
}

- (UILabel *)lb_pr {
    if (_lb_pr == nil) {
        _lb_pr = [UILabel new];
        _lb_pr.textColor = kUIColorFromRGB(0x838383);
        _lb_pr.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_pr.text = @"发行价";
    }
    return _lb_pr;
}

- (UILabel *)lb_pe {
    if (_lb_pe == nil) {
        _lb_pe = [UILabel new];
        _lb_pe.textColor = kUIColorFromRGB(0x838383);
        _lb_pe.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_pe.text = @"市盈率";
    }
    return _lb_pe;
}

- (UILabel *)lb_mx {
    if (_lb_mx == nil) {
        _lb_mx = [UILabel new];
        _lb_mx.text = @"申购上限";
        _lb_mx.font = [UIFont systemFontOfSize:12 * kScale];
        _lb_mx.textColor = kUIColorFromRGB(0x838383);
    }
    return _lb_mx;
}

- (UIButton *)applyBtn {
    if (_applyBtn == nil) {
        _applyBtn = [UIButton new];
        [_applyBtn setTitle:@"一键申购" forState:UIControlStateNormal];
        [_applyBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [_applyBtn setBackgroundColor:kButtonBGColor];
        _applyBtn.titleLabel.font = [UIFont systemFontOfSize:11 * kScale];
        _applyBtn.layer.cornerRadius = 9 * kScale;
        _applyBtn.layer.masksToBounds = YES;
        [_applyBtn addTarget:self action:@selector(applyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
}

- (UILabel *)todayLb {
    if (_todayLb == nil) {
        _todayLb = [UILabel new];
        _todayLb.backgroundColor = kUIColorFromRGB(0xff1919);
        _todayLb.text = @"今日";
        _todayLb.textColor = kUIColorFromRGB(0xffffff);
        _todayLb.font = [UIFont systemFontOfSize:12 * kScale];
        _todayLb.textAlignment = NSTextAlignmentCenter;
        _todayLb.layer.cornerRadius = 2;
        _todayLb.layer.masksToBounds = YES;
    }
    return _todayLb;
}

@end
