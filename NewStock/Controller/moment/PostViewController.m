//
//  PostViewController.m
//  NewStock
//
//  Created by Willey on 16/9/20.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PostViewController.h"
#import <SDWebImageDownloader.h>
#import "AppDelegate.h"
#import "NewMomentViewController.h"

#define color_noSelected [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]
#define color_selected [UIColor colorWithRed:53/255.0 green:142/255.0 blue:231/255.0 alpha:1]
#define RGBHexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]

@interface PostViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic) UIView *input_view; // 键盘 inputacessaryView

@property (nonatomic) UIButton *last_left_btn; //用来记录 原创,转载 或者 爆料

@property (nonatomic) UIButton *last_right_btn; //用来记录 公开, 或者匿名

@property (nonatomic) NSMutableArray *image_array; //用来保存 正文中的图片

@property (nonatomic) NSMutableString *server_Str; //转换后的文字内容

@property (nonatomic) NSMutableArray *imageUrl_array; //图片地址 url数组

@property (nonatomic) NSMutableArray *attach_array; // 保存 attach

@property (nonatomic, assign) BOOL isSaveContent; //是否是保存草稿

@property (nonatomic, assign) BOOL isPosting;     //保存正在发帖状态

@property (nonatomic) UILabel *lb_titlePlaceHolder; // title 占位文本

@property (nonatomic) UILabel *lb_contentPlaceHolder; //content 占位文本

@property (nonatomic) UIButton *img_btn; //全局 imgbtn

//@property (nonatomic, assign) NSInteger totalImgLength; //保存所有图片大小和

@end

@implementation PostViewController

- (UILabel *)lb_titlePlaceHolder {
    if (_lb_titlePlaceHolder == nil) {
        _lb_titlePlaceHolder = [[UILabel alloc]init];
        _lb_titlePlaceHolder.text = @"写个有意思的标题吧...(35字以内)";
        _lb_titlePlaceHolder.font = [UIFont boldSystemFontOfSize:20];
        _lb_titlePlaceHolder.textColor = kUIColorFromRGB(0x999999);
    }
    return _lb_titlePlaceHolder;
}

- (UILabel *)lb_contentPlaceHolder {
    if (_lb_contentPlaceHolder == nil) {
        _lb_contentPlaceHolder = [UILabel new];
        _lb_contentPlaceHolder.textColor = kUIColorFromRGB(0x999999);
        _lb_contentPlaceHolder.font = [UIFont systemFontOfSize:15];
        _lb_contentPlaceHolder.text = @" 正文内容，展现你的最强大脑...";
    }
    return _lb_contentPlaceHolder;
}

- (NSMutableArray *)attach_array {
    if (_attach_array == nil) {
        _attach_array = [NSMutableArray arrayWithCapacity:self.imageUrl_array.count];
    }
    return _attach_array;
}

- (NSMutableArray *)imageUrl_array {
    if (_imageUrl_array == nil) {
        _imageUrl_array = [NSMutableArray array];
    }
    return _imageUrl_array;
}

- (NSMutableArray *)image_array {
    if (_image_array == nil) {
        _image_array = [NSMutableArray array];
        [_contentTV.attributedText enumerateAttributesInRange:NSMakeRange(0, _contentTV.text.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if ([attrs.allKeys containsObject:@"NSAttachment"]) {
                NSTextAttachment *attach = attrs[@"NSAttachment"];
                [_image_array addObject:attach.image];
            }
        }];
    }
    return _image_array;
}

- (NSMutableString *)server_Str {
    if (_server_Str == nil) {
        _server_Str = [NSMutableString string];
    }
    return _server_Str;
}

