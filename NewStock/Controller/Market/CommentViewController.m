//
//  CommentViewController.m
//  NewStock
//
//  Created by Willey on 16/9/19.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "CommentViewController.h"
#import "MarketConfig.h"

@implementation CommentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title= @"吐槽产品";
    [self setNavBarTitle:self.title];
    [self setRightBtnImg:nil];
    _navBar.line_view.hidden = YES;
    
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    [_scrollView layoutIfNeeded];
    
    
    //    UIImageView *imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 246)];
    //    imgBg.image = [UIImage imageNamed:@"tucaoBg.png"];
    //    [_mainView addSubview:imgBg];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(-1, -1, _nMainViewWidth+2, 200)];
    bg.backgroundColor = [UIColor whiteColor];
    bg.layer.borderColor = SEP_LINE_COLOR.CGColor;

    [_mainView addSubview:bg];
    
    _textView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(25, 20, _nMainViewWidth-50, 200)];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.placeholder = @"请输入吐槽内容......";
//    _textView.layer.cornerRadius = 5;
//    _textView.layer.masksToBounds = YES;
//    _textView.layer.borderColor = [UIColor greenColor].CGColor;
//    _textView.layer.borderWidth = 1.5;
    [_mainView addSubview:_textView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(_textView.frame.origin.x+_textView.frame.size.width-100, _textView.frame.origin.y+_textView.frame.size.height+10, 110, 40);


    
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"orangeBtn.png"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_mainView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(@(MAIN_SCREEN_WIDTH - 2 * 15));
        make.bottom.equalTo(button.superview).offset(-155);
        make.left.equalTo(button.superview).offset(15);
    }];
    
    _userSuggestAPI = [[UserSuggestAPI alloc] initWithUserId:@"" content:@""];
    _userSuggestAPI.delegate = self;
}

#pragma UITextView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    if ([text isEqualToString:@"\n"])
    {
        NSLog(@"%@",textView.text);
        NSString *message = _textView.text;
        if (message.length > 0)
        {
            
            //[self buttonClicked];
            
        }
        [_textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)buttonClicked {
    // 成功后             [_textView setText:@""];
    [_textView resignFirstResponder];
    
    _userSuggestAPI.content = _textView.text;
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

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
