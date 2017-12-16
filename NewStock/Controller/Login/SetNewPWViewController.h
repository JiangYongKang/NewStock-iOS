//
//  SetNewPWViewController.h
//  NewStock
//
//  Created by Willey on 16/8/31.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "ModifyPasswordAPI.h"

@interface SetNewPWViewController : BaseViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *_pwTextField;
    UITextField *_pwTextField2;
    
    
    UIButton *_submitButton;
    
    ModifyPasswordAPI *_modifyPasswordAPI;
}

@property (nonatomic, strong) NSString *ph;
@property (nonatomic, strong) NSString *vd;
@end
