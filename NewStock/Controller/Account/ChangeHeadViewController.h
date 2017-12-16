//
//  ChangeHeadViewController.h
//  NewStock
//
//  Created by Willey on 16/8/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "UploadImageAPI.h"
#import "GetDefaultIconAPI.h"
#import "UserInfoUpdateAPI.h"

@interface ChangeHeadViewController : BaseViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *_headerImgView;
    UIImage *_selectedImg;
    
    UploadImageAPI *_uploadImgAPI;
    GetDefaultIcon *_getDefaultIconAPI;
    UserInfoUpdateAPI *_userInfoUpdateAPI;
}

@property (nonatomic, strong) NSString * headerImgUrl;

@end
