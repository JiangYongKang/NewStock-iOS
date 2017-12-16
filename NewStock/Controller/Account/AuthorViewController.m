//
//  AuthorViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/4/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "AuthorViewController.h"
#import "ContentViewController.h"
#import "WebViewController.h"
#import "Defination.h"
#import <Masonry.h>
#import "PostFeedPicAPI.h"
#import "UserVertifyAPI.h"
#import "GetMyVertifyAPI.h"
#import "MyVertifyView.h"
#import "MyVertifyInfoModel.h"

@interface AuthorViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UITextField *tf_name;
@property (nonatomic, strong) UITextField *tf_idNum;
@property (nonatomic, strong) UITextField *tf_nickName;
@property (nonatomic, strong) UITextView *tv_reason;
@property (nonatomic, strong) UIImageView *imageV1;
@property (nonatomic, strong) UIImageView *imageV2;
@property (nonatomic, strong) UIImageView *imageV3;
@property (nonatomic, strong) UIImageView *imageV4;
@property (nonatomic, strong) UIImageView *imageV5;
@property (nonatomic, strong) UIImageView *imageV6;
@property (nonatomic, strong) UILabel *lb_tvPlaceHolder;
@property (nonatomic, assign) CGFloat scrollHeight;
@property (nonatomic, strong) UIButton *btn_allow;
@property (nonatomic, strong) UIButton *btn_proxy;
@property (nonatomic, strong) NSMutableArray *nmArr;
@property (nonatomic, assign) BOOL hasImg1;
@property (nonatomic, assign) BOOL hasImg2;
@property (nonatomic, assign) BOOL hasImg3;
@property (nonatomic, assign) BOOL hasImg4;
@property (nonatomic, assign) BOOL hasImg5;
@property (nonatomic, assign) BOOL hasImg6;

@property (nonatomic, strong) PostFeedPicAPI *postImgAPI;
@property (nonatomic, strong) UserVertifyAPI *userVertifyAPI;
@property (nonatomic, strong) GetMyVertifyAPI *getMyVertifyAPI;

@property (nonatomic, strong) MyVertifyView *myVertifyView;

@property (nonatomic, strong) UIButton *reVertifyBtn;

@end

@implementation AuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    _scrollView.delegate = self;
    
    [_mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(MAIN_SCREEN_WIDTH));
        make.height.equalTo(@(875 * kScale));
        make.edges.equalTo(_scrollView);
    }];
    
    _mainView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTap)];
    [_mainView addGestureRecognizer:tap];
    
    self.title = @"身份认证";
    [_navBar setTitle:self.title];
    
    [self.view addSubview:self.myVertifyView];
    [self.myVertifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    [self getMyVertifyInfo];
    
}

- (void)getMyVertifyInfo {
    [_navBar setRightBtnImg:nil];
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"navbar_back"]];
    [self.getMyVertifyAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        if (request.responseJSONObject == nil) {
            [self setupUI];
            self.myVertifyView.hidden = YES;
        } else {
            self.myVertifyView.hidden = NO;
            NSLog(@"%@",request.responseJSONObject);
            MyVertifyInfoModel *model = [MTLJSONAdapter modelOfClass:[MyVertifyInfoModel class] fromJSONDictionary:request.responseJSONObject error:nil];
            self.myVertifyView.model = model;
            if (model.st.integerValue == 2) {
                self.reVertifyBtn.hidden = NO;
            }
        }
    } failure:^(__kindof APIBaseRequest *request) {
        [super requestFailed:request];
    }];
}