- (UIView *)input_view {
    if (_input_view == nil) {
        _input_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _nMainViewWidth, 98 / 2)];
        _input_view.backgroundColor = [UIColor whiteColor];
        
        //inputAccessaryView
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _nMainViewWidth, 1)];
        topView.backgroundColor = [UIColor colorWithRed:211 green:211 blue:211 alpha:1];
        [_input_view addSubview:topView];
        
        //原创 btn
        UIButton *yuan_btn = [UIButton new];
        [yuan_btn setTitle:@"原创" forState:UIControlStateNormal];
        [yuan_btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [yuan_btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        [yuan_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [yuan_btn setBackgroundColor:kButtonBGColor];
        [_input_view addSubview:yuan_btn];
        [yuan_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_input_view).offset(30 / 2);
            make.height.equalTo(@(48 / 2));
            make.width.equalTo(@(80 / 2));
            make.centerY.equalTo(_input_view);
        }];
        yuan_btn.selected = YES;
        yuan_btn.tag = 1;
        self.last_left_btn = yuan_btn;
        [yuan_btn addTarget:self action:@selector(btnModeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //转载 btn
        UIButton *zhuan_btn = [UIButton new];
        [zhuan_btn setTitle:@"转载" forState:UIControlStateNormal];
        [zhuan_btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [zhuan_btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        [zhuan_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [zhuan_btn setBackgroundColor:color_noSelected];
        [_input_view addSubview:zhuan_btn];
        [zhuan_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(yuan_btn.mas_right);
            make.centerY.height.width.equalTo(yuan_btn);
        }];
        zhuan_btn.tag = 2;
        [zhuan_btn addTarget:self action:@selector(btnModeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //图片选择 button
        UIButton *pic_btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [pic_btn setImage:[UIImage imageNamed:@"ic_image_nor1"] forState:UIControlStateNormal];
        [pic_btn setImage:[UIImage imageNamed:@"ic_image_dis"] forState:UIControlStateDisabled];
        [_input_view addSubview:pic_btn];
        [pic_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_input_view).offset(-15 * kScale);
            make.centerY.equalTo(_input_view);
        }];
        [pic_btn addTarget:self action:@selector(pic_btnClick) forControlEvents:UIControlEventTouchUpInside];
        pic_btn.tag = 9;
        
        //上方1 px 横线
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _nMainViewWidth, 1)];
        topLine.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
        [_input_view addSubview:topLine];
        
    }
    return _input_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发帖";
    [_navBar setTitle:self.title];
    [_navBar setLeftBtnTitle:@"取消"];
    _navBar.line_view.hidden = YES;
    
    [self setRightBtnTitle:@"提交"];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    _titleTV = [[GCPlaceholderTextView alloc] init];
    _titleTV.delegate = self;
    _titleTV.backgroundColor = [UIColor clearColor];
    _titleTV.font = [UIFont systemFontOfSize:20];
    _titleTV.returnKeyType = UIReturnKeyDone;

    _titleTV.returnKeyType = UIReturnKeyNext;
    [_mainView addSubview:_titleTV];
    [_titleTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleTV.superview).offset(10);
        make.top.equalTo(_titleTV.superview).offset(5);
        make.width.equalTo(@(_nMainViewWidth - 20));
        make.height.equalTo(@30);
    }];
    [_titleTV addSubview:self.lb_titlePlaceHolder];
    [_lb_titlePlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleTV).offset(5);
        make.top.equalTo(_titleTV).offset(10);
    }];
    
    _titleTV.inputAccessoryView = self.input_view;
    self.img_btn = [self.input_view viewWithTag:9];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    [_mainView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.superview).offset(15);
        make.top.equalTo(_titleTV.mas_bottom).offset(10);
        make.width.equalTo(@(_nMainViewWidth - 30));
        make.height.equalTo(@0.5);
    }];
    
    _contentTV = [[GCPlaceholderTextView alloc] init];
    _contentTV.delegate = self;
    _contentTV.backgroundColor = [UIColor clearColor];
    _contentTV.font = [UIFont systemFontOfSize:15];
    _contentTV.returnKeyType = UIReturnKeyDefault;
//    _contentTV.placeholder = @"正文内容，展现你的最强大脑...";
    _contentTV.inputAccessoryView = self.input_view;
    _contentTV.textColor = kUIColorFromRGB(0x666666);
    [_mainView addSubview:_contentTV];
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentTV.superview).offset(10);
        make.top.equalTo(lineView.mas_bottom).offset(15);
        make.width.equalTo(@(_nMainViewWidth - 20));
        make.height.equalTo(@(_nMainViewHeight - 340));
    }];
    
    [_contentTV addSubview:self.lb_contentPlaceHolder];
    [_lb_contentPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_contentTV).offset(5);
    }];
    [_mainView layoutIfNeeded];
    
    if(self.titleStr) {
        _titleTV.text = self.titleStr;
    }

    if(self.contentStr) {
        [self dealWithContentTV_text];
    }
    
    if(self.stag_code) {
        if ([self.stag_code isEqualToString:@"yc"] || [self.stag_code isEqualToString:@"bl"]) {
            [self btnModeClick:[self.input_view viewWithTag:1]];
        }  else if([self.stag_code isEqualToString:@"zz"]) {
            [self btnModeClick:[self.input_view viewWithTag:2]];
        }
    } else {
        _stag_code = @"yc";
    }
    
    _ams = @"N";
    
    _postFeedPicAPI = [PostFeedPicAPI new];
    _postFeedPicAPI.animatingView = _mainView;
    _postFeedPicAPI.animatingText = @"数据提交中";
    
    _postFeedAPI = [[PostFeedAPI alloc] init];
    _postFeedAPI.animatingView = _mainView;
    _postFeedAPI.animatingText = @"数据提交中";
    _postFeedAPI.st = @0;
    _postFeedAPI.res_code = @"S_FORUM";
    [_titleTV becomeFirstResponder];
    
    _mainView.backgroundColor = [UIColor whiteColor];
}

