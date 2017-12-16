//
//  BindPhoneNumController.m
//  NewStock
//
//  Created by Willey on 16/8/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BindPhoneNumController.h"
#import "UserInfoModel.h"
#import "UserInfoInstance.h"
#import "MarketConfig.h"
#import "Defination.h"
#import "StockHistoryUtil.h"

@implementation BindPhoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"绑定手机号";
    [_navBar setTitle:self.title];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    
    
    _mainView.backgroundColor = [SystemUtil hexStringToColor:@"#f8f8f8"];
    
    UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
    gensture.delegate = self;
    [_mainView addGestureRecognizer:gensture];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, _nMainViewWidth-50, 40)];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = kUIColorFromRGB(0x808080);
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"请输入您的手机号码，\n点击“获取验证码”，完成短信验证";
    label1.numberOfLines = 2;
    [_mainView addSubview:label1];
    
    

    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(25, 70, _nMainViewWidth-50, 40)];
    _usernameTextField.delegate = self;
    _usernameTextField.backgroundColor = [UIColor clearColor];
    _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _usernameTextField.textColor = [SystemUtil hexStringToColor:@"#383838"];

    _usernameTextField.textColor = [UIColor blackColor];
    _usernameTextField.font = [UIFont systemFontOfSize:14];
    
    if (_nMainViewWidth>320)
    {
        _usernameTextField.placeholder = @"请输入您的手机号";
    }
    else
    {
        NSMutableAttributedString *uAttrStr = [[NSMutableAttributedString alloc] initWithString:@"请输入您的手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
        _usernameTextField.attributedPlaceholder = uAttrStr;
    }

    
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameTextField.returnKeyType = UIReturnKeyNext;
    _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameTextField.tag = 201;
    //    _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    //_usernameTextField.layer.borderColor = [SystemUtil hexStringToColor:@"#c9c9c9"].CGColor;
    //_usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //_usernameTextField.layer.borderWidth = 0.5;
    [_mainView addSubview:_usernameTextField];
    _usernameTextField.text = [SystemUtil getCache:INPUT_USER_NAME];
    [_usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
   
    //UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UILabel *userNamePaddingLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    userNamePaddingLb.text = @"手机号";
    userNamePaddingLb.textAlignment = NSTextAlignmentLeft;
    userNamePaddingLb.textColor = [UIColor blackColor];
    userNamePaddingLb.font = [UIFont systemFontOfSize:16];
    
    _usernameTextField.leftView = userNamePaddingLb;
    _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(25, _usernameTextField.frame.origin.y+_usernameTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line1.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line1];
    
    
    _getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getVerifyCodeButton.frame = CGRectMake(MAIN_SCREEN_WIDTH-105, _usernameTextField.frame.origin.y+5, 80, 30);
    //[_getVerifyCodeButton setBackgroundImage:[UIImage imageNamed:@"green_btn_bg"] forState:UIControlStateNormal];
    //[_getVerifyCodeButton setBackgroundImage:[UIImage imageNamed:@"green_btn_press_bg"] forState:UIControlStateSelected];
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
    _verifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(_usernameTextField.frame.origin.x, _usernameTextField.frame.origin.y+_usernameTextField.frame.size.height+10, _usernameTextField.frame.size.width, _usernameTextField.frame.size.height)];
    _verifyCodeTextField.delegate = self;
    _verifyCodeTextField.backgroundColor = [UIColor clearColor];
    _verifyCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _verifyCodeTextField.textColor = [UIColor blackColor];
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
    
    _verifyCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verifyCodeTextField.returnKeyType = UIReturnKeyNext;
    //    _verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _verifyCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _verifyCodeTextField.tag = 202;
    //_verifyCodeTextField.layer.borderColor = [SystemUtil hexStringToColor:@"#c9c9c9"].CGColor;
    _verifyCodeTextField.backgroundColor = [UIColor clearColor];
    //_verifyCodeTextField.layer.borderWidth = 0.5;
    [_scrollView addSubview:_verifyCodeTextField];
    
    //UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    UILabel *vcPaddingLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    vcPaddingLb.text = @"验证码";
    vcPaddingLb.textAlignment = NSTextAlignmentLeft;
    vcPaddingLb.textColor = [UIColor blackColor];
    vcPaddingLb.font = [UIFont systemFontOfSize:16];
    
    _verifyCodeTextField.leftView = vcPaddingLb;
    _verifyCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(25, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line2.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line2];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(_verifyCodeTextField.frame.origin.x, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height+20, _verifyCodeTextField.frame.size.width, 40)];
    label2.backgroundColor = [UIColor clearColor];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = kUIColorFromRGB(0x808080);
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"绑定手机：\n手机号绑定后可与其他设备信息云同步。";
    label2.numberOfLines = 2;
    [_mainView addSubview:label2];

    // login in button
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(20, _verifyCodeTextField.frame.origin.y+_verifyCodeTextField.frame.size.height+20+40+20, _nMainViewWidth-40, _verifyCodeTextField.frame.size.height);
    
    [_submitButton addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitButton.backgroundColor = kButtonBGColor;
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _submitButton.layer.cornerRadius = 6;
    _submitButton.layer.masksToBounds = YES;
    _submitButton.tag = 1002;
    [_mainView addSubview:_submitButton];
    
    
    
    _getVerificationCodeAPI = [[GetVerificationCodeAPI alloc] init];

    _codeValidateAPI = [[CodeValidateAPI alloc] init];
    
    _thirdLoginAPI = [[ThirdLoginAPI alloc] init];
    _thirdLoginAPI.animatingView = _mainView;

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
            _thirdLoginAPI.suid = self.suid;
            _thirdLoginAPI.sr = self.sr;
            _thirdLoginAPI.ph = username;
            _thirdLoginAPI.n = self.n;
            _thirdLoginAPI.img = self.img;
            _thirdLoginAPI.vd = code;
            
            [_thirdLoginAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                NSLog(@"%@",request.responseJSONObject);
                
                [StockHistoryUtil getMyStockFromServer];
                
                UserInfoModel *model = [MTLJSONAdapter modelOfClass:[UserInfoModel class] fromJSONDictionary:request.responseJSONObject error:nil];
                [UserInfoInstance sharedUserInfoInstance].userInfoModel = model;
                
                NSLog(@"user info model:%@",model);
                [SystemUtil putCache:USER_NAME value:_usernameTextField.text];
                [SystemUtil putCache:INPUT_USER_NAME value:_usernameTextField.text];

                [SystemUtil putCache:USER_PW value:@""];
                [SystemUtil putCache:USER_ID value:model.userId];
                
                [SystemUtil saveCookie];
                [SystemUtil setCookie];
                [self.navigationController popToRootViewControllerAnimated:YES];

                
            } failure:^(APIBaseRequest *request) {
                NSLog(@"failed:%@",request.responseJSONObject);
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
    _getVerificationCodeAPI.type = VERIFICATION_CODE_BIND;//VERIFICATION_CODE_REGISTER;
    
    
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
