//
//  RegisterViewController.m
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RegisterViewController.h"

#import "SystemUtil.h"
#import "NoCopyTextField.h"

#import "StockHistoryUtil.h"
#import "UserInfoInstance.h"

#import "UserInfoModel.h"
#import "MarketConfig.h"

#import "ContentViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    [_navBar setTitle:self.title];
    _navBar.line_view.hidden = YES;
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    
    UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
    gensture.delegate = self;
    [_mainView addGestureRecognizer:gensture];
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(25, 50, _nMainViewWidth-50, 40)];
    _usernameTextField.delegate = self;
    _usernameTextField.backgroundColor = [UIColor clearColor];
    _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _usernameTextField.textColor = [SystemUtil hexStringToColor:@"#383838"];
    _usernameTextField.textColor = [UIColor blackColor];
    _usernameTextField.font = [UIFont systemFontOfSize:15];
    
    if (_nMainViewWidth>320)
    {
        _usernameTextField.placeholder = @"请输入您的手机号码";
    }
    else
    {
        NSMutableAttributedString *uAttrStr = [[NSMutableAttributedString alloc] initWithString:@"请输入您的手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
        _usernameTextField.attributedPlaceholder = uAttrStr;
    }
    
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameTextField.returnKeyType = UIReturnKeyNext;
    _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameTextField.tag = 201;
    [_mainView addSubview:_usernameTextField];
    _usernameTextField.text = [SystemUtil getCache:INPUT_USER_NAME];
    [_usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(25, _usernameTextField.frame.origin.y+_usernameTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line1.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line1];
    
    _getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getVerifyCodeButton.frame = CGRectMake(MAIN_SCREEN_WIDTH - 105, _usernameTextField.frame.origin.y + 5, 80, 32);

    [_getVerifyCodeButton addTarget:self action:@selector(verityBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getVerifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getVerifyCodeButton.backgroundColor = kButtonBGColor;
    _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _getVerifyCodeButton.tag = 1001;
    _getVerifyCodeButton.layer.cornerRadius = 5;
    _getVerifyCodeButton.layer.masksToBounds = YES;
    [_scrollView addSubview:_getVerifyCodeButton];
    
    //
    _verifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(_usernameTextField.frame.origin.x, _usernameTextField.frame.origin.y+_usernameTextField.frame.size.height+10, _usernameTextField.frame.size.width, _usernameTextField.frame.size.height)];
    _verifyCodeTextField.delegate = self;
    _verifyCodeTextField.backgroundColor = [UIColor clearColor];
    _verifyCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _verifyCodeTextField.textColor = [UIColor blackColor];
    _verifyCodeTextField.font = [UIFont systemFontOfSize:15];
    
    if (_nMainViewWidth>320)
    {
        _verifyCodeTextField.placeholder = @"请输入验证码";
    }
    else
    {
        NSMutableAttributedString *vAttrStr = [[NSMutableAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
        _verifyCodeTextField.attributedPlaceholder = vAttrStr;
    }
    
    _verifyCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verifyCodeTextField.returnKeyType = UIReturnKeyNext;
    _verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _verifyCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _verifyCodeTextField.tag = 202;

    [_scrollView addSubview:_verifyCodeTextField];
    
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(25, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line2.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line2];
    

    _passwordTextField = [[NoCopyTextField alloc]initWithFrame:CGRectMake(_verifyCodeTextField.frame.origin.x, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height+10, _verifyCodeTextField.frame.size.width, _verifyCodeTextField.frame.size.height)];
    _passwordTextField.delegate = self;
    _passwordTextField.backgroundColor = [UIColor clearColor];
    _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    _passwordTextField.textColor = [UIColor blackColor];
    _passwordTextField.font = [UIFont systemFontOfSize:15];
    
    if (_nMainViewWidth>320)
    {
        _passwordTextField.placeholder = @"请输入您的密码(数字，字母，6-20位)";
    }
    else
    {
        NSMutableAttributedString *pwAttrStr = [[NSMutableAttributedString alloc] initWithString:@"请输入您的密码(数字，字母，6-20位)" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
        _passwordTextField.attributedPlaceholder = pwAttrStr;
    }

    
    _passwordTextField.secureTextEntry = YES;
    //_passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.returnKeyType = UIReturnKeyGo;
    _passwordTextField.tag = 203;
    [_mainView addSubview:_passwordTextField];
    
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(25, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line3.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line3];
    
    _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _eyeBtn.frame = CGRectMake(_nMainViewWidth-50, _passwordTextField.frame.origin.y+10, 40, 20);
    [_eyeBtn setImage:[UIImage imageNamed:@"eye_icon"] forState:UIControlStateNormal];
    [_eyeBtn setImage:[UIImage imageNamed:@"eye_icon_sel"] forState:UIControlStateSelected];
    [_eyeBtn addTarget:self action:@selector(eyeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _eyeBtn.selected = YES;
    [_mainView addSubview:_eyeBtn];
    
    _protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _protocolBtn.frame = CGRectMake(10+_passwordTextField.frame.size.width-140, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+20, 40, 20);
    [_protocolBtn setImage:[UIImage imageNamed:@"protocolIcon.png"] forState:UIControlStateNormal];
    [_protocolBtn setImage:[UIImage imageNamed:@"protocolSelIcon.png"] forState:UIControlStateSelected];
    [_protocolBtn addTarget:self action:@selector(protocolBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _protocolBtn.selected = YES;
    [_mainView addSubview:_protocolBtn];
    
    
    _protocolContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _protocolContentBtn.frame = CGRectMake(_protocolBtn.frame.origin.x+30, _protocolBtn.frame.origin.y, 130, 20);
    [_protocolContentBtn addTarget:self action:@selector(protocolContentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *protocolTitle = [[NSMutableAttributedString alloc] initWithString:@"同意 股怪侠用户协议"];
    [protocolTitle addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(0x666666) range:NSMakeRange(0,3)];
    [protocolTitle addAttribute:NSForegroundColorAttributeName value:kTitleColor range:NSMakeRange(3,7)];
    [_protocolContentBtn setAttributedTitle:protocolTitle forState:UIControlStateNormal];
    [_protocolContentBtn setTitleColor:[SystemUtil hexStringToColor:@"#0183be"] forState:UIControlStateNormal];
    _protocolContentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_mainView addSubview:_protocolContentBtn];
    
    
    
    
    
    // login in button
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(25, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+60, _passwordTextField.frame.size.width, _passwordTextField.frame.size.height);
    
    [_submitButton addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton setTitle:@"注    册" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitButton.backgroundColor = kButtonBGColor;
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _submitButton.layer.cornerRadius = 6;
    _submitButton.layer.masksToBounds = YES;
    _submitButton.tag = 1002;
    [_mainView addSubview:_submitButton];
    
    _mainView.backgroundColor = kUIColorFromRGB(0xffffff);
    
    _getVerificationCodeAPI = [[GetVerificationCodeAPI alloc] init];
    
    _registerApi = [[RegisterAPI alloc] init];
    _registerApi.animatingView = _mainView;
    _registerApi.animatingText = @"注册中";
    _registerApi.delegate = self;
}

- (void)eyeBtnAction {
    _eyeBtn.selected = !_eyeBtn.selected;
    
    if (_eyeBtn.selected)
    {
        _passwordTextField.secureTextEntry = YES;
    }
    else
    {
        _passwordTextField.secureTextEntry = NO;
    }
}

- (void)protocolBtnAction {
    _protocolBtn.selected = !_protocolBtn.selected;
    _submitButton.enabled = _protocolBtn.selected;
}

- (void)protocolContentBtnAction {
    ContentViewController *forgetViewController = [[ContentViewController alloc] init];
    [self.navigationController pushViewController:forgetViewController animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewTapAction {
    [_usernameTextField resignFirstResponder];
    [_verifyCodeTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, 0) animated:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == _passwordTextField)
    {
        if (textField.text.length > 20)
        {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    if (textField == _usernameTextField) {
        if(textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    /*
    if (textField == _usernameTextField)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, 0) animated:YES];
    }
    else if (textField == _verifyCodeTextField)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, 50) animated:YES];
    }
    else if (textField == _passwordTextField)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, 100) animated:YES];
    }
     */
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 201)
    {
        [_verifyCodeTextField becomeFirstResponder];
    }
    if (textField.tag == 202)
    {
        [_passwordTextField becomeFirstResponder];
    }
    if (textField.tag == 203)
    {
        [textField resignFirstResponder];
        
        [self performSelector:@selector(submitBtnClicked)];
    }
    return YES;
}

- (void)submitBtnClicked {
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
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
    else if(! _passwordTextField.text || [_passwordTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if([_passwordTextField.text length]<6 || [_passwordTextField.text length]>20)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码长度需在6-20位之间！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        if (_protocolBtn.selected)
        {
            NSString *username = _usernameTextField.text;
            NSString *code = _verifyCodeTextField.text;
            NSString *password = _passwordTextField.text;
            
            if (username.length > 0 && password.length > 0)
            {
                _registerApi.userName = username;
                _registerApi.code = code;
                
                NSString *aesPwd = [SystemUtil getAESPw:password];//@"jiabei"
                //NSString *pwd = [SystemUtil getRandomPw:aesPwd];
                _registerApi.pwd = aesPwd;
                
                [_registerApi start];
                
            }
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先阅读并同意《股怪侠用户协议》!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
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
    _getVerificationCodeAPI.type = VERIFICATION_CODE_REGISTER;


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
        NSString *str = [request.responseJSONObject objectForKey:@"msg"];
        str = str.length ? str : @"请检查网络连接!";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
  
}

- (void)sendTimer:(NSTimer *)theTimer {
    if (_reSendCount > 0) {
        _getVerifyCodeButton.selected = YES;

        [_getVerifyCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_reSendCount] forState:UIControlStateNormal];
        _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        _reSendCount--;
    } else {
        _getVerifyCodeButton.userInteractionEnabled = YES;
        [_sendTimer invalidate];
        [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",_registerApi.responseJSONObject);
    
    [StockHistoryUtil getMyStockFromServer];

    UserInfoModel *model = [MTLJSONAdapter modelOfClass:[UserInfoModel class] fromJSONDictionary:_registerApi.responseJSONObject error:nil];
    [UserInfoInstance sharedUserInfoInstance].userInfoModel = model;
    
    NSLog(@"user info model:%@",model);
    [SystemUtil putCache:USER_NAME value:_usernameTextField.text];
    [SystemUtil putCache:INPUT_USER_NAME value:_usernameTextField.text];

    [SystemUtil putCache:USER_PW value:_passwordTextField.text];
    [SystemUtil putCache:USER_ID value:model.userId];
    
    [SystemUtil saveCookie];
    [SystemUtil setCookie];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = 1001;
    [alertView show];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",_registerApi.responseJSONObject);
    
    if ([SystemUtil isNotNSnull:request.responseJSONObject]) {
        NSString *msg = [request.responseJSONObject objectForKey:@"msg"];
        if ([SystemUtil isNotNSnull:msg]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
        [self.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }
}
@end
