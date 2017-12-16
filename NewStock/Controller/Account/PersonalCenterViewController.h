//
//  PersonalCenterViewController.h
//  NewStock
//
//  Created by Willey on 16/8/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "ZFBaseSettingViewController.h"
#import "GetUserInfoAPI.h"

@interface PersonalCenterViewController : ZFBaseSettingViewController<UIAlertViewDelegate>
{
    UIButton *_loginBtn;

    GetUserInfoAPI *_getUserInfoAPI;

}
@end
