//
//  PostSecretViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/3/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "PostSecretViewController.h"
#import "GCPlaceholderTextView.h"
#import "NewMomentViewController.h"
#import "WXTabBarController.h"
#import "AppDelegate.h"
#import "PostFeedAPI.h"
#import "PostFeedPicAPI.h"
#import "UserInfoInstance.h"
#import <UIImageView+WebCache.h>

#import "EmotionKeyboardView.h"
#import "EmotionButton.h"
#import "EmotionAttachment.h"


@interface PostSecretViewController ()<UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) GCPlaceholderTextView *contentTV;
@property (nonatomic) UILabel *lb_contentPlaceHolder; //content 占位文本
@property (nonatomic) UIView *input_view; // 键盘 inputacessaryView
@property (nonatomic, strong) PostFeedAPI *postFeedAPI;
@property (nonatomic, strong) PostFeedPicAPI *postFeedPicAPI;
@property (nonatomic, strong) EmotionKeyboardView *keyboardView;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) id imageResponse;
@property (nonatomic, strong) UILabel *totalLb;

//顶部匿名按钮
@property (nonatomic, strong) UIImageView *topIcon;
@property (nonatomic, strong) UILabel *topLb;
@property (nonatomic, strong) UIView *topShowView;
@property (nonatomic, strong) UIImageView *iv_secret;
@property (nonatomic, strong) UIImageView *iv_real;
@property (nonatomic, strong) UILabel *lb_secret;
@property (nonatomic, strong) UILabel *lb_real;
@property (nonatomic, strong) UIImageView *iv_choose1;
@property (nonatomic, strong) UIImageView *iv_choose2;

@property (nonatomic, strong) UIView *coverView;

@end

@implementation PostSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [_navBar setTitle:@"匿名爆料"];
    [_navBar setRightBtnTitle:@"提交"];
    [_navBar setLeftBtnTitle:@"取消"];
    
    [_navBar addSubview:self.totalLb];
    UIButton *btn = [_navBar valueForKeyPath:@"_rightButton"];
    [self.totalLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn);
        make.right.equalTo(btn.mas_left).offset(5 * kScale);
    }];
    
    self.title = @"匿名爆料发帖";
    
    [self.view addSubview:self.contentTV];
    _contentTV.backgroundColor = [UIColor whiteColor];
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(64 + 10 * kScale);
        make.width.equalTo(@(MAIN_SCREEN_WIDTH - 20));
        make.height.equalTo(@(MAIN_SCREEN_HEIGHT - 470));
    }];
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(108 * kScale));
        make.left.equalTo(self.view).offset(12 * kScale);
        make.top.equalTo(self.view).offset(64 + 180 * kScale);
    }];
    
    [_navBar addSubview:self.topIcon];
    [_navBar addSubview:self.topLb];
    [self.topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_navBar).offset(-20);
        make.centerY.equalTo(_navBar).offset(10);
        make.width.height.equalTo(@(24));
    }];
    
    [self.topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topIcon);
        make.left.equalTo(self.topIcon.mas_right).offset(6 * kScale);
    }];
    
    UIImageView *rbIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_amsRb_nor"]];
    [_navBar addSubview:rbIv];
    [rbIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(_topIcon);
    }];
    
    [self.view addSubview:self.topShowView];
    [self.topShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(130 * kScale));
        make.top.equalTo(self.view).offset(64 - 130 * kScale);
    }];
    [self.view addSubview:self.coverView];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topShowView.mas_bottom);
    }];
    
    [self.view bringSubviewToFront:_navBar];
    
    [self textViewDidChange:_contentTV];
    [self textViewShouldBeginEditing:_contentTV];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_contentTV becomeFirstResponder];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputEmotion:) name:@"KSelectEmoticon" object:nil];
}

#pragma mark Actions

- (void)showTap:(UITapGestureRecognizer *)tap {
    CGFloat cons = _topShowView.tag == 10 ? 64 : 64 - 130 * kScale;
    [self.topShowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(cons);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        self.coverView.alpha = _topShowView.tag == 10 ? 0.1 : 0;
    }];
    self.topShowView.tag = _topShowView.tag == 10 ? 20 : 10;
    [self.view endEditing:YES];
}

- (void)becomeTap:(UITapGestureRecognizer *)tap {
    if (!_contentTV.isFirstResponder) {
        [_contentTV becomeFirstResponder];
    }
}

#pragma mark - Button Actions

