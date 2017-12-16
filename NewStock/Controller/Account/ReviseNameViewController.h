//
//  ReviseNameViewController.h
//  NewStock
//
//  Created by Willey on 16/9/6.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfoUpdateAPI.h"

@interface ReviseNameViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate, UIGestureRecognizerDelegate>
{
    UITextField *_nicknameTF;
    
    UserInfoUpdateAPI *_userInfoUpdateAPI;

}
@property (nonatomic, strong) NSString *nickName;

@end
