//
//  FirstLoginViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/1/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "FirstLoginViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Defination.h"
#import "MarketConfig.h"

@interface FirstLoginViewController ()

@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation FirstLoginViewController

- (UIButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"login_close_nor"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismissCurrentView) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = NO;
    }
    return _closeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_sign-in"]];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = kButtonBGColor;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;
    [self.view addSubview:loginButton];
    loginButton.alpha = 0.7;
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(150 * kScale));
        make.height.equalTo(@(44 * kScale));
        make.left.equalTo(self.view).offset((30 * kScale));
        make.bottom.equalTo(self.view).offset( - 85);
    }];
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registButton addTarget:self action:@selector(registButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:kTitleColor forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:16];
    registButton.backgroundColor = [UIColor whiteColor];
    registButton.layer.cornerRadius = 5;
    registButton.layer.masksToBounds = YES;
    registButton.layer.borderColor = kUIColorFromRGB(0x358ee7).CGColor;
    registButton.layer.borderWidth = 0.5;
    [self.view addSubview:registButton];
    registButton.alpha = 0.8;
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(150 * kScale));
        make.height.equalTo(@(44 * kScale));
        make.right.equalTo(self.view).offset(- (30 * kScale));
        make.bottom.equalTo(self.view).offset( - 85);
    }];
    
    [self.view addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.top.equalTo(self.view).offset(64);
    }];
    [self.view bringSubviewToFront:self.closeBtn];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([SystemUtil isSignIn]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)loginButtonClicked {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.visitorBtn.hidden = NO;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)registButtonClicked {
    RegisterViewController *registVC = [RegisterViewController new];
    [self.navigationController pushViewController:registVC animated:YES];
}

- (void)dismissCurrentView {
    [self dismissViewControllerAnimated:YES completion:nil];
}







@end