- (void)postContent {
    if ([_titleTV.text length] <= 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入标题!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if ([_titleTV.text length] > 35) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入35字以内的标题!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if ([_contentTV.text length] <= 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正文内容!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if ([SystemUtil isSignIn] && !_isPosting) {
        _postFeedPicAPI.delegate = self;
        _postFeedPicAPI.imageArray = self.image_array;
        _isPosting = YES;
        if (self.image_array.count) {
            [self isOutTenM:^(BOOL b) {
                if (b) {
                    return;
                }else {
                    [_postFeedPicAPI start];
                }
            }];
        }else {
            [self postContestAndImages:NO];
        }
    }
    
}

- (void)saveContent {
    _postFeedAPI.delegate = nil;
    _postFeedAPI.st = @4;
    _postFeedAPI.uid = [SystemUtil getCache:USER_ID];
    if(self.fid)_postFeedAPI.fid = self.fid;
    _postFeedAPI.tt = _titleTV.text;
    _postFeedAPI.c = self.server_Str.length ? self.server_Str.copy : _contentTV.text;
    _postFeedAPI.stag_code = _stag_code;
    _postFeedAPI.ams = _ams;
    
    [_postFeedAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSLog(@"%@",_postFeedAPI.responseJSONObject);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = 1001;
        [_contentTV resignFirstResponder];
        [_titleTV resignFirstResponder];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView show];
        });
    } failure:^(APIBaseRequest *request) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"草稿保存失败!" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)requestFinished:(APIBaseRequest *)request {
    
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    if ([request.responseJSONObject isKindOfClass:[NSArray class]]) {
        NSInteger index = 0;
        for (NSDictionary *dict in request.responseJSONObject) {
            UIImage *image = self.image_array[index];
            NSString *str = [NSString stringWithFormat:@"<img src=\"%@\" alt=\"\" width=\"%lf\" height=\"%lf\" />",dict[@"origin"],image.size.width,image.size.height];
            [self.imageUrl_array addObject:str];
            index ++;
        }
    }else {
        NSDictionary *dict = request.responseJSONObject;
        if ([dict.allKeys containsObject:@"origin"]) {
            UIImage *image = self.image_array[0];
            NSString *str = [NSString stringWithFormat:@"<img src=\"%@\" alt=\"\" width=\"%lf\" height=\"%lf\" />",dict[@"origin"],image.size.width,image.size.height];
            [self.imageUrl_array addObject:str];
        }
    }
    
    if (_isSaveContent) {
        
        [_contentTV.attributedText enumerateAttributesInRange:NSMakeRange(0, _contentTV.text.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if ([attrs.allKeys containsObject:@"NSAttachment"]) {
                NSTextAttachment *arrach = attrs[@"NSAttachment"];
                [self.server_Str appendString:self.imageUrl_array[(NSInteger)arrach.bounds.origin.x]];
            }else {
                [self.server_Str appendString:[_contentTV.text substringWithRange:range]];
            }
        }];
        
        [self.image_array removeAllObjects];
        [self.imageUrl_array removeAllObjects];
        [self saveContent];
        return;
    }
    
    if (self.imageUrl_array.count && _isSaveContent == NO) {
        [self postContestAndImages:YES];
        return;
    }
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    alertView.tag = 1001;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [alertView show];
//    });
    [_contentTV resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [super requestFailed:request];
    NSLog(@"failed:%@",request.responseJSONObject);
    _isPosting = NO;
}

- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender {
    //发帖
    [self postContent];
}

- (void)navBar:(NavBar*)navBar leftButtonTapped:(UIButton*)sender {
    if (([_titleTV.text length]>0)||([_contentTV.text length]>0)) {
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:@"删除草稿"
                                                         otherButtonTitles:@"保存草稿", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        actionSheet.tag = 2;
        [actionSheet showInView:self.view];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{}];
        [_contentTV resignFirstResponder];
        [_titleTV resignFirstResponder];
    }
}