- (void)setupUI {
    
    [_navBar setRightBtnTitle:@"提交"];
    [_navBar setLeftBtnTitle:@"取消"];
    
    [_mainView addSubview:self.tf_name];
    [_mainView addSubview:self.tf_idNum];
    
    [self.tf_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44 * kScale));
        make.left.equalTo(_mainView).offset(24 * kScale);
        make.right.equalTo(_mainView).offset(-24 * kScale);
        make.top.equalTo(_mainView).offset(10 * kScale);
    }];
    
    [self.tf_idNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.tf_name);
        make.top.equalTo(self.tf_name.mas_bottom).offset(10 * kScale);
    }];
    
    UILabel *topLb = [UILabel new];
    topLb.text = @"请上传您的身份证信息";
    topLb.font = [UIFont systemFontOfSize:14 * kScale];
    topLb.textColor = kUIColorFromRGB(0x333333);
    
    [_mainView addSubview:topLb];
    [topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_name);
        make.top.equalTo(_tf_idNum.mas_bottom).offset(30 * kScale);
    }];
    
    [_mainView addSubview:self.imageV1];
    [_mainView addSubview:self.imageV2];
    [_mainView addSubview:self.imageV3];
    
    [self.imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_name);
        make.top.equalTo(topLb.mas_bottom).offset(15 * kScale);
        make.width.equalTo(@(100 * kScale));
        make.height.equalTo(@(74 * kScale));
    }];
    
    [self.imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_mainView);
        make.width.height.equalTo(self.imageV1);
        make.top.equalTo(self.imageV1);
    }];
    
    [self.imageV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tf_name);
        make.top.width.height.equalTo(self.imageV1);
    }];
    
    UILabel *lb_idcard = [[UILabel alloc] init];
    lb_idcard.text = @"身份证正面";
    lb_idcard.font = [UIFont systemFontOfSize:12 * kScale];
    lb_idcard.textColor = kUIColorFromRGB(0x333333);
    
    UILabel *lb_idcardRev = [[UILabel alloc] init];
    lb_idcardRev.text = @"身份证背面";
    lb_idcardRev.font = [UIFont systemFontOfSize:12 * kScale];
    lb_idcardRev.textColor = kUIColorFromRGB(0x333333);
    
    UILabel *lb_idcardHand = [[UILabel alloc] init];
    lb_idcardHand.text = @"手持身份证正面照";
    lb_idcardHand.font = [UIFont systemFontOfSize:12 * kScale];
    lb_idcardHand.textColor = kUIColorFromRGB(0x333333);
    
    [_mainView addSubview:lb_idcard];
    [_mainView addSubview:lb_idcardRev];
    [_mainView addSubview:lb_idcardHand];
    
    [lb_idcard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV1.mas_bottom).offset(15 * kScale);
        make.centerX.equalTo(self.imageV1);
    }];
    
    [lb_idcardRev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV1.mas_bottom).offset(15 * kScale);
        make.centerX.equalTo(self.imageV2);
    }];
    
    [lb_idcardHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV1.mas_bottom).offset(15 * kScale);
        make.centerX.equalTo(self.imageV3);
    }];
    
    UILabel *grayLb = [UILabel new];
    grayLb.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [_mainView addSubview:grayLb];
    [grayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_mainView);
        make.top.equalTo(lb_idcardHand.mas_bottom).offset(23 * kScale);
        make.height.equalTo(@(10 * kScale));
    }];
    
    [_mainView addSubview:self.tf_nickName];
    [self.tf_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tf_name);
        make.top.equalTo(grayLb.mas_bottom).offset(10 * kScale);
        make.height.equalTo(@(49 * kScale));
    }];
    
    [_mainView addSubview:self.tv_reason];
    [self.tv_reason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_tf_name);
        make.left.equalTo(_tf_name).offset(-2);
        make.top.equalTo(self.tf_nickName.mas_bottom).offset(5);
        make.height.equalTo(@(141 * kScale));
    }];
    
    UILabel *graylb1 = [UILabel new];
    graylb1.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [_mainView addSubview:graylb1];
    [graylb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_mainView);
        make.top.equalTo(self.tv_reason.mas_bottom);
        make.height.equalTo(@(10 * kScale));
    }];
    
    UILabel *lb_choose = [UILabel new];
    lb_choose.text = @"选填";
    lb_choose.font = [UIFont systemFontOfSize:14 * kScale];
    lb_choose.textColor = kUIColorFromRGB(0x333333);
    [_mainView addSubview:lb_choose];
    [lb_choose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tf_name);
        make.top.equalTo(graylb1.mas_bottom).offset(14 * kScale);
    }];
    
    [_mainView addSubview:self.imageV4];
    [_mainView addSubview:self.imageV5];
    [_mainView addSubview:self.imageV6];
    
    [self.imageV4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.height.equalTo(self.imageV1);
        make.top.equalTo(graylb1.mas_bottom).offset(42 * kScale);
    }];
    
    [self.imageV5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.imageV2);
        make.top.equalTo(self.imageV4);
    }];
    
    [self.imageV6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.height.equalTo(self.imageV3);
        make.top.equalTo(self.imageV4);
    }];
    
    UILabel *lb_support1 = [UILabel new];
    lb_support1.textColor = kUIColorFromRGB(0x333333);
    lb_support1.font = [UIFont systemFontOfSize:12 * kScale];
    lb_support1.text = @"辅助材料1";
    
    UILabel *lb_support2 = [UILabel new];
    lb_support2.textColor = kUIColorFromRGB(0x333333);
    lb_support2.font = [UIFont systemFontOfSize:12 * kScale];
    lb_support2.text = @"辅助材料2";
    
    UILabel *lb_support3 = [UILabel new];
    lb_support3.textColor = kUIColorFromRGB(0x333333);
    lb_support3.font = [UIFont systemFontOfSize:12 * kScale];
    lb_support3.text = @"辅助材料3";
    
    [_mainView addSubview:lb_support1];
    [_mainView addSubview:lb_support2];
    [_mainView addSubview:lb_support3];
    
    [lb_support1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageV4);
        make.top.equalTo(self.imageV4.mas_bottom).offset(15 * kScale);
    }];
    
    [lb_support2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageV5);
        make.top.equalTo(self.imageV5.mas_bottom).offset(15 * kScale);
    }];
    
    [lb_support3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageV6);
        make.top.equalTo(self.imageV6.mas_bottom).offset(15 * kScale);
    }];
    
    UILabel *lb_tip = [UILabel new];
    lb_tip.text = @"温馨提示:";
    lb_tip.font = [UIFont systemFontOfSize:11 * kScale];
    lb_tip.textColor = kUIColorFromRGB(0x333333);
    
    UILabel *lb_tipDsc = [UILabel new];
    lb_tipDsc.text = @"添加辅助材料可加速认证节奏哦~比如: 分析师证,工作证等等";
    lb_tipDsc.textColor = kUIColorFromRGB(0x666666);
    lb_tipDsc.font = [UIFont systemFontOfSize:11 * kScale];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [_mainView addSubview:lb_tip];
    [_mainView addSubview:lb_tipDsc];
    [_mainView addSubview:bottomView];
    
    [lb_tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lb_support1.mas_bottom).offset(24 * kScale);
        make.left.equalTo(self.imageV4);
    }];
    
    [lb_tipDsc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lb_tip);
        make.top.equalTo(lb_tip.mas_bottom).offset(6 * kScale);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lb_tipDsc.mas_bottom).offset(30 * kScale);
        make.left.right.bottom.equalTo(_mainView);
    }];
    
    UILabel *lb_bottom = [UILabel new];
    lb_bottom.text = @"目前的认证,是股怪侠对用户真实身份的确认,所有的认证都是免费的";
    lb_bottom.textColor = kUIColorFromRGB(0x666666);
    lb_bottom.font = [UIFont systemFontOfSize:11 * kScale];
    
    UILabel *lb_bottom1 = [UILabel new];
    lb_bottom1.text = @"详情可咨询:QQ 3384589995 | 电话 021-58976636";
    lb_bottom1.textColor = kUIColorFromRGB(0x666666);
    lb_bottom1.font = [UIFont systemFontOfSize:11 * kScale];
    
    [bottomView addSubview:lb_bottom1];
    [lb_bottom1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.bottom.equalTo(bottomView).offset(-20 * kScale);
    }];
    
    [bottomView addSubview:lb_bottom];
    [lb_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.bottom.equalTo(lb_bottom1.mas_top).offset(-10 * kScale);
    }];

    [bottomView addSubview:self.btn_proxy];
    [self.btn_proxy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView).offset(15);
        make.bottom.equalTo(lb_bottom.mas_top).offset(-15 * kScale);
    }];
    
    [bottomView addSubview:self.btn_allow];
    [self.btn_allow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btn_proxy);
        make.right.equalTo(self.btn_proxy.mas_left).offset(-5);
    }];
    
    [self.nmArr addObject:self.imageV1];
    [self.nmArr addObject:self.imageV2];
    [self.nmArr addObject:self.imageV3];
    [self.nmArr addObject:self.imageV4];
    [self.nmArr addObject:self.imageV5];
    [self.nmArr addObject:self.imageV6];
}

