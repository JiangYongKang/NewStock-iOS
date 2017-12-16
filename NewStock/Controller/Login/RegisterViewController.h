//
//  RegisterViewController.h
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "RegisterAPI.h"
#import "GetVerificationCodeAPI.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    UITextField *_usernameTextField;
    UITextField *_verifyCodeTextField;
    UITextField *_passwordTextField;
    
    
    UIButton *_getVerifyCodeButton;
    
    UIButton *_eyeBtn;
    
    UIButton *_protocolBtn;
    UIButton *_protocolContentBtn;
    
    UIButton *_submitButton;
    
    GetVerificationCodeAPI *_getVerificationCodeAPI;
    RegisterAPI *_registerApi;
    
    NSTimer *_sendTimer;
    int _reSendCount;
}
-(void)sendTimer:(NSTimer *)theTimer;

@end
