//
//  LoginViewController.m
//  NewStock
//
//  Created by Willey on 16/7/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "BindPhoneNumController.h"
#import "UserInfoInstance.h"
#import "UserInfoModel.h"
#import "MarketConfig.h"
#import "NoCopyTextField.h"
#import "StockHistoryUtil.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialAccountManager.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *headerImg ;

@end

@implementation LoginViewController

- (UIImageView *)headerImg {
    if (_headerImg == nil) {
        _headerImg = [[UIImageView alloc] init];
        _headerImg.image = [UIImage imageNamed:@"bg_logo_sign-in"];
    }
    return _headerImg;
}

- (UIButton *)visitorBtn {
    if (_visitorBtn == nil) {
        _visitorBtn = [[UIButton alloc] init];
        [_visitorBtn setImage:[UIImage imageNamed:@"login_close_nor"] forState:UIControlStateNormal];
        [_visitorBtn addTarget:self action:@selector(dismissCurrentView) forControlEvents:UIControlEventTouchUpInside];
        _visitorBtn.hidden = YES;
    }
    return _visitorBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
//    [_navBar setTitle:self.title];
    _navBar.line_view.hidden = YES;
    [self setRightBtnImg:nil];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(-20, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    _scrollView.scrollEnabled = NO;
    _mainView.backgroundColor = [SystemUtil hexStringToColor:@"#f8f8f8"];
    
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
    gensture.delegate = self;
    [_mainView addGestureRecognizer:gensture];
    
    [_mainView addSubview:self.headerImg];
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_mainView);
        make.height.equalTo(@(240 * kScale));
    }];

    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, (240 + 19) * kScale, _nMainViewWidth - 60, 40 * kScale)];
    _usernameTextField.delegate = self;
    _usernameTextField.backgroundColor = [UIColor clearColor];
    _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _usernameTextField.textColor = [SystemUtil hexStringToColor:@"#383838"];
    _usernameTextField.placeholder = @"请输入您当前绑定的手机号";
    [_usernameTextField.placeholder drawInRect:CGRectMake(20, 10, 80, 20) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    _usernameTextField.textColor = [UIColor blackColor];
    _usernameTextField.font = [UIFont systemFontOfSize:16];
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameTextField.returnKeyType = UIReturnKeyNext;
    _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameTextField.tag = 201;

    [_mainView addSubview:_usernameTextField];
    _usernameTextField.text = [SystemUtil getCache:INPUT_USER_NAME];
    [_usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(30, _usernameTextField.frame.origin.y+_usernameTextField.frame.size.height, _nMainViewWidth-60, 0.5)];
    line1.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line1];
    
    // password for sign in text field NoCopyTextField
    _passwordTextField = [[NoCopyTextField alloc]initWithFrame:CGRectMake(_usernameTextField.frame.origin.x, _usernameTextField.frame.origin.y + _usernameTextField.frame.size.height + 10 * kScale, _usernameTextField.frame.size.width, _usernameTextField.frame.size.height)];
    _passwordTextField.delegate = self;
    _passwordTextField.backgroundColor = [UIColor clearColor];
    _passwordTextField.placeholder = @"请输入您的密码";
    [_passwordTextField.placeholder drawInRect:CGRectMake(20, 10, 80, 20) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    _passwordTextField.textColor = [UIColor blackColor];
    _passwordTextField.font = [UIFont systemFontOfSize:16];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.returnKeyType = UIReturnKeyGo;
    _passwordTextField.tag = 202;
    [_mainView addSubview:_passwordTextField];

    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(30, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height, _nMainViewWidth-60, 0.5)];
    line2.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line2];
    
    // login in button
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(30, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height + 50 * kScale, 140 * kScale, _passwordTextField.frame.size.height);

    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = kButtonBGColor;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;
    [_mainView addSubview:loginButton];
    
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    registButton.frame = CGRectMake(30, loginButton.frame.origin.y + loginButton.frame.size.height + 15 * kScale, MAIN_SCREEN_WIDTH - 60, _passwordTextField.frame.size.height);
    [registButton addTarget:self action:@selector(registButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:kTitleColor forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:16];
    registButton.backgroundColor = [UIColor whiteColor];
    registButton.layer.cornerRadius = 5;
    registButton.layer.masksToBounds = YES;
    registButton.layer.borderColor = kButtonBGColor.CGColor;
    registButton.layer.borderWidth = 0.5;
    [_mainView addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_mainView).offset(-30);
        make.top.equalTo(loginButton);
        make.width.height.equalTo(loginButton);
    }];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.frame = CGRectMake(_nMainViewWidth-30-70, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height + 15 * kScale, 70, 25);
    [forgetButton addTarget:self action:@selector(forgetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    forgetButton.tintColor = [SystemUtil hexStringToColor:@"#383838"];
    [forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetButton setTitleColor:kTitleColor forState:UIControlStateNormal];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:13];
    forgetButton.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, -7);
    [_mainView addSubview:forgetButton];
    
    
    UILabel *thirdLb = [[UILabel alloc] init];
    thirdLb.textColor = kUIColorFromRGB(0x666666);
    thirdLb.text = @"第三方账号登录";
    thirdLb.font = [UIFont systemFontOfSize:12];
    thirdLb.textAlignment = NSTextAlignmentCenter;
    thirdLb.backgroundColor = [UIColor clearColor];
    [_mainView addSubview:thirdLb];
    [thirdLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_mainView).offset(-108 * kScale);
        make.centerX.equalTo(_mainView);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [_mainView addSubview:line];
    [line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(thirdLb);
        make.left.equalTo(_mainView).offset(30);
        make.right.equalTo(thirdLb.mas_left).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *line22 = [[UIView alloc] init];
    line22.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [_mainView addSubview:line22];
    [line22 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(thirdLb);
        make.left.equalTo(thirdLb.mas_right).offset(0);
        make.right.equalTo(_mainView).offset(-30);
        make.height.mas_equalTo(0.5);
    }];

    
    int nBtnWidth = 40;
    int padding = (_nMainViewWidth-nBtnWidth*3)/4;
    UIButton *shareWeiXinBtn = [[UIButton alloc] init];
    UIImage *img = [UIImage imageNamed:@"share_weixin"];
    [shareWeiXinBtn setBackgroundImage:[UIImage imageNamed:@"share_weixin"] forState:UIControlStateNormal];
    //[shareWeiXinBtn setTitle:@"微信" forState:UIControlStateNormal];
    shareWeiXinBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareWeiXinBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 40, 10)];
    [shareWeiXinBtn setTitleEdgeInsets:UIEdgeInsetsMake(40, -img.size.width, 0, 0)];
    shareWeiXinBtn.tag = 0;
    [shareWeiXinBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:shareWeiXinBtn];
    [shareWeiXinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(25);
        make.left.equalTo(_mainView).offset(padding);
        make.width.mas_equalTo(nBtnWidth);
        make.height.mas_equalTo(nBtnWidth);
    }];
    
    UIButton *shareQQBtn = [[UIButton alloc] init];
    UIImage *img1 = [UIImage imageNamed:@"share_qq"];
    [shareQQBtn setBackgroundImage:[UIImage imageNamed:@"share_qq"] forState:UIControlStateNormal];
    //[shareQQBtn setTitle:@"QQ" forState:UIControlStateNormal];
    shareQQBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareQQBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 40, 10)];
    [shareQQBtn setTitleEdgeInsets:UIEdgeInsetsMake(40, -img1.size.width, 0, 0)];
    shareQQBtn.tag = 1;
    [shareQQBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:shareQQBtn];
    [shareQQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(25);
        make.left.equalTo(shareWeiXinBtn.mas_right).offset(padding);
        make.width.mas_equalTo(nBtnWidth);
        make.height.mas_equalTo(nBtnWidth);
    }];
    
    
    UIButton *shareWeiboBtn = [[UIButton alloc] init];
    UIImage *img2 = [UIImage imageNamed:@"share_weibo"];
    [shareWeiboBtn setBackgroundImage:[UIImage imageNamed:@"share_weibo"] forState:UIControlStateNormal];
    //[shareWeiboBtn setTitle:@"微博" forState:UIControlStateNormal];
    shareWeiboBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareWeiboBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 40, 10)];
    [shareWeiboBtn setTitleEdgeInsets:UIEdgeInsetsMake(40, -img2.size.width, 0, 0)];
    shareWeiboBtn.tag = 2;
    [shareWeiboBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:shareWeiboBtn];
    [shareWeiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(25);
        make.left.equalTo(shareQQBtn.mas_right).offset(padding);
        make.width.mas_equalTo(nBtnWidth);
        make.height.mas_equalTo(nBtnWidth);
    }];
    
    [_mainView addSubview:self.visitorBtn];
    [self.visitorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_mainView).offset(-20);
        make.bottom.equalTo(_mainView).offset(-30);
    }];
    
    
    _loginAPI = [[LoginAPI alloc] init];
    _loginAPI.animatingView = _mainView;
    _loginAPI.animatingText = @"登录中";
    _loginAPI.delegate = self;
    
    _phoneCheckAPI = [[PhoneCheckAPI alloc] init];
    _thirdLoginAPI = [[ThirdLoginAPI alloc] init];
    
    
    _progressHUD = [[MBProgressHUD alloc] initWithView:_mainView];
    [_mainView addSubview:_progressHUD];
