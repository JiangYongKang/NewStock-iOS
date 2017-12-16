//
//  AccountViewController.h
//  NewStock
//
//  Created by Willey on 16/7/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfoTopView.h"
#import "GetUserInfoAPI.h"
#import "GetUserDynamicAPI.h"
#import "DeleteUserDynamicAPI.h"


@interface AccountViewController : BaseViewController<UIActionSheetDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *_headerImgView;
    UILabel *_nickNameLb;
    UILabel *_gradeLb;
    
    UserInfoTopView *_userInfoTopView;
    
    DeleteUserDynamicAPI *_deleteDynamicAPI;
    GetUserInfoAPI *_getUserInfoAPI;
    GetUserDynamicAPI *_getUserDynamicAPI;
}
@end