- (void)secretTap:(UITapGestureRecognizer *)tap {
    self.iv_choose1.hidden = NO;
    self.iv_choose2.hidden = YES;
    [self.topIcon sd_setImageWithURL:[NSURL URLWithString:LOGO_SECRET]];
    self.topLb.text = @"匿名";
    [UserInfoInstance sharedUserInfoInstance].isAMS = NO;
    if (!_contentTV.isFirstResponder) {
        [_contentTV becomeFirstResponder];
    }
}

- (void)realTap:(UITapGestureRecognizer *)tap {
    self.iv_choose1.hidden = YES;
    self.iv_choose2.hidden = NO;
    self.topLb.text = @"昵称";
    [self.topIcon sd_setImageWithURL:[NSURL URLWithString:[UserInfoInstance sharedUserInfoInstance].userInfoModel.origin]];
    [UserInfoInstance sharedUserInfoInstance].isAMS = YES;
    if (!_contentTV.isFirstResponder) {
        [_contentTV becomeFirstResponder];
    }
}

- (void)pic_btnClick {
    if (self.imageView.image != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"只能插入一张图片" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
    } else {
        [self showActionSheet];
    }
}

- (void)btnClick:(UIButton *)btn {
    if (_contentTV.inputView == nil) {
        _contentTV.inputView = self.keyboardView;
        [_btn setImage:[UIImage imageNamed:@"ic_keyboard_nor"] forState:UIControlStateNormal];
    } else {
        _contentTV.inputView = nil;
        [_btn setImage:[UIImage imageNamed:@"ic_biaoqing_nor"] forState:UIControlStateNormal];
    }
    [_contentTV reloadInputViews];
}

- (void)showActionSheet {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"相机", @"从相册中选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (void)deleteBtnClick:(UIButton *)btn {
    self.imageView.image = nil;
    self.imageView.hidden = YES;
}

#pragma mark delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            //检查是否支持拍照
            BOOL canTakePicture = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            if (!canTakePicture) {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.tag = 2;
                [alert show];
                return;
            }
            
            UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
            imagepicker.delegate = self;
            imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagepicker animated:YES completion:nil];
            
        }else if (buttonIndex == 1) {
            
            UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
            imagepicker.delegate = self;
            imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagepicker animated:YES completion:nil];
        }
    }
    
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    if ([_contentTV.attributedText length] < 5 || [_contentTV.attributedText length] > 140) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入5-140字以内正文内容!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    NSString *tt = [self dealWithTitle:_contentTV.attributedText];
    if (tt.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入至少5字正文内容!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    self.postFeedAPI.tt = tt;
    
    if (self.imageView.image == nil) {
        [self postContentWithImg];
    } else {
        self.postFeedPicAPI.imageArray = @[self.imageView.image];
        [self.postFeedPicAPI start];
    }
}

- (void)navBar:(NavBar *)navBar leftButtonTapped:(UIButton *)sender {
    [UserInfoInstance sharedUserInfoInstance].postSecretString = _contentTV.attributedText;
    [UserInfoInstance sharedUserInfoInstance].postSecretImage = self.imageView.image;
    [self.view endEditing:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *tempImg = [self scaleImage:image];
    
    if (tempImg == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"图片不能超过3M" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    self.imageView.image = image;
    self.imageView.hidden = NO;
}

#pragma mark textview delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _contentTV.textColor = kUIColorFromRGB(0x666666);
    _contentTV.font = [UIFont systemFontOfSize:15];
    [self.topShowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64 - 130 * kScale);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        self.coverView.alpha = 0;
    }];
    self.topShowView.tag = 10;
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    _lb_contentPlaceHolder.hidden = _contentTV.text.length ? YES : NO;
    NSString *str = [NSString stringWithFormat:@"%zd",140 - textView.attributedText.length];
    self.totalLb.text = str;
}

- (void)inputEmotion:(NSNotification *)noti {
    if (noti.object == nil) {
        [_contentTV deleteBackward];
        return;
    }
    
    CGFloat lineH = _contentTV.font.lineHeight;
    
    EmotionButton *btn = noti.object;
    
    EmotionAttachment *attach = [EmotionAttachment new];
    attach.image = btn.attach.image;
    attach.chs = btn.attach.chs;
    
    attach.bounds = CGRectMake(0, -5, lineH, lineH);
    
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    
    [nmAttrStr addAttributes:@{
                               NSFontAttributeName : _contentTV.font
                               } range:NSMakeRange(0, 1)];
    
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:_contentTV.attributedText];
    
    NSRange range = _contentTV.selectedRange;
    
    [strM replaceCharactersInRange:range withAttributedString:nmAttrStr];
    
    _contentTV.attributedText = strM;
    
    _contentTV.selectedRange = NSMakeRange(range.location + 1, 0);
    
    [_contentTV.delegate textViewDidChange:_contentTV];
}

