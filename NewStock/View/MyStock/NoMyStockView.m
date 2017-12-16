//
//  NoMyStockView.m
//  NewStock
//
//  Created by Willey on 16/9/27.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "NoMyStockView.h"
#import "Masonry.h"
#import "Defination.h"

@implementation NoMyStockView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 102, 85)];
        _btn.center = CGPointMake(MAIN_SCREEN_WIDTH/2, (MAIN_SCREEN_HEIGHT-180)/2);
        [_btn setImage:[UIImage imageNamed:@"no_myStock"] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
        
        _tipsLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 40)];
        _tipsLb.center = CGPointMake(MAIN_SCREEN_WIDTH/2, (MAIN_SCREEN_HEIGHT-180)/2+80);
        _tipsLb.backgroundColor = [UIColor clearColor];
        _tipsLb.textAlignment = NSTextAlignmentCenter;
        _tipsLb.textColor = kUIColorFromRGB(0x999999);
        _tipsLb.font = [UIFont systemFontOfSize:16];
        _tipsLb.text = @"你还没有添加股票哦，赶快去寻找一支牛股吧~";
        _tipsLb.numberOfLines = 2;
        [self addSubview:_tipsLb];
    }
    return self;
}

- (void)setType:(NO_RECORD_TYPE)type {
    if (type == NO_RECORD_TYPE_STOCK) {
        _btn.frame = CGRectMake(0, 0, 102, 85);
        _btn.center = CGPointMake(MAIN_SCREEN_WIDTH/2, (MAIN_SCREEN_HEIGHT-180)/2);
        [_btn setImage:[UIImage imageNamed:@"no_myStock"] forState:UIControlStateNormal];
        
        _tipsLb.text = @"你还没有添加股票哦，赶快去寻找一支牛股吧~";
    } else if(type == NO_RECORD_TYPE_NEWS) {
        _btn.frame = CGRectMake(0, 0, 74, 74);
        _btn.center = CGPointMake(MAIN_SCREEN_WIDTH/2, (MAIN_SCREEN_HEIGHT-180)/2);
        [_btn setImage:[UIImage imageNamed:@"empty_icon"] forState:UIControlStateNormal];
        
        _tipsLb.text = @"记得抽点时间看资讯哦~";
    }else {
        _btn.frame = CGRectMake(0, 0, 74, 74);
        _btn.center = CGPointMake(MAIN_SCREEN_WIDTH/2, (MAIN_SCREEN_HEIGHT-180)/2);
        [_btn setImage:[UIImage imageNamed:@"empty_icon"] forState:UIControlStateNormal];
        _tipsLb.text = @"暂无持仓记录,请手动添加~";
    }
}

#pragma mark - Button Actions
- (void)btnAction:(UIButton*)sender {
    if([delegate respondsToSelector:@selector(noMyStockView:)]) {
        [delegate noMyStockView:self];
    }
}



@end
