//
//  RevisePhViewController.m
//  NewStock
//
//  Created by Willey on 16/9/6.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RevisePhViewController.h"
#import "PersonalCenterViewController.h"
#import "MarketConfig.h"

@implementation RevisePhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改手机号码";
    [_navBar setTitle:self.title];
    _navBar.line_view.hidden = YES;
    
    [self setRightBtnImg:nil];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    
    _mainView.backgroundColor = [SystemUtil hexStringToColor:@"#ffffff"];
    
    UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
    gensture.delegate = self;
    [_mainView addGestureRecognizer:gensture];
    
    
    _tipsLb1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 20, _nMainViewWidth-50, 40)];
    _tipsLb1.backgroundColor = [UIColor clearColor];
    _tipsLb1.font = [UIFont systemFontOfSize:12];
    _tipsLb1.textColor = kUIColorFromRGB(0x808080);
    _tipsLb1.textAlignment = NSTextAlignmentLeft;
    _tipsLb1.text = @"";
    _tipsLb1.numberOfLines = 0;
    [_mainView addSubview:_tipsLb1];
    
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(_tipsLb1.frame.origin.x, _tipsLb1.frame.origin.y+_tipsLb1.frame.size.height+20, _tipsLb1.frame.size.width, _tipsLb1.frame.size.height)];
    _usernameTextField.delegate = self;
    _usernameTextField.backgroundColor = [UIColor clearColor];
    _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _usernameTextField.textColor = [SystemUtil hexStringToColor:@"#383838"];
    _usernameTextField.placeholder = @"请输入您的旧手机号码";
    _usernameTextField.textColor = [UIColor blackColor];
    _usernameTextField.font = [UIFont systemFontOfSize:15];
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameTextField.returnKeyType = UIReturnKeyNext;
    _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameTextField.tag = 201;

    [_mainView addSubview:_usernameTextField];
    
    [_usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
   
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(25, _usernameTextField.frame.origin.y+_usernameTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line1.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line1];

    
    
    _getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getVerifyCodeButton.frame = CGRectMake(MAIN_SCREEN_WIDTH-105, _usernameTextField.frame.origin.y+5, 80, 30);

    [_getVerifyCodeButton addTarget:self action:@selector(verityBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getVerifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getVerifyCodeButton.backgroundColor = kButtonBGColor;
    _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _getVerifyCodeButton.layer.cornerRadius = 5;
    _getVerifyCodeButton.layer.masksToBounds = YES;
    _getVerifyCodeButton.tag = 1001;
    [_scrollView addSubview:_getVerifyCodeButton];
    
    //
    _verifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(_usernameTextField.frame.origin.x, _usernameTextField.frame.origin.y+_usernameTextField.frame.size.height+10, _usernameTextField.frame.size.width, _usernameTextField.frame.size.height)];
    _verifyCodeTextField.delegate = self;
    _verifyCodeTextField.backgroundColor = [UIColor clearColor];
    _verifyCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _verifyCodeTextField.placeholder = @"请输入您收到的验证码";
    _verifyCodeTextField.textColor = [UIColor blackColor];
    _verifyCodeTextField.font = [UIFont systemFontOfSize:15];
    _verifyCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verifyCodeTextField.returnKeyType = UIReturnKeyNext;
    
    _verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _verifyCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _verifyCodeTextField.tag = 202;

    [_scrollView addSubview:_verifyCodeTextField];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(25, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line2.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line2];

    
    _tipsLb2 = [[UILabel alloc] initWithFrame:CGRectMake(_verifyCodeTextField.frame.origin.x, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height+20, _verifyCodeTextField.frame.size.width, 45)];
    _tipsLb2.backgroundColor = [UIColor clearColor];
    _tipsLb2.font = [UIFont systemFontOfSize:12];
    _tipsLb2.textColor = kUIColorFromRGB(0x808080);
    _tipsLb2.textAlignment = NSTextAlignmentLeft;
    _tipsLb2.text = @"";
    _tipsLb2.numberOfLines = 0;
    [_mainView addSubview:_tipsLb2];
    
    
    // login in button
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(20, _tipsLb2.frame.origin.y+_tipsLb2.frame.size.height+20, _nMainViewWidth-40, _tipsLb2.frame.size.height);
    
    [_submitButton addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitButton.backgroundColor = kButtonBGColor;
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _submitButton.layer.cornerRadius = 6;
    _submitButton.layer.masksToBounds = YES;
    _submitButton.tag = 1002;
    [_mainView addSubview:_submitButton];
    
    _getVerificationCodeAPI = [[GetVerificationCodeAPI alloc] init];
    
    _codeValidateAPI = [[CodeValidateAPI alloc] init];
    _codeValidateAPI.animatingView = _mainView;

    _userInfoUpdateAPI = [[UserInfoUpdateAPI alloc] init];
    _userInfoUpdateAPI.delegate = self;
    _userInfoUpdateAPI.animatingView = _mainView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.type == REVISE_PH_STEP_ONE)
    {
        _tipsLb1.text = @"为了您的账号安全，请输入您的旧手机号码";

        _usernameTextField.placeholder = @"请输入您的旧手机号码";

        _tipsLb2.text = @"修改手机号码：\n如果您的旧手机号码不能接收验证码，那么暂时不能修改手机号码";

        [_submitButton setTitle:@"下一步" forState:UIControlStateNormal];

    }
    else
    {
        _tipsLb1.text = @"请输入您的新手机号码，\n点击“获取验证码”完成短信难";

        _usernameTextField.placeholder = @"请输入您的手机号码";

        _tipsLb2.text = @"绑定手机：\n1.手机号绑定后可与其他设备信息云同步。";

        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];

    }
}

