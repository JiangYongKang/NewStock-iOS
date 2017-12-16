//
//  RevisePhViewController.h
//  NewStock
//
//  Created by Willey on 16/9/6.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "GetVerificationCodeAPI.h"
#import "CodeValidateAPI.h"
#import "UserInfoUpdateAPI.h"

typedef NS_ENUM(NSInteger, REVISE_PH_STEP) {
    REVISE_PH_STEP_ONE,
    REVISE_PH_STEP_TWO
};


@interface RevisePhViewController : BaseViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UILabel *_tipsLb1;
    UILabel *_tipsLb2;
    
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


@property (nonatomic, assign) REVISE_PH_STEP type;

@end
