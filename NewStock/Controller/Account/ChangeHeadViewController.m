//
//  ChangeHeadViewController.m
//  NewStock
//
//  Created by Willey on 16/8/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ChangeHeadViewController.h"
#import "UIImageView+WebCache.h"

@implementation ChangeHeadViewController{

    BOOL _isDefault; //是否是默认头像
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改头像";
    [_navBar setTitle:self.title];
    //[_navBar setRightBtnImg:[UIImage imageNamed:@"done_icon"]];
    [self setRightBtnTitle:@"提交"];

    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    
    _headerImgView = [[UIImageView alloc] init];
    [_mainView addSubview:_headerImgView];
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImgView.superview).offset(50);
        make.centerX.equalTo(_headerImgView.superview.mas_centerX);
        make.width.mas_equalTo(widthEx(220));
        make.height.mas_equalTo(widthEx(220));
        
    }];
    [_headerImgView layoutIfNeeded];
    _headerImgView.layer.cornerRadius = _headerImgView.frame.size.height/2;
    _headerImgView.layer.masksToBounds = YES;
    _headerImgView.layer.borderWidth = 1.5;
    _headerImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headerImgView.userInteractionEnabled = YES;
    [_headerImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)]];

    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:self.headerImgUrl]
                      placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
    

    _uploadImgAPI = [[UploadImageAPI alloc] init];
    _uploadImgAPI.delegate = self;
    _uploadImgAPI.animatingView = _mainView;
    _uploadImgAPI.animatingText = @"数据提交中";
    
    _getDefaultIconAPI = [[GetDefaultIcon alloc] init];
    _getDefaultIconAPI.delegate = self;
    _getDefaultIconAPI.animatingView = _mainView;
    _getDefaultIconAPI.animatingText = @"数据提交中";
    
    _userInfoUpdateAPI = [[UserInfoUpdateAPI alloc] init];
    _userInfoUpdateAPI.delegate = self;
    _userInfoUpdateAPI.animatingView = _mainView;
    _userInfoUpdateAPI.animatingText = @"数据提交中";
    
    [self showActionSheet];
    
}

- (void)showActionSheet {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"拍照", @"从手机相册选择", @"选择默认头像", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)headerClick:(UITapGestureRecognizer *)gestureRecognizer {
    [self showActionSheet];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        //检查是否支持拍照
        BOOL canTakePicture = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (!canTakePicture)
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
        [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imgPicker setDelegate:self];
        [imgPicker setAllowsEditing:YES];
        [self.navigationController presentViewController:imgPicker animated:YES completion:^{
        }];
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
        [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imgPicker setDelegate:self];
        [imgPicker setAllowsEditing:YES];
        [self.navigationController presentViewController:imgPicker animated:YES completion:^{
        }];
    }
    else if(buttonIndex == 2)
    {
        [_headerImgView setImage:[UIImage imageNamed:@"header_placeholder"]];
        _selectedImg = [UIImage imageNamed:@"header_placeholder"];
        _isDefault = YES;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _selectedImg=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    //UIImage  * chosedImage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //NSString * name = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    _headerImgView.image = _selectedImg;
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
    
//    float nWidth = chosedImage.size.width;
//    float nHeight = chosedImage.size.height;
//    if (nWidth>800 || nHeight>800)
//    {
//        float fW = 800.0/nWidth;
//        float fH = 800.0/nHeight;
//        float scale = fW < fH ? fW:fH;
//        chosedImage = [SystemUtil scaleImage:chosedImage toScale:scale];
//    }
//    else
//    {
//        
//    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)uploadImage {
    if(_selectedImg == nil)_selectedImg = _headerImgView.image;
    
    if (_selectedImg)
    {
        _uploadImgAPI.image = _selectedImg;
        [_uploadImgAPI start];
    }
    

}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    if ([request isKindOfClass:[GetDefaultIcon class]]) {
        NSArray *array = request.responseJSONObject;
        NSDictionary *dict = array[0];
        _userInfoUpdateAPI.ico = dict;
        _userInfoUpdateAPI.uid = [SystemUtil getCache:USER_ID];
        [_userInfoUpdateAPI start];
    }
    
    if ([request isKindOfClass:[UploadImageAPI class]] || [request isKindOfClass:[UserInfoUpdateAPI class]]) {
        [self success];
    }

}

- (void)success {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = 1001;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender {
    //保存
    if (_isDefault) {
        [_getDefaultIconAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
            NSLog(@"%@",request.responseJSONObject);
        } failure:^(__kindof APIBaseRequest *request) {
            
        }];
    }else {
        [self uploadImage];
    }
}

@end