#pragma mark function

- (UIImage *)scaleImage:(UIImage *)chosedImage {
    
    float nWidth = chosedImage.size.width;
    float nHeight = chosedImage.size.height;
    if (nWidth > 800) {
        float fW = 800.0 / nWidth;
        chosedImage = [SystemUtil scaleImage:chosedImage toScale:fW];
    }
    if (nHeight > 5000) {
        float fh = 5000.0 / nHeight;
        chosedImage = [SystemUtil scaleImage:chosedImage toScale:fh];
    }
    
    NSData *data = UIImageJPEGRepresentation(chosedImage, 0.7);
    
    if ( (data.length / 1024 / 1024) > 3) {
        return nil;
    }
    
    UIImage *img = [UIImage imageWithData:data];
    
    return img;
}

- (NSAttributedString *)changeImageToAttributeString:(UIImage *)image {
    
    CGFloat imageScale = image.size.width / (_contentTV.bounds.size.width - 30 * kScale);
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    attach.bounds = CGRectMake(1, 0, _contentTV.bounds.size.width - 30 * kScale, image.size.height / imageScale);

    NSAttributedString *arrStr = [NSAttributedString attributedStringWithAttachment:attach];
    
    return arrStr;
}

#pragma mark request  post

- (void)postContentWithImg {
    
    NSMutableString *nmStr = [[NSMutableString alloc] init];
    
    [_contentTV.attributedText enumerateAttributesInRange:NSMakeRange(0, _contentTV.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        EmotionAttachment *attach = attrs[@"NSAttachment"];
        if ([attach isKindOfClass:[EmotionAttachment class]]) {
            [nmStr appendString:attach.chs];
        } else {
            [nmStr appendString:[_contentTV.text substringWithRange:range]];
        }
    }];
    
    self.postFeedAPI.c = nmStr;
    
    if (self.imageView.image != nil) {
        self.postFeedAPI.imgs = @[self.imageResponse];
    } else {
        self.postFeedAPI.imgs = nil;
    }
    [self.postFeedAPI start];
}

- (NSString *)dealWithTitle:(NSAttributedString *)tt {
    if (tt.length < 5) {
        return @"";
    }
    NSMutableAttributedString *nmAttrS = [[NSMutableAttributedString alloc] initWithAttributedString:tt];
    NSMutableString *nmTt = [NSMutableString string];
    NSAttributedString *subStr = [nmAttrS attributedSubstringFromRange:NSMakeRange(0, 5)];
    
    [subStr enumerateAttributesInRange:NSMakeRange(0, subStr.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        EmotionAttachment *attach = attrs[@"NSAttachment"];
        if ([attach isKindOfClass:[EmotionAttachment class]]) {
            [nmTt appendString:attach.chs];
        } else {
            [nmTt appendString:[_contentTV.text substringWithRange:range]];
        }
    }];
    
    return nmTt;
}

- (void)requestFailed:(APIBaseRequest *)request {
    [super requestFailed:request];
    NSLog(@"爆料失败");
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);

    if (request == _postFeedPicAPI) {
        self.imageResponse = request.responseJSONObject;
        [self postContentWithImg];
        return;
    }
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        [UserInfoInstance sharedUserInfoInstance].postSecretImage = nil;
        [UserInfoInstance sharedUserInfoInstance].postSecretString = nil;
    }];
}

#pragma mark lazy 

- (GCPlaceholderTextView *)contentTV {
    if (_contentTV == nil) {
        _contentTV = [[GCPlaceholderTextView alloc] init];
        _contentTV.delegate = self;
        _contentTV.attributedText = [UserInfoInstance sharedUserInfoInstance].postSecretString;
        _contentTV.backgroundColor = [UIColor clearColor];
        _contentTV.font = [UIFont systemFontOfSize:15];
        _contentTV.returnKeyType = UIReturnKeyDefault;
        _contentTV.inputAccessoryView = self.input_view;
        _contentTV.textColor = kUIColorFromRGB(0x666666);
        [_contentTV addSubview:self.lb_contentPlaceHolder];
        [_lb_contentPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_contentTV).offset(8);
        }];
    }
    return _contentTV;
}

- (EmotionKeyboardView *)keyboardView {
    if (_keyboardView == nil) {
        _keyboardView = [[EmotionKeyboardView alloc] initWithFrame:CGRectMake(0, 0, 0, 220)];
    }
    return _keyboardView;
}