#pragma mark delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.lb_tvPlaceHolder.hidden = _tv_reason.text.length != 0;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (_scrollHeight < 176) {
        [_scrollView setContentOffset:CGPointMake(0, 176) animated:YES];
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _scrollHeight = scrollView.contentOffset.y;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    UIImage *tempImg = [self scaleImage:image];
    
    if (tempImg == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"图片不能超过1.5M" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSInteger tag = picker.view.tag;
    UIImageView *iv = self.nmArr[tag - 1];
    iv.image = tempImg;
    UIButton *btn = [iv viewWithTag:10];
    btn.hidden = NO;

    if (tag == 1) {
        _hasImg1 = YES;
    } else if (tag == 2) {
        _hasImg2 = YES;
    } else if (tag == 3) {
        _hasImg3 = YES;
    } else if (tag == 4) {
        _hasImg4 = YES;
    } else if (tag == 5) {
        _hasImg5 = YES;
    } else if (tag == 6) {
        _hasImg6 = YES;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark function 

- (UIImage *)scaleImage:(UIImage *)chosedImage {
    
    NSData *data = UIImageJPEGRepresentation(chosedImage, 0.5);
    
    if (data.length > 1024 * 1024 * 1.5) {
        return nil;
    }
    
    UIImage *img = [UIImage imageWithData:data];
    
    return img;
}

#pragma mark request 

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    NSArray *arr = request.responseJSONObject;
    NSDictionary *dict0 = arr[0];
    NSDictionary *dict1 = arr[1];
    NSDictionary *dict2 = arr[2];
    NSString *str1 = dict0[@"origin"];
    NSString *str2 = dict1[@"origin"];
    NSString *str3 = dict2[@"origin"];
    NSArray *tempA = [arr subarrayWithRange:NSMakeRange(2, arr.count - 3)];
    NSMutableArray *nmArr = [NSMutableArray array];
    for (NSDictionary *dict in tempA) {
        NSString *url = dict[@"origin"];
        [nmArr addObject:url];
    }
    
    self.userVertifyAPI.idn = self.tf_idNum.text;
    self.userVertifyAPI.idf = str1;
    self.userVertifyAPI.idb = str2;
    self.userVertifyAPI.idu = str3;
    self.userVertifyAPI.rn = self.tf_name.text.length ? _tf_name.text : @"";
    self.userVertifyAPI.an = self.tf_nickName.text.length ? _tf_nickName.text : @"";
    self.userVertifyAPI.rs = self.tv_reason.text.length ? _tv_reason.text : @"";
    self.userVertifyAPI.aspic = nmArr;
    
    [self.userVertifyAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseJSONObject);
        [self getMyVertifyInfo];
    } failure:^(__kindof APIBaseRequest *request) {
        [super requestFailed:request];
    }];
}

