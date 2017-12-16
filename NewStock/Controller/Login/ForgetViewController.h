//
//  ForgetViewController.h
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "GetVerificationCodeAPI.h"
#import "CodeValidateAPI.h"
#import "UserInfoUpdateAPI.h"

@interface ForgetViewController : BaseViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *_usernameTextField;
    UITextField *_verifyCodeTextField;
    
    
    UIButton *_getVerifyCodeButton;
    UIButton *_submitButton;
    
    GetVerificationCodeAPI *_getVerificationCodeAPI;
    CodeValidateAPI *_codeValidateAPI;
    UserInfoUpdateAPI *_userInfoUpdateAPI;
    
    NSTimer *_sendTimer;
    int _reSendCount;
}


-(void)sendTimer:(NSTimer *)theTimer;
@end
