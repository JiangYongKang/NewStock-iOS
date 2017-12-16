//
//  RevisePwViewController.h
//  NewStock
//
//  Created by Willey on 16/9/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfoUpdateAPI.h"

@interface RevisePwViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    UITextField *_passwordTextField;
    UITextField *_passwordTextField2;
    UIButton *_loginButton;
    
    UserInfoUpdateAPI *_userInfoUpdateAPI;
}


@end