#pragma mark action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    
    
    if (self.tf_name.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"姓名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (self.tf_idNum.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"身份证号码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (_hasImg1 == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请插入身份证正面图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (_hasImg2 == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请插入身份证背面图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (_hasImg3 == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请插入手持身份证正面照" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
//    if (self.tf_nickName.text.length == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您要的加V昵称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
//    if (self.tv_reason.text.length == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入申请理由" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
    if (self.btn_allow.isSelected == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未同意股怪侠投资协议" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.tv_reason.text.length > 300) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"申请理由不能大于300字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *pa = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{4}$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pa options:0 error:nil];
    NSString *num = self.tf_idNum.text;
    NSInteger count = [regex numberOfMatchesInString:num options:0 range:NSMakeRange(0, num.length)];
    if (count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的身份证号码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self uploadImgs];
}

- (void)reVertifyBtnClick:(UIButton *)btn {
    self.myVertifyView.hidden = YES;
    self.reVertifyBtn.hidden = YES;
    [self setupUI];
}

- (void)uploadImgs {
    NSMutableArray *nmA = [NSMutableArray array];
    
    for (int i = 0; i < 3; i ++) {
        UIImageView *iv = self.nmArr[i];
        [nmA addObject:iv.image];
    }
    if (_hasImg4) {
        UIImageView *iv = self.nmArr[3];
        [nmA addObject:iv.image];
    }
    if (_hasImg5) {
        UIImageView *iv = self.nmArr[4];
        [nmA addObject:iv.image];
    }
    if (_hasImg6) {
        UIImageView *iv = self.nmArr[5];
        [nmA addObject:iv.image];
    }
    
    self.postImgAPI.imageArray = nmA;
    [self.view endEditing:YES];
    [self.postImgAPI start];
}

- (void)deleteBtnClick:(UIButton *)btn {
    NSInteger tag = btn.superview.tag;
    UIImageView *iv = self.nmArr[tag - 1];
    iv.image = [UIImage imageNamed:@"author_add_img"];
    if (tag == 1) {
        _hasImg1 = NO;
    } else if (tag == 2) {
        _hasImg2 = NO;
    } else if (tag == 3) {
        _hasImg3 = NO;
    } else if (tag == 4) {
        _hasImg4 = NO;
    } else if (tag == 5) {
        _hasImg5 = NO;
    } else if (tag == 6) {
        _hasImg6 = NO;
    }
    UIButton *btn1 = [iv viewWithTag:10];
    btn1.hidden = YES;
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    UIImageView *iv = self.nmArr[tap.view.tag - 1];
    if (![UIImagePNGRepresentation(iv.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"author_add_img"])]) {
        return;
    }
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    vc.view.tag = tap.view.tag;
}

- (void)closeTap {
    [self.view endEditing:YES];
}

- (void)allowBtnClick:(UIButton *)btn {
    btn.selected = !btn.isSelected;
}

- (void)btnProxyClick:(UIButton *)btn {
//    self.btn_allow.selected = !self.btn_allow.isSelected;
    ContentViewController *forgetViewController = [[ContentViewController alloc] init];
    [self.navigationController pushViewController:forgetViewController animated:YES];
}

#pragma mark lazyloading

- (UITextField *)tf_name {
    if (_tf_name == nil) {
        _tf_name = [[UITextField alloc] init];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"请输入您的真实姓名" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0x999999)}];
        _tf_name.attributedPlaceholder = str;
        UILabel *line = [UILabel new];
        line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_tf_name addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_tf_name);
            make.height.equalTo(@(0.5));
        }];
    }
    return _tf_name ;
}

