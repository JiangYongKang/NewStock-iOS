//
//  ReviseNameViewController.m
//  NewStock
//
//  Created by Willey on 16/9/6.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "ReviseNameViewController.h"
#import "MarketConfig.h"
#import "SystemUtil.h"

@implementation ReviseNameViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    [_navBar setTitle:self.title];
    _navBar.line_view.hidden = YES;
    
    [self setRightBtnImg:nil];
    [_navBar setLeftBtnTitle:@"取消"];
    [_navBar setRightBtnTitle:@"保存"];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    _mainView.backgroundColor = [SystemUtil hexStringToColor:@"#ffffff"];
    
    UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
    gensture.delegate = self;
    [_mainView addGestureRecognizer:gensture];
    
    _nicknameTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 20, _nMainViewWidth-30, 40)];
    _nicknameTF.delegate = self;
    _nicknameTF.backgroundColor = [UIColor clearColor];
    _nicknameTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nicknameTF.placeholder = @"请输入昵称(2~12个汉字或4~24英文字符)";
    _nicknameTF.textColor = kUIColorFromRGB(0x333333);
    _nicknameTF.font = [UIFont systemFontOfSize:16];
    _nicknameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nicknameTF.returnKeyType = UIReturnKeyDone;
    _nicknameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _nicknameTF.tag = 201;
    _nicknameTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nicknameTF.text = self.nickName;
    [_mainView addSubview:_nicknameTF];
    
    UIView *line = [UIView new];
    line.backgroundColor = kUIColorFromRGB(0xd3d3d3);
    [_mainView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.superview).offset(15);
        make.right.equalTo(line.superview).offset(-15);
        make.top.equalTo(_nicknameTF.mas_bottom).offset(0.5);
        make.height.equalTo(@0.5);
    }];
    
    _userInfoUpdateAPI = [[UserInfoUpdateAPI alloc] init];
    _userInfoUpdateAPI.delegate = self;
    _userInfoUpdateAPI.animatingView = _mainView;
    _userInfoUpdateAPI.animatingText = @"数据提交中";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_nicknameTF becomeFirstResponder];
}


- (void)scrollViewTapAction {
    [_nicknameTF resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 201) {
        [self performSelector:@selector(buttonClicked)];
        [textField resignFirstResponder];
    }
   
    return YES;
}

- (void)buttonClicked {
    [_nicknameTF resignFirstResponder];
    
    NSInteger length = [self calculateTextNumber:_nicknameTF.text];
    
    if ([_nicknameTF.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入昵称!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else if(length > 12 || length < 2)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入长度在2~12个中文或4-24个字符内的昵称!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }else if ([SystemUtil stringContainsEmoji:_nicknameTF.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称不能包含表情!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        NSString *userId = [SystemUtil getCache:USER_ID];
        _userInfoUpdateAPI.uid = userId;
        _userInfoUpdateAPI.n = _nicknameTF.text;
        [_userInfoUpdateAPI start];
    }
}

- (NSInteger)calculateTextNumber:(NSString *) textA {
    float number = 0.0;
    int index;
    for (index=0; index < [textA length]; index++) {
        
        NSString *character = [textA substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number++;
        } else {
            number = number+0.5;
        }
    }
    return ceil(number);
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = 101;
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView show];
    });
    
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[request.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    [self buttonClicked];
}

@end