- (void)btnModeClick:(UIButton *)btn {
    
    self.last_left_btn.selected = NO;
    self.last_left_btn.backgroundColor = color_noSelected;
    self.last_left_btn = btn;
    btn.selected = YES;
    btn.backgroundColor = kButtonBGColor;
    
    if (btn.tag == 1) {
        _stag_code = @"yc";
    }else if (btn.tag == 2) {
        _stag_code = @"zz";
    }
    
}

- (void)pic_btnClick {
    [self showActionSheet];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *tempImg = [self scaleImage:image];
    
    if (tempImg == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"图片不能超过3M" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    [self.image_array addObject:tempImg];
    
    NSMutableAttributedString *nmStr = [[NSMutableAttributedString alloc]initWithAttributedString:_contentTV.attributedText];
    
    NSRange lastRange = _contentTV.selectedRange;
    
    [nmStr replaceCharactersInRange:lastRange withAttributedString:[self changeImageToAttributeString:tempImg]];
    
    [nmStr appendAttributedString:[[NSAttributedString alloc]initWithString:@""]];
    
    _contentTV.attributedText = nmStr;
    
    [_contentTV becomeFirstResponder];
    
    _contentTV.selectedRange = NSMakeRange(lastRange.location + 2, 0);
    
    [self textViewDidChange:_contentTV];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            //检查是否支持拍照
            BOOL canTakePicture = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            if (!canTakePicture)
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.tag = 2;
                [alert show];
                return;
            }
            
            UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
            imagepicker.delegate = self;
//            imagepicker.allowsEditing = YES;
            imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagepicker animated:YES completion:nil];
            
        }else if (buttonIndex == 1) {
            
            UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
            imagepicker.delegate = self;
//            imagepicker.allowsEditing = YES;
            imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagepicker animated:YES completion:nil];
        }
    }
    
    if (actionSheet.tag == 2) {
        [self saveWithIndex:buttonIndex];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
        [_contentTV resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (alertView.tag == 10001) {
        if (buttonIndex == 0) {
            [self popLoginViewController];
        }
    }
}

- (void)saveWithIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        //保存草稿 是否将内容保存至草稿箱
        {
            if ([_titleTV.text length] > 35) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的标题过长!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                return;
            }
            
            if ([_titleTV.text length] <= 0) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有标题" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                return;
            }
            
            if ([SystemUtil isSignIn] && _isPosting == NO) {
                _isPosting = YES;
                if (self.image_array.count) {
                    
                    [self isOutTenM:^(BOOL b) {
                        if (b) {
                            return ;
                        }else {
                            _postFeedPicAPI.delegate = self;
                            _postFeedPicAPI.imageArray = self.image_array;
                            _isSaveContent = YES;
                            [_postFeedPicAPI start];
                        }
                    }];

                }else {
                    [self saveContent];
                }
                
            } else {
                [self popLoginViewController];
            }
        }
    } else if (buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:^{}];
        [_contentTV resignFirstResponder];
        [_titleTV resignFirstResponder];
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    if (textView == _titleTV) {
        self.img_btn.enabled = NO;
        textView.textColor = [UIColor blackColor];
    } else {
        self.img_btn.enabled = YES;
        _contentTV.textColor = kUIColorFromRGB(0x666666);
        _contentTV.font = [UIFont systemFontOfSize:15];
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView == _contentTV) {
        
        _lb_contentPlaceHolder.hidden = _contentTV.text.length ? YES : NO;
        
        if ([_contentTV.text hasPrefix:@" "]) {
            _contentTV.text = [_contentTV.text substringFromIndex:1];
        }
        
    } else {
        _lb_titlePlaceHolder.hidden = textView.text.length ? YES : NO;

        if (textView.contentSize.height > 41) {
            [_titleTV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@55);
            }];
        } else {
            [_titleTV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@30);
            }];
        }
        [_mainView layoutIfNeeded];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (textView == _titleTV) {
        
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            [_contentTV becomeFirstResponder];
            return NO;
        }
        if (textView.text.length > 35) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示!" message:@"标题太长啦" preferredStyle:1];
            [self presentViewController:alertC animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alertC dismissViewControllerAnimated:YES completion:nil];
                    if (textView.text.length > 35) {
                        NSString *subStr = [textView.text substringToIndex:34];
                        textView.text = subStr;
                    }
                });
            }];
            return NO;
        }
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _titleTV) {
        if (scrollView.contentOffset.y != 7) {
            scrollView.contentOffset = CGPointMake(0, 7);
        }
    }
}

