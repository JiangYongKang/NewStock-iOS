//
//  QingHuaiTimeView.m
//  NewStock
//
//  Created by 王迪 on 2017/1/11.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "QingHuaiTimeView.h"
#import <Masonry.h>
#import "Defination.h"

@interface QingHuaiTimeView ()

@property (nonatomic, strong) UILabel *lb_day;

@property (nonatomic, strong) UILabel *lb_mon;

@end

@implementation QingHuaiTimeView

- (UILabel *)lb_day {
    if (_lb_day == nil) {
        _lb_day = [[UILabel alloc] init];
        _lb_day.font = [UIFont boldSystemFontOfSize:24];
        _lb_day.textColor = [UIColor whiteColor];
        _lb_day.text = @"--";
    }
    return _lb_day;
}

- (UILabel *)lb_mon {
    if (_lb_mon == nil) {
        _lb_mon = [[UILabel alloc] init];
        _lb_mon.font = [UIFont systemFontOfSize:11];
        _lb_mon.alpha = 0.7;
        _lb_mon.textColor = [UIColor whiteColor];
        _lb_mon.numberOfLines = 2;
        _lb_mon.text = @"--";
    }
    return _lb_mon;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setDay:(NSString *)day month:(NSString *)month week:(NSString *)week {

    self.lb_day.text = day;
    self.lb_mon.text = [NSString stringWithFormat:@"%@月\n%@",month,week];
}

- (void)setupUI {
    [self addSubview:self.lb_mon];
    [self addSubview:self.lb_day];
    
    [self.lb_day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [self.lb_mon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.lb_day.mas_right).offset(5);
    }];
}

@end