- (void)scrollViewTapAction {
    [_usernameTextField resignFirstResponder];
    [_verifyCodeTextField resignFirstResponder];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == _usernameTextField) {
        if(textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 201)
    {
        [_verifyCodeTextField becomeFirstResponder];
    }
    if (textField.tag == 202)
    {
        [textField resignFirstResponder];
        
        [self performSelector:@selector(submitBtnClicked)];
    }
    return YES;
}

- (void)submitBtnClicked {
    [_usernameTextField resignFirstResponder];
    
    if (! _usernameTextField.text || [_usernameTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if (! _verifyCodeTextField.text || [_verifyCodeTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入验证码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
    
    
    else
    {
        NSString *username = _usernameTextField.text;
        NSString *code = _verifyCodeTextField.text;
        NSString *userId = [SystemUtil getCache:USER_ID];

        if (username.length > 0)
        {
            if (self.type == REVISE_PH_STEP_ONE)
            {
                _codeValidateAPI.ph = username;
                _codeValidateAPI.rty = @"updph";
                _codeValidateAPI.vd = code;
                [_codeValidateAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                    NSLog(@"%@",request.responseJSONObject);
                    
                    RevisePhViewController *ViewController = [[RevisePhViewController alloc] init];
                    ViewController.type = REVISE_PH_STEP_TWO;
                    [self.navigationController pushViewController:ViewController animated:YES];
                    
                    
                }failure:^(APIBaseRequest *request) {
                    NSLog(@"failed");
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                }];
            }
            else
            {
                
                _userInfoUpdateAPI.uid = userId;
                _userInfoUpdateAPI.ph = username;
                _userInfoUpdateAPI.vd = code;
                
                [_userInfoUpdateAPI start];
            }
            
            
            
        }
        
        
    }
    
}

- (void)verityBtnClicked {
    if (! _usernameTextField.text || [_usernameTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else if([_usernameTextField.text length] != 11)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    [_getVerifyCodeButton setTitle:@"60秒后重新获取" forState:UIControlStateNormal];
    _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    _getVerifyCodeButton.selected = YES;
    _getVerifyCodeButton.userInteractionEnabled = NO;
    _reSendCount = 60;
    [_sendTimer invalidate];
    _sendTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self selector:@selector(sendTimer:)
                                                userInfo:nil repeats:YES];
    
    
    _getVerificationCodeAPI.userName = _usernameTextField.text;
    _getVerificationCodeAPI.type = VERIFICATION_CODE_UPDPH;
    
    
    [_getVerificationCodeAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        // 可以直接在这里使用 self
        NSLog(@"验证码succeed:%@",request.responseJSONObject);
        NSString *st = [request.responseJSONObject objectForKey:@"st"];
        if ([st isEqualToString:@"success"])
        {
            
        }
        else if ([st isEqualToString:@"fail"])
        {
            _getVerifyCodeButton.selected = NO;
            _getVerifyCodeButton.userInteractionEnabled = YES;
            [_sendTimer invalidate];
            [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码" message:@"验证码获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            _getVerifyCodeButton.selected = NO;
            _getVerifyCodeButton.userInteractionEnabled = YES;
            [_sendTimer invalidate];
            [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码" message:[request.responseJSONObject objectForKey:@"st"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        
    } failure:^(APIBaseRequest *request) {
        // 可以直接在这里使用 self
        NSLog(@"failed:%@",request.responseJSONObject);
        
        _getVerifyCodeButton.selected = NO;
        _getVerifyCodeButton.userInteractionEnabled = YES;
        [_sendTimer invalidate];
        [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
    
}

- (void)sendTimer:(NSTimer *)theTimer {
    if (_reSendCount>0)
    {
        _getVerifyCodeButton.selected = YES;
        
        [_getVerifyCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_reSendCount] forState:UIControlStateNormal];
        _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        _reSendCount--;
    }
    else
    {
        _getVerifyCodeButton.userInteractionEnabled = YES;
        [_sendTimer invalidate];
        [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[PersonalCenterViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
    
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}


@end
