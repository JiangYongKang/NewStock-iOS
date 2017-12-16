//
//  ForgetViewController.m
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ForgetViewController.h"
#import "SetNewPWViewController.h"
#import "MarketConfig.h"

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找回密码";
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
    
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(25, 50, _nMainViewWidth-50, 40)];
    _usernameTextField.delegate = self;
    _usernameTextField.backgroundColor = [UIColor clearColor];
    _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _usernameTextField.textColor = [SystemUtil hexStringToColor:@"#383838"];
    _usernameTextField.font = [UIFont systemFontOfSize:14];

    if (_nMainViewWidth>320)
    {
        _usernameTextField.placeholder = @"请输入您注册的手机号码";
    }
    else
    {
        NSMutableAttributedString *uAttrStr = [[NSMutableAttributedString alloc] initWithString:@"请输入您注册的手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
        _usernameTextField.attributedPlaceholder = uAttrStr;
    }
    
    _usernameTextField.textColor = [UIColor blackColor];
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameTextField.returnKeyType = UIReturnKeyNext;
    _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameTextField.tag = 201;

    [_mainView addSubview:_usernameTextField];
    _usernameTextField.text = [SystemUtil getCache:INPUT_USER_NAME];
    [_usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(25, _usernameTextField.frame.origin.y + _usernameTextField.frame.size.height, _nMainViewWidth - 50, 0.5)];
    line1.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line1];
    
    _getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getVerifyCodeButton.frame = CGRectMake(MAIN_SCREEN_WIDTH - 105, _usernameTextField.frame.origin.y + 5, 80, 30);

    [_getVerifyCodeButton addTarget:self action:@selector(verityBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getVerifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getVerifyCodeButton.backgroundColor = kButtonBGColor;
    _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _getVerifyCodeButton.tag = 1001;
    _getVerifyCodeButton.layer.cornerRadius = 5;
    _getVerifyCodeButton.layer.masksToBounds = YES;
    [_scrollView addSubview:_getVerifyCodeButton];
    
    //
    _verifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(_usernameTextField.frame.origin.x, _usernameTextField.frame.origin.y+_usernameTextField.frame.size.height+5, _usernameTextField.frame.size.width, _usernameTextField.frame.size.height)];
    _verifyCodeTextField.delegate = self;
    _verifyCodeTextField.backgroundColor = [UIColor clearColor];
    _verifyCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    _verifyCodeTextField.font = [UIFont systemFontOfSize:14];
    if (_nMainViewWidth>320)
    {
        _verifyCodeTextField.placeholder = @"请输入验证码";
    }
    else
    {
        NSMutableAttributedString *vAttrStr = [[NSMutableAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
        _verifyCodeTextField.attributedPlaceholder = vAttrStr;
    }
    
    _verifyCodeTextField.textColor = [UIColor blackColor];
    _verifyCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verifyCodeTextField.returnKeyType = UIReturnKeyNext;
    _verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _verifyCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _verifyCodeTextField.tag = 202;

    [_scrollView addSubview:_verifyCodeTextField];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(25, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line2.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line2];
    
    
    // login in button
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(20, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height+20, _nMainViewWidth-40, _verifyCodeTextField.frame.size.height);
    
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
    _codeValidateAPI.animatingText = @"验证中";
    
    
}

- (void)scrollViewTapAction {
    [_usernameTextField resignFirstResponder];
    [_verifyCodeTextField resignFirstResponder];
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, 0) animated:YES];
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
        
        if (username.length > 0)
        {
            //            _registerApi.userName = username;
            //            _registerApi.code = code;
            //
            //            [_registerApi start];
            
            _codeValidateAPI.ph = username;
            _codeValidateAPI.rty = @"retpwd";
            _codeValidateAPI.vd = code;
            [_codeValidateAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                NSLog(@"%@",request.responseJSONObject);
                
                SetNewPWViewController *ViewController = [[SetNewPWViewController alloc] init];
                ViewController.vd = code;
                ViewController.ph = username;
                [self.navigationController pushViewController:ViewController animated:YES];

                }
            failure:^(APIBaseRequest *request) {
                    NSLog(@"failed");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }];
                
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
    _getVerificationCodeAPI.type = VERIFICATION_CODE_RETPWD;
    
    
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
    
    
    
    
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
}

@end