- (void)postContestAndImages:(BOOL)hasImage {
    
    NSString *tt = [_titleTV.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (tt == nil) {
        tt = _titleTV.text;
    }
    NSString *c = _contentTV.text;
    
    if (hasImage) {
        [_contentTV.attributedText enumerateAttributesInRange:NSMakeRange(0, _contentTV.text.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if ([attrs.allKeys containsObject:@"NSAttachment"]) {
                NSTextAttachment *arrach = attrs[@"NSAttachment"];
                [self.server_Str appendString:self.imageUrl_array[(NSInteger)arrach.bounds.origin.x]];
            }else {
                [self.server_Str appendString:[_contentTV.text substringWithRange:range]];
            }
        }];
        c = self.server_Str.copy;
        [self.image_array removeAllObjects];
        [self.imageUrl_array removeAllObjects];
    }

    _postFeedAPI.delegate = self;
    _postFeedAPI.st = @0;
    _postFeedAPI.uid = [SystemUtil getCache:USER_ID];
    _postFeedAPI.tt = tt;
    _postFeedAPI.c = c;
    _postFeedAPI.stag_code = _stag_code;
    _postFeedAPI.ams = _ams;
    [_postFeedAPI start];
    
}

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

- (void)dealWithContentTV_text {

    NSMutableAttributedString *nmStr = [NSMutableAttributedString new];
    NSError *error = NULL;
    NSString *partten =   @"<img src=\"(.*?)\" alt=\"\" width=\"(.*?)\" height=\"(.*?)\" />";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:partten options:0 error:&error];
    
    NSInteger __block index = 0;
    [regex enumerateMatchesInString:self.contentStr options:0 range:NSMakeRange(0, self.contentStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        //拼接图片前部分字符串
        NSString *subStr = [_contentStr substringWithRange:NSMakeRange(index, result.range.location - index)];
        index = result.range.location + result.range.length;
        NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:subStr];
        [nmStr appendAttributedString:attStr];
        
        //拼接图片附件
        [self.imageUrl_array addObject:[_contentStr substringWithRange:[result rangeAtIndex:1]]];
        NSString *widthStr = [_contentStr substringWithRange:[result rangeAtIndex:2]];
        NSString *heightStr = [_contentStr substringWithRange:[result rangeAtIndex:3]];
        CGSize imageSize = CGSizeMake(widthStr.floatValue, heightStr.floatValue);
        NSAttributedString *imgStr = [self changeImageToAttributeString:[self getPlaceHolderWithScaleImageSize:imageSize]];
        
        [nmStr appendAttributedString:imgStr];
        
    }];
    
    if (nmStr.length) {
        _contentTV.attributedText = nmStr.copy;
    }else {
        _contentTV.text = self.contentStr;
    }
    
    [self textViewDidChange:_contentTV];
    //下载图片 给 attach 赋值
    for (int i = 0; i < self.imageUrl_array.count; i ++) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.imageUrl_array[i]] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            NSTextAttachment *attach = self.attach_array[i];
            attach.image = image;
            [self.image_array addObject:image];
            if (self.image_array.count == self.attach_array.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_contentTV becomeFirstResponder];
                    [self.view endEditing:YES];
                    [_contentTV becomeFirstResponder];
                });
            }
        }];
    }
    self.lb_contentPlaceHolder.hidden = YES;
    self.lb_titlePlaceHolder.hidden = YES;
    self.imageUrl_array = nil;
}

- (UIImage *)getPlaceHolderWithScaleImageSize:(CGSize)size {

    CGFloat w = _contentTV.bounds.size.width - 30;
//    CGFloat scale = w / size.width;
    CGFloat h = (size.height / size.width ) * w;
    UIImage *chooseImage = [UIImage imageNamed:@"launchBg"];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), NO, 0);
    [chooseImage drawInRect:CGRectMake(0, 0, w, h)];
    chooseImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    return chooseImage;
}

- (NSAttributedString *)changeImageToAttributeString:(UIImage *)image {
    
    CGFloat imageScale = image.size.width / (_contentTV.bounds.size.width - 30);
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    attach.bounds = CGRectMake(self.attach_array.count, 0, _contentTV.bounds.size.width - 30, image.size.height / imageScale);
    [self.attach_array addObject:attach];
    NSAttributedString *arrStr = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *imageText = [[NSMutableAttributedString alloc]initWithString:@""];
    
    [imageText appendAttributedString:arrStr];
    return imageText;
}

- (void)isOutTenM:(void(^)(BOOL))block {
    
    __block NSInteger totalLength = 0;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (UIImage *img in self.image_array) {
            totalLength += UIImageJPEGRepresentation(img, 0.7).length;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ((totalLength / 1024 / 1024) > 10) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"图片总大小不能超过10M" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                _isPosting = NO;
                block(YES);
            }else {
                block(NO);
            }
        });

    });

}

@end