//    [_progressHUD hideAnimated:YES];
    [_progressHUD hide:YES];

    _mainView.backgroundColor = kUIColorFromRGB(0xffffff);
    _navBar.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:_navBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)scrollViewTapAction {
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == _usernameTextField)
    {
        if (textField.text.length > 11)
        {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 201)
    {
        [_passwordTextField becomeFirstResponder];
    }
    if (textField.tag == 202)
    {
        [self performSelector:@selector(loginButtonClicked)];
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)loginButtonClicked {
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    
    if (! _usernameTextField.text || [_usernameTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if([_usernameTextField.text length] != 11)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的用户名!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        if (! _passwordTextField.text || [_passwordTextField.text isEqualToString:@""])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            [SystemUtil putCache:INPUT_USER_NAME value:_usernameTextField.text];
            
            _loginAPI.userName = _usernameTextField.text;
            
            NSString *password = _passwordTextField.text;
            NSString *aesPwd = [SystemUtil getAESPw:password];
            _loginAPI.pwd = aesPwd;
            [_loginAPI start];
        }
    }
}

- (void)forgetButtonClicked {
    
    [self scrollViewTapAction];
    
    ForgetViewController *forgetViewController = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:forgetViewController animated:YES];
}
- (void)registButtonClicked {
    [self scrollViewTapAction];
    
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    [StockHistoryUtil getMyStockFromServer];
    
    UserInfoModel *model = [MTLJSONAdapter modelOfClass:[UserInfoModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    [UserInfoInstance sharedUserInfoInstance].userInfoModel = model;
    
    NSLog(@"user info model:%@",model);
    [SystemUtil putCache:USER_NAME value:_usernameTextField.text];
    [SystemUtil putCache:INPUT_USER_NAME value:_usernameTextField.text];

    [SystemUtil putCache:USER_PW value:_passwordTextField.text];
    [SystemUtil putCache:USER_ID value:model.userId];

    [SystemUtil saveCookie];
    [SystemUtil setCookie];
    if (self.visitorBtn.hidden == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
    
    if ([SystemUtil isNotNSnull:request.responseJSONObject]) {
        NSString *msg = [request.responseJSONObject objectForKey:@"msg"];
        if ([SystemUtil isNotNSnull:msg]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}

#pragma mark - Button Actions
- (void)btnAction:(UIButton*)sender {
//    [_progressHUD hideAnimated:YES];
    [_progressHUD hide:YES];

    NSString *typeStr;
    if (sender.tag == 0)
    {
        typeStr = UMShareToWechatSession;
    }
    else if(sender.tag == 1)
    {
        typeStr = UMShareToQQ;
    }
    else
    {
        typeStr = UMShareToSina;
    }
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:typeStr];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"%@",response.message);
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            //NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            _phoneCheckAPI.suid = snsAccount.usid;
            if ([snsAccount.platformName isEqualToString:UMShareToSina])
            {
                _phoneCheckAPI.sr = @"sina";
            }
            else if([snsAccount.platformName isEqualToString:UMShareToQQ])
            {
                _phoneCheckAPI.sr = @"qq";
            }
            else
            {
                _phoneCheckAPI.sr = @"wxsession";
            }
            [_phoneCheckAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                NSString *st = [request.responseJSONObject objectForKey:@"st"];
                NSLog(@"st=%@",st);
                if ([st isEqualToString:@"false"]) {
                    
//                    [_progressHUD hideAnimated:YES];
                    [_progressHUD hide:YES];

                    BindPhoneNumController *ViewController = [[BindPhoneNumController alloc] init];
                    ViewController.suid = snsAccount.usid;
                    ViewController.sr = _phoneCheckAPI.sr;
                    ViewController.n = snsAccount.userName;
                    ViewController.img = snsAccount.iconURL;
                    [self.navigationController pushViewController:ViewController animated:YES];
                    
                    
                }
                else{
                    
                    _thirdLoginAPI.suid = snsAccount.usid;//@"1691229363";
                    _thirdLoginAPI.sr = _phoneCheckAPI.sr;//@"sina";
                    //_thirdLoginAPI.ph = @"15821426502";
                    _thirdLoginAPI.n = snsAccount.userName;//@"test2016";
                    _thirdLoginAPI.img = snsAccount.iconURL;
                    [_thirdLoginAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                        NSLog(@"%@",request.responseJSONObject);
//                        [_progressHUD hideAnimated:YES];
                        [_progressHUD hide:YES];

                        [StockHistoryUtil getMyStockFromServer];
                        
                        UserInfoModel *model = [MTLJSONAdapter modelOfClass:[UserInfoModel class] fromJSONDictionary:request.responseJSONObject error:nil];
                        [UserInfoInstance sharedUserInfoInstance].userInfoModel = model;
                        
                        NSLog(@"user info model:%@",model);
                        [SystemUtil putCache:USER_NAME value:model.ph];
//                        [SystemUtil putCache:INPUT_USER_NAME value:model.ph];

                        [SystemUtil putCache:USER_PW value:@""];
                        [SystemUtil putCache:USER_ID value:model.userId];
                        
                        [SystemUtil saveCookie];
                        [SystemUtil setCookie];
                        if (self.visitorBtn.hidden == YES) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }else {
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                        
                    } failure:^(APIBaseRequest *request) {
                        NSLog(@"failed");
                        
//                        [_progressHUD hideAnimated:YES];
                        [_progressHUD hide:YES];
                    }];
                    
                }
                
                
            } failure:^(APIBaseRequest *request) {
                NSLog(@"failed:%@",request.responseJSONObject);
                
//                [_progressHUD hideAnimated:YES];
                [_progressHUD hide:YES];
            }];
            
        }
        else
        {
//            [_progressHUD hideAnimated:YES];
            [_progressHUD hide:YES];
 
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"授权登录失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    
    });
  
}

- (void)dismissCurrentView {

    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
