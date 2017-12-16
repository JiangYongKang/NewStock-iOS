//
//  DetailWebViewController.m
//  NewStock
//
//  Created by 王迪 on 2016/12/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "DetailWebViewController.h"
#import "SharedInstance.h"
#import "TipOffViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface DetailWebViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *iv_more;

@property (nonatomic, assign) BOOL notShow;

@property (nonatomic, strong) JSContext *context;

@end

@implementation DetailWebViewController

- (UIImageView *)iv_more {
    if (_iv_more == nil) {
        _iv_more = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_tankuang_nor"]];
        _iv_more.userInteractionEnabled = YES;
        [self.view addSubview:_iv_more];
        [_iv_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_iv_more.superview).offset(-9);
            make.top.equalTo(_iv_more.superview).offset(58);
            make.height.width.equalTo(@90);
        }];
        
        UIButton *topBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 90, 45)];
        UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, 90, 45)];
        [_iv_more addSubview:topBtn];
        [_iv_more addSubview:bottomBtn];
        topBtn.tag = 1;
        bottomBtn.tag = 2;
        [topBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iv_more;
}

- (void)setNotShow:(BOOL)notShow {

    _notShow = notShow;
    
    if (_notShow) {
        [self.iv_more mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@90);
        }];
    }else {
        [self.iv_more mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_more_nor"]];
    UIButton *sharedBtn = [_navBar valueForKey:@"_rightButton1"];
    [sharedBtn setImage:[UIImage imageNamed:@"ic_share_nor"] forState:UIControlStateNormal];
    sharedBtn.hidden = NO;
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, TOOL_BAR_HEIGHT - 2, 0));
    }];
    
    _favouritesFeedAPI = [FavouritesFeedAPI new];
    _favouritesFeedAPI.animatingView = self.view;
    _favouritesFeedAPI.animatingText = @"正在收藏...";
    
    _webView.scrollView.delegate = self;
}

- (void)navBar:(NavBar *)navBar rightButton1Tapped:(UIButton *)sender {
    [self share];
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    self.notShow = !self.notShow;
}

- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 1) {
        if ([SystemUtil isSignIn]) {
            if (_webViewIsfinishLoad) {
                [self favourites];
            }
        }else {
            [self.navigationController pushViewController:[LoginViewController new] animated:YES];
        }
    }else {
        [self tipOff];
    }
    self.notShow = YES;
}

- (void)tipOff {
    NSLog(@"举报");
    TipOffViewController *tipVC = [[TipOffViewController alloc]init];
    tipVC.contentId = _fid;
    tipVC.ty = @"S_FORUM";
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:tipVC animated:YES];
}

- (void)favourites {

    if (!_hcd) {
        _favouritesFeedAPI.fid = _fid;
        _favouritesFeedAPI.opty = @"Y";
        [_favouritesFeedAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
            NSLog(@"%@",request.responseJSONObject);
            
            _hcd = YES;
            [self refreshMoreImg:YES];
            
        } failure:^(APIBaseRequest *request) {
            NSLog(@"failed");
        }];
        
    } else {
        _favouritesFeedAPI.fid = _fid;
        _favouritesFeedAPI.opty = @"N";
        
        [_favouritesFeedAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
            NSLog(@"%@",request.responseJSONObject);
            
            _hcd = NO;
            [self refreshMoreImg:NO];
            
        } failure:^(APIBaseRequest *request) {
            NSLog(@"failed");
        }];
    }
    
}

- (void)share {
    if (!_webViewIsfinishLoad) {
        return;
    }
    
    UIImage *image = [UIImage imageNamed:@"shareLogo"];
    NSString *content = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"c2\").innerText"];
    
    content = [self dealTheContent:content];
    
    NSString *url = [self.myUrl stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
    url = [url stringByAppendingString:@"&from=ios"];
    
    NSString *tt = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"tt\").innerText"];
    if ([self.myUrl containsString:@"FM0401"]) {
        tt = @"分享个匿名说给你";
    }
    
    [SharedInstance sharedSharedInstance].image = image;
    [SharedInstance sharedSharedInstance].tt = tt;
    [SharedInstance sharedSharedInstance].c = content;
    [SharedInstance sharedSharedInstance].url = url;
    [SharedInstance sharedSharedInstance].res_code = @"S_FORUM";
    [SharedInstance sharedSharedInstance].sid = _fid;
    [[SharedInstance sharedSharedInstance] shareWithImage:NO];
}

- (void)refreshMoreImg:(BOOL)isFavorite {
    if (isFavorite) {
        self.iv_more.image = [UIImage imageNamed:@"ic_tankuang_pre"];
    }else {
        self.iv_more.image = [UIImage imageNamed:@"ic_tankuang_nor"];
    }
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.iv_more mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0);
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.context[@"getUserId"] = ^(){
        return [SystemUtil getCache:USER_ID];
    };
    
    [self getFid];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _webViewIsfinishLoad = YES;
        NSString *hcd = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"hcd\").innerText"];
        _hcd = [hcd isEqualToString:@"true"];
        [self refreshMoreImg:_hcd];
    });
    
    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

- (void)getFid {
    NSArray *andArray = [self.myUrl componentsSeparatedByString:@"&"];
    for (NSString *str in andArray) {
        if ([str containsString:@"id="]) {
            NSArray *arr = [str componentsSeparatedByString:@"="];
            _fid = arr[1];
            break;
        }
    }
}

- (NSString *)dealTheContent:(NSString *)content {
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@"."];
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@"."];
    content = [content stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    if (content.length > 30) {
        content = [content substringToIndex:30];
    }
    return content;
}

#pragma mark 

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *item1 = [UIPreviewAction actionWithTitle:@"举报" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self tipOff];
    }];
    
    UIPreviewAction *item2 = [UIPreviewAction actionWithTitle:_hcd ? @"取消收藏" : @"收藏" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([SystemUtil isSignIn]) {
            if (_webViewIsfinishLoad) {
                [self favourites];
            }
        }else {
            [self.navigationController pushViewController:[LoginViewController new] animated:YES];
        }
    }];
    
    UIPreviewAction *item3 = [UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self share];
    }];
    return @[item1,item2,item3];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_webView stringByEvaluatingJavaScriptFromString:@"B()"];
}

@end
