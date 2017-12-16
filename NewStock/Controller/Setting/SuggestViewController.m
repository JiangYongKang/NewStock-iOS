//
//  SuggestViewController.m
//  NewStock
//
//  Created by Willey on 16/8/23.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "SuggestViewController.h"
#import "MarketConfig.h"

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title= @"吐槽产品";
    [self setNavBarTitle:self.title];
    [self setRightBtnImg:nil];
    _navBar.line_view.hidden = YES;
    
    _mainView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panClick)];
    [_scrollView addGestureRecognizer:tap];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, _nMainViewWidth+2, 190)];
    bg.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:bg];
    
    _textView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(15, 20, _nMainViewWidth - 30, 165)];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.textColor = kUIColorFromRGB(0x999999);
    _textView.returnKeyType = UIReturnKeyNext;
    _textView.placeholder = @"请输入吐槽内容......";
    [_mainView addSubview:_textView];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 200, _nMainViewWidth-30, 15)];
    lb.text = @"亲，留个联系方式，我们好针对您提的建议向您反馈。";
    lb.textColor = kUIColorFromRGB(0x666666);
    lb.font = [UIFont systemFontOfSize:12];
    lb.textAlignment = NSTextAlignmentLeft;
    [_mainView addSubview:lb];
    
    _telTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 235, _nMainViewWidth-30, 40)];
    _telTF.placeholder = @"  QQ或手机号";
    _telTF.textAlignment = NSTextAlignmentLeft;
    _telTF.font = [UIFont systemFontOfSize:12];
    _telTF.textColor = kUIColorFromRGB(0x999999);
    _telTF.backgroundColor = [UIColor whiteColor];
    _telTF.layer.cornerRadius = 6;
    _telTF.returnKeyType = UIReturnKeyDone;
    _telTF.layer.masksToBounds = YES;
    _telTF.delegate = self;
    [_mainView addSubview:_telTF];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(35, _telTF.frame.origin.y+_telTF.frame.size.height+120, _nMainViewWidth-70, 44);

    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:kTitleColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.layer.masksToBounds = YES;
    [_mainView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@(MAIN_SCREEN_WIDTH));
        make.bottom.equalTo(button.superview).offset(-155);
        make.left.equalTo(button.superview).offset(0);
    }];
    
    _userSuggestAPI = [[UserSuggestAPI alloc] initWithUserId:@"" content:@""];
    _userSuggestAPI.delegate = self;
    _userSuggestAPI.animatingView = _mainView;
    _userSuggestAPI.animatingText = @"数据提交中";
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    if ([text isEqualToString:@"\n"]) {
        {
            [_textView resignFirstResponder];
            [_telTF becomeFirstResponder];
        }
    
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_telTF resignFirstResponder];

    return YES;
}

- (void)buttonClicked {
    // 成功后             [_textView setText:@""];
    [_textView resignFirstResponder];
    
    NSString *message = _textView.text;
    if (message.length > 500)
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的内容过长！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
        return;
        
    }
    if (message.length < 1)
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入吐槽内容！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
        return;
        
    }
    
    _userSuggestAPI.content = _textView.text;
    _userSuggestAPI.tel = _telTF.text;
    if ([SystemUtil isSignIn])
    {
        _userSuggestAPI.userId = [SystemUtil getCache:USER_ID];
    }
    
    [_userSuggestAPI start];
    
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed");
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = 1001;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)panClick {

    [_textView resignFirstResponder];
    [_telTF resignFirstResponder];
}


@end