- (UILabel *)lb_contentPlaceHolder {
    if (_lb_contentPlaceHolder == nil) {
        _lb_contentPlaceHolder = [UILabel new];
        _lb_contentPlaceHolder.textColor = kUIColorFromRGB(0x999999);
        _lb_contentPlaceHolder.font = [UIFont systemFontOfSize:15];
        _lb_contentPlaceHolder.text = self.tt == nil ? @"请输入爆料内容 (140字以内)" : self.tt;
    }
    return _lb_contentPlaceHolder;
}

- (UIView *)input_view {
    if (_input_view == nil) {
        _input_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _nMainViewWidth, 98 / 2)];
        _input_view.backgroundColor = [UIColor whiteColor];
        
        //inputAccessaryView
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _nMainViewWidth, 1)];
        topView.backgroundColor = [UIColor colorWithRed:211 green:211 blue:211 alpha:1];
        [_input_view addSubview:topView];
        
        //图片选择 button
        UIButton *pic_btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [pic_btn setImage:[UIImage imageNamed:@"ic_image_nor1"] forState:UIControlStateNormal];
        [pic_btn setImage:[UIImage imageNamed:@"ic_image_dis"] forState:UIControlStateDisabled];
        [_input_view addSubview:pic_btn];
        [pic_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.input_view);
            make.right.equalTo(self.input_view).offset(-70);
        }];
        [pic_btn addTarget:self action:@selector(pic_btnClick) forControlEvents:UIControlEventTouchUpInside];
        pic_btn.tag = 9;
        
        //emotion
        [_input_view addSubview:self.btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_input_view).offset(-15 * kScale);
            make.centerY.equalTo(_input_view);
        }];
        
        //上方1 px 横线
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _nMainViewWidth, 1)];
        topLine.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
        [_input_view addSubview:topLine];
        
    }
    return _input_view;
}

- (PostFeedPicAPI *)postFeedPicAPI {
    if (_postFeedPicAPI == nil) {
        _postFeedPicAPI = [PostFeedPicAPI new];
        _postFeedPicAPI.animatingView = self.view;
        _postFeedPicAPI.animatingText = @"数据提交中";
        _postFeedPicAPI.delegate = self;
    }
    return _postFeedPicAPI;
}

- (PostFeedAPI *)postFeedAPI {
    if (_postFeedAPI == nil) {
        _postFeedAPI = [[PostFeedAPI alloc] init];
        _postFeedAPI.animatingView = self.view;
        _postFeedAPI.animatingText = @"数据提交中";
        _postFeedAPI.delegate = self;
        _postFeedAPI.st = @0;
        _postFeedAPI.uid = [SystemUtil getCache:USER_ID];
        _postFeedAPI.tt = @"匿名爆料";
        _postFeedAPI.c = @"";
        _postFeedAPI.stag_code = @"yc";
        _postFeedAPI.res_code = @"S_DISCLOSE";
        _postFeedAPI.pid = self.pid == nil ? @"" : self.pid;
        _postFeedAPI.ams = [UserInfoInstance sharedUserInfoInstance].isAMS ? @"N" : @"Y";
        _postFeedAPI.st = @0;
    }
    return _postFeedAPI;
}

- (UIButton *)btn {
    if (_btn == nil) {
        _btn = [[UIButton alloc] init];
        [_btn setImage:[UIImage imageNamed:@"ic_biaoqing_nor"] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = [UserInfoInstance sharedUserInfoInstance].postSecretImage;
        _imageView.hidden = [UserInfoInstance sharedUserInfoInstance].postSecretImage == nil ? YES : NO;
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"ic_postImage_delete_nor"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setAdjustsImageWhenHighlighted:NO];
        [_imageView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(_imageView);
        }];
    }
    return _imageView;
}

- (UILabel *)totalLb {
    if (_totalLb == nil) {
        _totalLb = [UILabel new];
        _totalLb.font = [UIFont systemFontOfSize:11 * kScale];
        _totalLb.textColor = kUIColorFromRGB(0x666666);
    }
    return _totalLb;
}

#pragma mark lazy top

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [UIView new];
        _coverView.backgroundColor = kUIColorFromRGB(0x000000);
        _coverView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(becomeTap:)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (UIImageView *)topIcon {
    if (_topIcon == nil) {
        _topIcon = [UIImageView new];
        _topIcon.layer.cornerRadius = 12;
        _topIcon.layer.masksToBounds = YES;
        BOOL isAMS = [UserInfoInstance sharedUserInfoInstance].isAMS;
        [_topIcon sd_setImageWithURL:[NSURL URLWithString:!isAMS ? LOGO_SECRET : [UserInfoInstance sharedUserInfoInstance].userInfoModel.origin]];
        _topIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTap:)];
        [_topIcon addGestureRecognizer:tap];
    }
    return _topIcon;
}