- (UITextField *)tf_idNum {
    if (_tf_idNum == nil) {
        _tf_idNum = [[UITextField alloc] init];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"请输入您的身份证号码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0x999999)}];
        _tf_idNum.attributedPlaceholder = str;
        UILabel *line = [UILabel new];
        line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_tf_idNum addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_tf_idNum);
            make.height.equalTo(@(0.5));
        }];
    }
    return _tf_idNum;
}

- (UITextField *)tf_nickName {
    if (_tf_nickName == nil) {
        _tf_nickName = [[UITextField alloc] init];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"请输入您要在股怪侠加V的名称(选填)" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0x999999)}];
        _tf_nickName.attributedPlaceholder = str;
        UILabel *line = [UILabel new];
        line.backgroundColor = kUIColorFromRGB(0xe4e4e4);
        [_tf_nickName addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_tf_nickName);
            make.height.equalTo(@(0.5));
        }];
    }
    return _tf_nickName;
}

- (UITextView *)tv_reason {
    if (_tv_reason == nil) {
        _tv_reason = [[UITextView alloc] init];
        _tv_reason.delegate = self;
        _tv_reason.font = [UIFont systemFontOfSize:15 * kScale];
        _tv_reason.returnKeyType = UIReturnKeyDone;
        [_tv_reason addSubview:self.lb_tvPlaceHolder];
        [self.lb_tvPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tv_reason).offset(3.5);
            make.top.equalTo(_tv_reason.mas_bottom).offset(8 * kScale);
        }];
    }
    return _tv_reason;
}

