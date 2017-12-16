//
//  LoginViewController.h
//  NewStock
//
//  Created by Willey on 16/7/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginAPI.h"
#import "PhoneCheckAPI.h"
#import "ThirdLoginAPI.h"
#import "MBProgressHUD.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate, UIGestureRecognizerDelegate>
{
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    
    LoginAPI *_loginAPI;
    PhoneCheckAPI *_phoneCheckAPI;
    
    ThirdLoginAPI *_thirdLoginAPI;
    
    MBProgressHUD *_progressHUD;
    
}

@property (nonatomic, strong) UIButton *visitorBtn;

@end