- (UILabel *)topLb {
    if (_topLb == nil) {
        _topLb = [UILabel new];
        _topLb.textColor = kUIColorFromRGB(0x333333);
        _topLb.font = [UIFont boldSystemFontOfSize:19 * kScale];
        _topLb.text = [UserInfoInstance sharedUserInfoInstance].isAMS == NO ? @"匿名" : @"昵称";
        _topLb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTap:)];
        [_topLb addGestureRecognizer:tap];
    }
    return _topLb;
}

- (UIView *)topShowView {
    if (_topShowView == nil) {
        _topShowView = [UIView new];
        _topShowView.tag = 10;
        _topShowView.backgroundColor = [UIColor whiteColor];
        [_topShowView addSubview:self.iv_secret];
        [_topShowView addSubview:self.iv_real];
        [_topShowView addSubview:self.lb_real];
        [_topShowView addSubview:self.lb_secret];
        [_topShowView addSubview:self.iv_choose1];
        [_topShowView addSubview:self.iv_choose2];
        
        [self.iv_secret mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_topShowView).offset(-15);
            make.centerX.equalTo(_topShowView).offset(-70 * kScale);
            make.width.height.equalTo(@(60 * kScale));
        }];
        
        [self.lb_secret mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iv_secret);
            make.top.equalTo(self.iv_secret.mas_bottom).offset(6 * kScale);
        }];
        
        [self.iv_choose1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.iv_secret);
        }];
        
        [self.iv_real mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.width.height.equalTo(self.iv_secret);
            make.centerX.equalTo(_topShowView).offset(70 * kScale);
        }];
        
        [self.lb_real mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iv_real);
            make.top.equalTo(self.iv_real.mas_bottom).offset(6 * kScale);
        }];
        
        [self.iv_choose2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.iv_real);
        }];
    }
    return _topShowView;
}

- (UIImageView *)iv_secret {
    if (_iv_secret == nil) {
        _iv_secret = [UIImageView new];
        _iv_secret.layer.cornerRadius = 30 * kScale;
        _iv_secret.layer.masksToBounds = YES;
        [_iv_secret sd_setImageWithURL:[NSURL URLWithString:LOGO_SECRET]];
        _iv_secret.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secretTap:)];
        [_iv_secret addGestureRecognizer:tap];
    }
    return _iv_secret;
}

- (UIImageView *)iv_real {
    if (_iv_real == nil) {
        _iv_real = [UIImageView new];
        [_iv_real sd_setImageWithURL:[NSURL URLWithString:[UserInfoInstance sharedUserInfoInstance].userInfoModel.origin]];
        _iv_real.layer.cornerRadius = 30 * kScale;
        _iv_real.layer.masksToBounds = YES;
        _iv_real.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(realTap:)];
        [_iv_real addGestureRecognizer:tap];
    }
    return _iv_real;
}

- (UILabel *)lb_secret {
    if (_lb_secret == nil) {
        _lb_secret = [UILabel new];
        _lb_secret.text = @"匿名";
        _lb_secret.font = [UIFont systemFontOfSize:14 * kScale];
        _lb_secret.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_secret.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secretTap:)];
        [_lb_secret addGestureRecognizer:tap];
    }
    return _lb_secret;
}

- (UILabel *)lb_real {
    if (_lb_real == nil) {
        _lb_real = [UILabel new];
        _lb_real.textColor = kUIColorFromRGB(0xb2b2b2);
        _lb_real.font = [UIFont systemFontOfSize:14 * kScale];
        _lb_real.text = [UserInfoInstance sharedUserInfoInstance].userInfoModel.n;
        _lb_real.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(realTap:)];
        [_lb_real addGestureRecognizer:tap];
    }
    return _lb_real;
}

- (UIImageView *)iv_choose1 {
    if (_iv_choose1 == nil) {
        _iv_choose1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_ams_choose_nor"]];
        _iv_choose1.hidden = [UserInfoInstance sharedUserInfoInstance].isAMS;
    }
    return _iv_choose1;
}

- (UIImageView *)iv_choose2 {
    if (_iv_choose2 == nil) {
        _iv_choose2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_ams_choose_nor"]];
        _iv_choose2.hidden = ![UserInfoInstance sharedUserInfoInstance].isAMS;
    }
    return _iv_choose2;
}

@end