- (UILabel *)lb_tvPlaceHolder {
    if (_lb_tvPlaceHolder == nil) {
        _lb_tvPlaceHolder = [UILabel new];
        _lb_tvPlaceHolder.textColor = kUIColorFromRGB(0x999999);
        _lb_tvPlaceHolder.text = @"请输入申请理由(300字以内,选填)";
        _lb_tvPlaceHolder.font = [UIFont systemFontOfSize:15 * kScale];
    }
    return _lb_tvPlaceHolder;
}

- (UIImageView *)imageV1 {
    if (_imageV1 == nil) {
        _imageV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"author_add_img"]];
        _imageV1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imageV1 addGestureRecognizer:tap];
        _imageV1.tag = 1;
        UIButton *btn = [UIButton new];
        btn.tag = 10;
        [btn setImage:[UIImage imageNamed:@"ic_postImage_delete_nor"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        [_imageV1 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_imageV1);
        }];
    }
    return _imageV1;
}

- (UIImageView *)imageV2 {
    if (_imageV2 == nil) {
        _imageV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"author_add_img"]];
        _imageV2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imageV2 addGestureRecognizer:tap];
        _imageV2.tag = 2;
        UIButton *btn = [UIButton new];
        btn.tag = 10;
        [btn setImage:[UIImage imageNamed:@"ic_postImage_delete_nor"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        [_imageV2 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_imageV2);
        }];
    }
    return _imageV2;
}

- (UIImageView *)imageV3 {
    if (_imageV3 == nil) {
        _imageV3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"author_add_img"]];
        _imageV3.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imageV3 addGestureRecognizer:tap];
        _imageV3.tag = 3;
        UIButton *btn = [UIButton new];
        btn.tag = 10;
        [btn setImage:[UIImage imageNamed:@"ic_postImage_delete_nor"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        [_imageV3 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_imageV3);
        }];
    }
    return _imageV3;
}

- (UIImageView *)imageV4 {
    if (_imageV4 == nil) {
        _imageV4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"author_add_img"]];
        _imageV4.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imageV4 addGestureRecognizer:tap];
        _imageV4.tag = 4;
        UIButton *btn = [UIButton new];
        btn.tag = 10;
        [btn setImage:[UIImage imageNamed:@"ic_postImage_delete_nor"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        [_imageV4 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_imageV4);
        }];
    }
    return _imageV4;
}

- (UIImageView *)imageV5 {
    if (_imageV5 == nil) {
        _imageV5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"author_add_img"]];
        _imageV5.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imageV5 addGestureRecognizer:tap];
        _imageV5.tag = 5;
        UIButton *btn = [UIButton new];
        btn.tag = 10;
        [btn setImage:[UIImage imageNamed:@"ic_postImage_delete_nor"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        [_imageV5 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_imageV5);
        }];
    }
    return _imageV5;
}

