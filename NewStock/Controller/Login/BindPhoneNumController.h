//
//  BindPhoneNumController.h
//  NewStock
//
//  Created by Willey on 16/8/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "GetVerificationCodeAPI.h"
#import "CodeValidateAPI.h"
#import "ThirdLoginAPI.h"

@interface BindPhoneNumController : BaseViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *_usernameTextField;
    UITextField *_verifyCodeTextField;
    
    
    UIButton *_getVerifyCodeButton;
    UIButton *_submitButton;
    
    GetVerificationCodeAPI *_getVerificationCodeAPI;
    CodeValidateAPI *_codeValidateAPI;
    ThirdLoginAPI *_thirdLoginAPI;

    NSTimer *_sendTimer;
    int _reSendCount;
}
@property (nonatomic, assign) VERIFICATION_CODE_TYPE type;

@property (nonatomic, strong) NSString * suid;
@property (nonatomic, strong) NSString * sr;
@property (nonatomic, strong) NSString * n;
@property (nonatomic, strong) NSString * img;

-(void)sendTimer:(NSTimer *)theTimer;

@end
