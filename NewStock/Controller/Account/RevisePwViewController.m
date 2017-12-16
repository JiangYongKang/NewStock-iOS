//
//  RevisePwViewController.m
//  NewStock
//
//  Created by Willey on 16/9/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RevisePwViewController.h"
#import "NoCopyTextField.h"
#import "UserInfoUpdateAPI.h"
#import "MarketConfig.h"

@implementation RevisePwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarTitle:@"修改登录密码"];
    [self setRightBtnImg:nil];
    _navBar.line_view.hidden = YES;
    
    _mainView.backgroundColor = kUIColorFromRGB(0xffffff);
    
    UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
    gensture.delegate = self;
    [_mainView addGestureRecognizer:gensture];
    
    
    
    _passwordTextField = [[NoCopyTextField alloc] initWithFrame:CGRectMake(25, 30, _nMainViewWidth-50, 40)];
    _passwordTextField.delegate = self;
    _passwordTextField.backgroundColor = [UIColor clearColor];
    _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordTextField.placeholder = @"请输入旧密码";
    _passwordTextField.textColor = [UIColor blackColor];
    _passwordTextField.font = [UIFont systemFontOfSize:14];
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.returnKeyType = UIReturnKeyNext;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTextField.tag = 201;

    [_mainView addSubview:_passwordTextField];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(25, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height, _nMainViewWidth-50, 0.5)];
    line1.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line1];
    
    _passwordTextField2 = [[NoCopyTextField alloc]initWithFrame:CGRectMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+10, _passwordTextField.frame.size.width, _passwordTextField.frame.size.height)];
    _passwordTextField2.delegate = self;
    _passwordTextField2.backgroundColor = [UIColor clearColor];
    _passwordTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordTextField2.placeholder = @"请输入新密码";
    _passwordTextField2.textColor = [UIColor blackColor];
    _passwordTextField2.font = [UIFont systemFontOfSize:14];
    //_passwordTextField2.secureTextEntry = YES;
    _passwordTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField2.returnKeyType = UIReturnKeyDone;
    _passwordTextField2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTextField2.tag = 202;

    [_mainView addSubview:_passwordTextField2];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(25, _passwordTextField2.frame.origin.y+_passwordTextField2.frame.size.height, _nMainViewWidth-50, 0.5)];
    line2.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line2];
    
    
    // login in button
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(20, _passwordTextField2.frame.origin.y+_passwordTextField2.frame.size.height+120, _nMainViewWidth-40, _passwordTextField2.frame.size.height);
    [_loginButton addTarget:self action:@selector(reviseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton setTitle:@"确定" forState:UIControlStateNormal];//修改密码
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _loginButton.layer.cornerRadius = 6;
    _loginButton.layer.masksToBounds = YES;
    _loginButton.backgroundColor = kButtonBGColor;
    [_mainView addSubview:_loginButton];
    
    
    _userInfoUpdateAPI = [[UserInfoUpdateAPI alloc] init];
    _userInfoUpdateAPI.delegate = self;
    _userInfoUpdateAPI.animatingView = _mainView;
    _userInfoUpdateAPI.animatingText = @"数据提交中";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _passwordTextField)
    {
        [_passwordTextField2 becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)scrollViewTapAction {
    [_passwordTextField resignFirstResponder];
    [_passwordTextField2 resignFirstResponder];
}

- (void)reviseButtonClicked {
    [_passwordTextField resignFirstResponder];
    [_passwordTextField2 resignFirstResponder];
    
    
    
    if (! _passwordTextField.text || [_passwordTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入旧密码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if (! _passwordTextField2.text || [_passwordTextField2.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入新密码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if (_passwordTextField2.text.length < 6 || _passwordTextField2.text.length > 20)
    {
        UIAlertView *alerate = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码必须在6~20个字符之内" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alerate show];
    }
    else
    {
        
        NSString *userId = [SystemUtil getCache:USER_ID];

        NSString *password = _passwordTextField.text;
        NSString *password2 = _passwordTextField2.text;
        _userInfoUpdateAPI.uid = userId;
        _userInfoUpdateAPI.pwd = [SystemUtil getAESPw:password];
        _userInfoUpdateAPI.npwd = [SystemUtil getAESPw:password2];
        [_userInfoUpdateAPI start];
    }
    
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    [SystemUtil putCache:USER_PW value:_passwordTextField2.text];
    
    _passwordTextField.text = @"";
    _passwordTextField2.text = @"";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码修改成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = 101;
    [alertView show];
    
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