- (UIImageView *)imageV6 {
    if (_imageV6 == nil) {
        _imageV6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"author_add_img"]];
        _imageV6.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imageV6 addGestureRecognizer:tap];
        _imageV6.tag = 6;
        UIButton *btn = [UIButton new];
        btn.tag = 10;
        [btn setImage:[UIImage imageNamed:@"ic_postImage_delete_nor"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        [_imageV6 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_imageV6);
        }];
    }
    return _imageV6;
}

- (UIButton *)btn_allow {
    if (_btn_allow == nil) {
        _btn_allow = [[UIButton alloc] init];
        [_btn_allow setTitle:@"同意" forState:UIControlStateNormal];
        [_btn_allow setTitle:@"同意" forState:UIControlStateSelected];
        _btn_allow.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_btn_allow setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_btn_allow addTarget:self action:@selector(allowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_allow setImage:[UIImage imageNamed:@"author_allowbtn_nor"] forState:UIControlStateNormal];
        [_btn_allow setImage:[UIImage imageNamed:@"author_allowBtn_select"] forState:UIControlStateSelected];
        _btn_allow.selected = YES;
        _btn_allow.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
    }
    return _btn_allow;
}

- (UIButton *)btn_proxy {
    if (_btn_proxy == nil) {
        _btn_proxy = [[UIButton alloc] init];
        [_btn_proxy setTitle:@"股怪侠投资协议" forState:UIControlStateNormal];
        [_btn_proxy setTitleColor:kButtonBGColor forState:UIControlStateNormal];
        _btn_proxy.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_btn_proxy addTarget:self action:@selector(btnProxyClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_proxy;
}

- (NSMutableArray *)nmArr {
    if (_nmArr == nil) {
        _nmArr = [NSMutableArray array];
    }
    return _nmArr;
}

- (PostFeedPicAPI *)postImgAPI {
    if (_postImgAPI == nil) {
        _postImgAPI = [PostFeedPicAPI new];
        _postImgAPI.ty = @"verify";
        _postImgAPI.delegate = self;
        _postImgAPI.animatingView = self.navigationController.view;
        _postImgAPI.animatingText = @"正在上传图片,请稍候...";
    }
    return _postImgAPI;
}

- (UserVertifyAPI *)userVertifyAPI {
    if (_userVertifyAPI == nil) {
        _userVertifyAPI = [[UserVertifyAPI alloc] init];
        _userVertifyAPI.animatingView = self.navigationController.view;
        _userVertifyAPI.animatingText = @"正在上传验证信息,请稍候...";
    }
    return _userVertifyAPI;
}

- (GetMyVertifyAPI *)getMyVertifyAPI {
    if (_getMyVertifyAPI == nil) {
        _getMyVertifyAPI = [[GetMyVertifyAPI alloc] init];
        _getMyVertifyAPI.animatingView = self.navigationController.view;
        _getMyVertifyAPI.animatingText = @"正在获取验证信息,请稍候...";
    }
    return _getMyVertifyAPI;
}

- (MyVertifyView *)myVertifyView {
    if (_myVertifyView == nil) {
        _myVertifyView = [[MyVertifyView alloc] init];
    }
    return _myVertifyView;
}

- (UIButton *)reVertifyBtn {
    if (_reVertifyBtn == nil) {
        UIButton *btn = [UIButton new];
        [btn setTitle:@"重新认证" forState:UIControlStateNormal];
        [btn setTitleColor:kTitleColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15 * kScale];
        btn.frame = CGRectMake(_navBar.frame.size.width - 90, 22, 80, 40);
        [_navBar addSubview:btn];
        [btn addTarget:self action:@selector(reVertifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _reVertifyBtn = btn;
    }
    return _reVertifyBtn;
}

@end
