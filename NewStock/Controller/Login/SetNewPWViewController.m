//
//  SetNewPWViewController.m
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "SetNewPWViewController.h"
#import "NoCopyTextField.h"
#import "LoginViewController.h"
#import "MarketConfig.h"

@implementation SetNewPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置新密码";
    [_navBar setTitle:self.title];
    
    [self setRightBtnImg:nil];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    
    _mainView.backgroundColor = [SystemUtil hexStringToColor:@"#f8f8f8"];
    
    UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
    gensture.delegate = self;
    [_mainView addGestureRecognizer:gensture];
    
      
    _pwTextField = [[NoCopyTextField alloc] initWithFrame:CGRectMake(30, 50, _nMainViewWidth-60, 40)];
    _pwTextField.delegate = self;
    _pwTextField.backgroundColor = [UIColor clearColor];
    _pwTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwTextField.placeholder = @"请输入6-20位密码";
    _pwTextField.textColor = [UIColor blackColor];
    _pwTextField.font = [UIFont systemFontOfSize:16];
    _pwTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwTextField.returnKeyType = UIReturnKeyNext;
    _pwTextField.secureTextEntry = YES;
    _pwTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _pwTextField.tag = 201;
    //_pwTextField.layer.borderColor = [SystemUtil hexStringToColor:@"#c9c9c9"].CGColor;
    //_pwTextField.layer.borderWidth = 0.5;
    [_mainView addSubview:_pwTextField];
    [_pwTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
//    UILabel *paddingView1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 95, 20)];
//    paddingView1.text = @"新密码";
//    paddingView1.textAlignment = NSTextAlignmentLeft;
//    paddingView1.textColor = [UIColor blackColor];
//    paddingView1.font = [UIFont systemFontOfSize:15];
//    
//    _pwTextField.leftView = paddingView1;
//    _pwTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(30, _pwTextField.frame.origin.y+_pwTextField.frame.size.height, _nMainViewWidth-60, 0.5)];
    line1.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line1];
    
    
    //
    _pwTextField2 = [[NoCopyTextField alloc]initWithFrame:CGRectMake(_pwTextField.frame.origin.x, _pwTextField.frame.origin.y+_pwTextField.frame.size.height+10, _pwTextField.frame.size.width, _pwTextField.frame.size.height)];
    _pwTextField2.delegate = self;
    _pwTextField2.backgroundColor = [UIColor clearColor];
    _pwTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwTextField2.placeholder = @"请输入确认密码";
    //_pwTextField2.layer.borderColor = [SystemUtil hexStringToColor:@"#c9c9c9"].CGColor;
    //_pwTextField2.layer.borderWidth = 0.5;
    _pwTextField2.textColor = [UIColor blackColor];
    _pwTextField2.font = [UIFont systemFontOfSize:16];
    _pwTextField2.secureTextEntry = YES;
    _pwTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwTextField2.returnKeyType = UIReturnKeyGo;
    _pwTextField2.tag = 202;
    [_mainView addSubview:_pwTextField2];
   
    //UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    UILabel *paddingView2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 95, 20)];
//    paddingView2.text = @"重新输入密码";
//    paddingView2.textAlignment = NSTextAlignmentLeft;
//    paddingView2.textColor = [UIColor blackColor];
//    paddingView2.font = [UIFont systemFontOfSize:15];
//    
//    _pwTextField2.leftView = paddingView2;
//    _pwTextField2.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(30, _pwTextField2.frame.origin.y+_pwTextField2.frame.size.height, _nMainViewWidth-60, 0.5)];
    line2.backgroundColor = SEP_LINE_COLOR;
    [_mainView addSubview:line2];
    
    // login in button
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(20, _pwTextField2.frame.origin.y+_pwTextField2.frame.size.height+20, _nMainViewWidth-40, _pwTextField2.frame.size.height);
    
    [_submitButton addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitButton.backgroundColor = kUIColorFromRGB(BUTTOM_BG_COLOR);
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _submitButton.layer.cornerRadius = 6;
    _submitButton.layer.masksToBounds = YES;
    _submitButton.tag = 1002;
    [_mainView addSubview:_submitButton];
    
    
    _modifyPasswordAPI = [[ModifyPasswordAPI alloc] init];
    _modifyPasswordAPI.animatingView = _mainView;
    //_modifyPasswordAPI.animatingText = @"";
    _mainView.backgroundColor = [UIColor whiteColor];
    _navBar.line_view.hidden = YES;
}

- (void)scrollViewTapAction {
    [_pwTextField resignFirstResponder];
    [_pwTextField2 resignFirstResponder];
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, 0) animated:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 201)
    {
        [_pwTextField2 becomeFirstResponder];
    }
    if (textField.tag == 202)
    {
        [textField resignFirstResponder];
        
        [self performSelector:@selector(submitBtnClicked)];
    }
    return YES;
}

- (void)submitBtnClicked {
    [_pwTextField resignFirstResponder];
    [_pwTextField2 resignFirstResponder];
    
    if ([_pwTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if ([_pwTextField2.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if (![_pwTextField2.text isEqualToString:_pwTextField.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入密码不一致！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        NSString *password = _pwTextField.text;
        NSString *aesPwd = [SystemUtil getAESPw:password];

        _modifyPasswordAPI.pwd = aesPwd;
        _modifyPasswordAPI.vd = self.vd;
        _modifyPasswordAPI.ph = self.ph;
        NSLog(@"vd:%@,ph:%@",self.vd,self.ph);
        [_modifyPasswordAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
            NSLog(@"%@",request.responseJSONObject);
            
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[LoginViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
            
        }
        failure:^(APIBaseRequest *request) {
                NSLog(@"failed");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }];
        
    }
    
}

@end
