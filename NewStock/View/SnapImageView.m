//
//  SnapImageView.m
//  test2
//
//  Created by 王迪 on 2016/12/4.
//  Copyright © 2016年 JiaBei. All rights reserved.
//

#import "SnapImageView.h"
#import <Masonry.h>
#import "UIImage+SnapWindow.h"
#import "UIImage+ImageEffects.h"
#import <UMengSocialCOM/UMSocial.h>
#import "SystemUtil.h"
#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface SnapImageView (){
    UIButton *_btn1;
    UIButton *_btn2;
    UIButton *_btn3;
    UIButton *_btn4;
    UIButton *_btn5;
    UIButton *_btn6;
}

@end

@implementation SnapImageView


- (instancetype)init {
   
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.image = [[UIImage snapTheCurrentWindow] applyLightEffect];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    [self addComposeBtn];
    
}

- (void)tap {
    [self dismissAnimation];
}

- (void)addComposeBtn {
    
    CGFloat margin = (MAIN_SCREEN_WIDTH - 3 * 80) / 4;
    
    _btn1 = [[UIButton alloc]init];
    _btn1.tag = 1;
    [_btn1 setImage:[UIImage imageNamed:@"ic_weixin_nor"] forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_btn1 setTitle:@"微信好友" forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    _btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    _btn1.titleEdgeInsets = UIEdgeInsetsMake(31, -60, -31, 0);
    _btn1.imageEdgeInsets = UIEdgeInsetsMake(-11, 0, 11, 0);
    [self addSubview:_btn1];
    _btn1.frame = CGRectMake(margin + 10, MAIN_SCREEN_HEIGHT, 60, 84);
    [_btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn2 = [[UIButton alloc]init];
    _btn2.tag = 2;
    [_btn2 setImage:[UIImage imageNamed:@"ic_quan_nor"] forState:UIControlStateNormal];
    [_btn2 setTitle:@"朋友圈" forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    _btn2.titleEdgeInsets = UIEdgeInsetsMake(31, -60, -31, 0);
    _btn2.imageEdgeInsets = UIEdgeInsetsMake(-11, 0, 11, 0);
    [self addSubview:_btn2];
    _btn2.frame = CGRectMake(margin * 2 + 80 + 10, MAIN_SCREEN_HEIGHT, 60, 84);
    [_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn3 = [[UIButton alloc]init];
    _btn3.tag = 3;
    [_btn3 setImage:[UIImage imageNamed:@"ic_weibo_nor"] forState:UIControlStateNormal];
    [self addSubview:_btn3];
    [_btn3 setTitle:@" 微博 " forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    _btn3.titleEdgeInsets = UIEdgeInsetsMake(31, -60, -31, 0);
    _btn3.imageEdgeInsets = UIEdgeInsetsMake(-11, 0, 11, 0);
    _btn3.frame = CGRectMake(margin * 3 + 80 * 2 + 10, MAIN_SCREEN_HEIGHT, 60, 84);
    [_btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn4 = [[UIButton alloc]init];
    _btn4.tag = 4;
    [_btn4 setImage:[UIImage imageNamed:@"ic_qq_nor"] forState:UIControlStateNormal];
    [_btn4 setTitle:@"QQ好友" forState:UIControlStateNormal];
    _btn4.titleLabel.font = [UIFont systemFontOfSize:12];
    _btn4.titleEdgeInsets = UIEdgeInsetsMake(31, -60, -31, 0);
    _btn4.imageEdgeInsets = UIEdgeInsetsMake(-11, 0, 11, 0);
    [_btn4 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:_btn4];
    _btn4.frame = CGRectMake(margin + 10, MAIN_SCREEN_HEIGHT + 100, 60, 84);
    [_btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btn5 = [[UIButton alloc]init];
    _btn5.tag = 6;
    [_btn5 setImage:[UIImage imageNamed:@"ic_lianjie_nor"] forState:UIControlStateNormal];
    [_btn5 setTitle:@"复制链接" forState:UIControlStateNormal];
    [_btn5 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _btn5.titleLabel.font = [UIFont systemFontOfSize:12];
    _btn5.titleEdgeInsets = UIEdgeInsetsMake(31, -60, -31, 0);
    _btn5.imageEdgeInsets = UIEdgeInsetsMake(-11, 0, 11, 0);
    [self addSubview:_btn5];
    _btn5.frame = CGRectMake(margin * 2 + 80 + 10, MAIN_SCREEN_HEIGHT + 100, 60, 84);
    [_btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btn6 = [[UIButton alloc]init];
    _btn6.tag = 5;
    [_btn6 setImage:[UIImage imageNamed:@"ic_qqkongjian_nor"] forState:UIControlStateNormal];
    [_btn6 setTitle:@"QQ空间" forState:UIControlStateNormal];
    [_btn6 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _btn6.titleLabel.font = [UIFont systemFontOfSize:12];
    _btn6.titleEdgeInsets = UIEdgeInsetsMake(31, -60, -31, 0);
    _btn6.imageEdgeInsets = UIEdgeInsetsMake(-11, 0, 11, 0);
    [self addSubview:_btn6];
    _btn6.frame = CGRectMake(margin * 3 + 80 * 2 + 10, MAIN_SCREEN_HEIGHT + 100, 60, 84);
    [_btn6 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startBtnAnimation {
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:30 initialSpringVelocity:20 options:0 animations:^{
            CGRect frame = _btn1.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT * 0.5 - 40;
            _btn1.frame = frame;
        } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:30 initialSpringVelocity:20 options:0 animations:^{
            CGRect frame = _btn2.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT * 0.5 - 40;
            _btn2.frame = frame;
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:30 initialSpringVelocity:20 options:0 animations:^{
            CGRect frame = _btn3.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT * 0.5 - 40;
            _btn3.frame = frame;
        } completion:nil];
    });
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:30 initialSpringVelocity:20 options:0 animations:^{
            CGRect frame = _btn4.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT * 0.5 + 100;
            _btn4.frame = frame;
        } completion:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:30 initialSpringVelocity:20 options:0 animations:^{
            CGRect frame = _btn5.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT * 0.5 + 100;
            _btn5.frame = frame;
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:30 initialSpringVelocity:20 options:0 animations:^{
            CGRect frame = _btn6.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT * 0.5 + 100;
            _btn6.frame = frame;
        } completion:nil];
    });
}

- (void)dismissAnimation {

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:5 initialSpringVelocity:5 options:0 animations:^{
            CGRect frame = _btn6.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT ;
            _btn6.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:5 initialSpringVelocity:5 options:0 animations:^{
            CGRect frame = _btn5.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT ;
            _btn5.frame = frame;
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:5 initialSpringVelocity:5 options:0 animations:^{
            CGRect frame = _btn4.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT ;
            _btn4.frame = frame;
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:5 initialSpringVelocity:5 options:0 animations:^{
            CGRect frame = _btn3.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT;
            _btn3.frame = frame;
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:5 initialSpringVelocity:5 options:0 animations:^{
            CGRect frame = _btn2.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT + 100;
            _btn2.frame = frame;
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:5 initialSpringVelocity:5 options:0 animations:^{
            CGRect frame = _btn1.frame;
            frame.origin.y = MAIN_SCREEN_HEIGHT + 100;
            _btn1.frame = frame;
        } completion:nil];
    });
    
}

- (void)btnClick:(UIButton *)btn {
    if (_btnBlock) {
        _btnBlock(btn.tag);
        [self dismissAnimation];
    }
}

- (void)fuzhiBtnClickWithUrl:(NSString *)url {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (url.length) {
        pasteboard.string = url;
    }else {
        pasteboard.string = @"http://www.guguaixia.com";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"复制成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alertView show];
    [self dismissAnimation];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
}



@end
