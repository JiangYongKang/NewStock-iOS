//
//  WebViewController.m
//  NewStock
//
//  Created by Willey on 16/8/11.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"
#import "UrlRedirectAction.h"
#import "UMMobClick/MobClick.h"
#import "SharedInstance.h"
#import "LoginViewController.h"
#import "UserInfoInstance.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *btn_personal;

@property (nonatomic, strong) JSContext *context ;

@end

@implementation WebViewController

- (JSContext *)context {
    if (_context == nil) {
        _context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _mytitle;
    [_navBar setTitle:self.title];
    _bFirst = NO;
    
    if (self.type == WEB_VIEW_TYPE_COMMENT) {
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, TOOL_BAR_HEIGHT, 0));
        }];
    } else if (self.type == WEB_VIEW_TYPE_BAGUA) {
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(-20, 0, TOOL_BAR_HEIGHT, 0));
        }];
    } else if (self.type == WEB_VIEW_TYPE_PERSONAL || self.type == WEB_VIEW_TYPE_TOPCLEAR) {
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(-20, 0, 0, 0));
        }];
    } else {
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
        }];
    }
    
    if (self.type == WEB_VIEW_TYPE_SHARE) {
        [_navBar setRightBtnImg:[UIImage imageNamed:@"send_icon"]];
    } else if (self.type == WEB_VIEW_TYPE_ZIXUN) {
        [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share_nor"]];
        UIButton *sharedBtn = [_navBar valueForKey:@"_rightButton1"];
        [sharedBtn setImage:[UIImage imageNamed:@"ic_collect_nor"] forState:UIControlStateNormal];
        sharedBtn.hidden = NO;
    } else if (self.type == WEB_VIEW_TYPE_BAGUA) {
        [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
        [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share1_nor"]];
    } else if (self.type == WEB_VIEW_TYPE_PERSONAL) {
        [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
        [_navBar addSubview:self.btn_personal];
        [self.btn_personal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.height.equalTo(@24);
            make.right.equalTo(_navBar).offset(-15);
            make.top.equalTo(_navBar).offset(29);
        }];
    } else if (self.type == WEB_VIEW_TYPE_NOR) {
        [_navBar setRightBtnImg:nil];
    } else if (self.type == WEB_VIEW_TYPE_TOPCLEAR) {
        [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    }
    
    [_scrollView updateConstraints];
    [_scrollView layoutIfNeeded];
    
    _webView = [[UIWebView alloc] init];
    _webView.backgroundColor = [UIColor whiteColor];//kUIColorFromRGB(0xf1f1f1);
    [_webView setUserInteractionEnabled: YES ];	 //是否支持交互
    [_webView setDelegate:self];	 //委托
//    [_webView setOpaque:YES];	 //透明
    _webView.opaque = NO;//去掉底部黑线
    
    [_mainView addSubview:_webView];	 //加载到自己的view
    _webView.scrollView.delegate = self;

    if ([_myUrl containsString:@"MY9902"]) {
        _webView.scrollView.bounces = NO;
    }
    
    [_mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(@(375 * kScale));
        make.height.equalTo(@(667 * kScale));
    }];
    
    if (_type == WEB_VIEW_TYPE_COMMENT) {
        [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@((667 * kScale - NAV_BAR_HEIGHT - TOOL_BAR_HEIGHT)));
        }];
    } else if (_type == WEB_VIEW_TYPE_SHARE || _type == WEB_VIEW_TYPE_NOR || _type == WEB_VIEW_TYPE_ZIXUN) {
        [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@((667 * kScale - NAV_BAR_HEIGHT)));
        }];
    }
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_webView.superview);
    }];

    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    _progressView = [[NJKWebViewProgressView alloc] init];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_mainView addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_progressView.superview);
        make.height.mas_equalTo(progressBarHeight);
    }];
    
    NSURL *url = [[NSURL alloc] initWithString:_myUrl];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    if (self.type == WEB_VIEW_TYPE_COMMENT || self.type == WEB_VIEW_TYPE_BAGUA) {
        if ([_myUrl containsString:@"FM0401"]) {
            _toolBarView = [[ToolBarView alloc] initWithType:TOOLBAR_TYPE_COMMENT_AMS];
//            _toolBarView.placeHolderStr = @"匿名评论";
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            tap.delegate = self;
            [_webView addGestureRecognizer:tap];
            _webView.userInteractionEnabled = YES;
        } else {
            _toolBarView = [[ToolBarView alloc] initWithType:TOOLBAR_TYPE_COMMENT_ONLY];
        }
        _toolBarView.delegate = self;
        [self.view addSubview:_toolBarView];

        [_toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.height.mas_equalTo(TOOL_BAR_HEIGHT);
        }];
    }
    
    if (self.type == WEB_VIEW_TYPE_BAGUA || self.type == WEB_VIEW_TYPE_PERSONAL || self.type == WEB_VIEW_TYPE_TOPCLEAR) {
        
        _navBar.backgroundColor = [UIColor clearColor];
        [self.view bringSubviewToFront:_navBar];
        _navBar.line_view.hidden = YES;
    }
    
    if (self.type == WEB_VIEW_TYPE_BAGUA || self.type == WEB_VIEW_TYPE_COMMENT || self.type == WEB_VIEW_TYPE_ZIXUN) {
        _favouritesFeedAPI = [[FavouritesFeedAPI alloc] init];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.type == WEB_VIEW_TYPE_BAGUA || self.type == WEB_VIEW_TYPE_PERSONAL || self.type == WEB_VIEW_TYPE_TOPCLEAR) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    if ([self.myUrl containsString:@"jiabei/TR0001"]) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    _webView.delegate = nil;
//    _webView.scrollView.delegate = nil;
    if (self.type == WEB_VIEW_TYPE_BAGUA || self.type == WEB_VIEW_TYPE_PERSONAL || self.type == WEB_VIEW_TYPE_TOPCLEAR) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if (_toolBarView.isUpdateCons == YES) {
        [_toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(TOOL_BAR_HEIGHT));
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
        _toolBarView.isUpdateCons = NO;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
    if (self.type != WEB_VIEW_TYPE_BAGUA && self.type != WEB_VIEW_TYPE_PERSONAL && self.type != WEB_VIEW_TYPE_TOPCLEAR) {
        self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        [_navBar setTitle:self.title];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    __weak typeof(self)weakSelf = self;
    
    self.context[@"getUserId"] = ^() {
        return [SystemUtil getCache:USER_ID];
    };
    
    if (_bFirst == NO) {
        [MobClick beginLogPageView:[_webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
        NSLog(@"---------事件统计:%@---------",[_webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
        _bFirst = YES;
    }
    
    if (self.type == WEB_VIEW_TYPE_ZIXUN) {
        JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        context[@"testObject"] = ^(NSString *fid,NSString *hcd){
            _fid = fid;
            _hcd = [hcd isEqualToString:@"true"] ? YES : NO;
            _webViewIsfinishLoad = YES;
            [weakSelf setUpCollectionBtn];
        };
    } else if (self.type == WEB_VIEW_TYPE_BAGUA) {
        NSArray *arr = [self.myUrl componentsSeparatedByString:@"id="];
        NSString *tempStr = arr[1];
        _fid = [tempStr substringWithRange:NSMakeRange(0, 24)];
        _webViewIsfinishLoad = YES;
    } else if (self.type == WEB_VIEW_TYPE_PERSONAL) {
        
        self.context[@"testObject"] = ^(NSString *fid,NSString *hcd) {
            _fid = fid;
            _fld = [hcd isEqualToString:@"true"] ? YES : NO;
            
            if ([[weakSelf valueForKeyPath:@"_fid"] isEqualToString:[SystemUtil getCache:USER_ID]]) {
                weakSelf.btn_personal.hidden = YES;
            } else {
                if (weakSelf.fld) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.btn_personal.selected = YES;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.btn_personal.selected = NO;
                    });
                }
                weakSelf.btn_personal.hidden = NO;
            }
            _webViewIsfinishLoad = YES;
        };
        
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _webViewIsfinishLoad = YES;
        });
    }
    
    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [UrlRedirectAction sharedUrlRedirectAction].delegate = self;
    return [UrlRedirectAction redirectActionWithUrl:request.URL from:self.myUrl navigationType:navigationType];
}

- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    
    if (self.type == WEB_VIEW_TYPE_SHARE || self.type == WEB_VIEW_TYPE_ZIXUN || self.type == WEB_VIEW_TYPE_BAGUA) {
        [self share];
    }
}

- (void)navBar:(NavBar *)navBar rightButton1Tapped:(UIButton *)sender {
    
    if ([SystemUtil isSignIn]) {
        
        if (_webViewIsfinishLoad) {
            [self favourites];
        }
        
    }else {
        [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    }
    
}

- (void)toolBarView:(ToolBarView *)toolBarView actionIndex:(TOOLBAR_ACTION_INDEX)index {
    if (![SystemUtil isSignIn]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = 10001;
        [alertView show];
        return;
    }
    
    if (index == TOOLBAR_ACTION_REPLY) {
        [_toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(TOOL_BAR_HEIGHT));
        }];
        BlurCommentView *commentView = [[BlurCommentView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        __weak typeof(self)weakSelf = self;
        commentView.sendSaveText = ^(NSAttributedString *saveText) {
            weakSelf.saveText = saveText;
        };
        commentView.saveText = self.saveText;
        if (toolBarView.isEmoticomAction) {
            [commentView.btn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
        [commentView commentshowInView:[UIApplication sharedApplication].keyWindow andView:commentView success:^(NSString *commentText) {
            commentView.saveText = nil;
            weakSelf.saveText = nil;
        } delegate:self];
        
    } else if (index == TOOLBAR_ACTION_CHOOSE_AMS) {
        if (_toolBarView.isUpdateCons) {
            [_toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(TOOL_BAR_HEIGHT));
            }];
            [UIView animateWithDuration:0.25 animations:^{
               [self.view layoutIfNeeded];
            }];
            _toolBarView.isUpdateCons = NO;
        } else {
            [_toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(TOOL_BAR_HEIGHT + 130 * kScale));
            }];
            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            }];
            _toolBarView.isUpdateCons = YES;
        }
    }
}

- (void)favourites {
    if (!_hcd) {
        _favouritesFeedAPI.fid = _fid;
        _favouritesFeedAPI.opty = @"Y";
        [_favouritesFeedAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
            NSLog(@"%@",request.responseJSONObject);
            _hcd = YES;
            [self setUpCollectionBtn];
        } failure:^(APIBaseRequest *request) {
            NSLog(@"failed");
        }];
        
    } else {
        _favouritesFeedAPI.fid = _fid;
        _favouritesFeedAPI.opty = @"N";
        
        [_favouritesFeedAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
            NSLog(@"%@",request.responseJSONObject);
            _hcd = NO;
            [self setUpCollectionBtn];
        } failure:^(APIBaseRequest *request) {
            NSLog(@"failed");
        }];
    }
}

- (void)personalBtnClick {
    if (_isRequesting == YES || _fid.length == 0) {
        return;
    }
    
    if ([SystemUtil isSignIn]) {
        if (_fld) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"确定要取消关注此人?" preferredStyle:0];
            [self presentViewController:alertVC animated:YES completion:nil];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                _userFollowedAPI = [[UserFollowedAPI alloc] initWithSt:@"1" fuid:_fid];
                [self startUserFollowAPI];
            }];
            [alertVC addAction:cancel];
            [alertVC addAction:sure];
        }else {
            _userFollowedAPI = [[UserFollowedAPI alloc] initWithSt:@"0" fuid:_fid];
            [self startUserFollowAPI];
        }
    }else {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)startUserFollowAPI {
    
    [_userFollowedAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseJSONObject);
        _fld = !_fld;
        if (_fld) {
            self.btn_personal.selected = YES;
        }else {
            self.btn_personal.selected = NO;
        }
        _isRequesting = NO;
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"关注失败");
        _isRequesting = NO;
    }];
}

#pragma BlurCommentViewDelegate
- (void)commentDidFinished:(NSString *)commentText {
    
    if ([commentText isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }else {
        _commentAPI = [[CommentAPI alloc] init];
        _commentAPI.uid = [SystemUtil getCache:USER_ID];
        _commentAPI.c = commentText;
        _commentAPI.fid = _fid;
        _commentAPI.delegate = self;
        if ([_myUrl containsString:@"FM0401"]) {
            _commentAPI.ams = ![UserInfoInstance sharedUserInfoInstance].isAMS ? @"Y" : @"N";
        }
        [_commentAPI start];
    }
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    NSString *s = [request.responseString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Refresh('%@')",s]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {

    }else if (alertView.tag == 10001) {
        [self popLoginViewController];
    }
}

- (void)share {
    if (!_webViewIsfinishLoad) {
        return;
    }
    UIImage *image = [UIImage imageNamed:@"shareLogo"];
    
    NSString *url = [self.myUrl stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
    
    if (!self.hasParam) {
        url = [url stringByAppendingString:@"&from=ios"];
    }
    
    NSString *title = [NSString stringWithFormat:@"股怪侠-%@",[_webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    NSString *content = @" ";
    BOOL isYaoQian = [[_webView stringByEvaluatingJavaScriptFromString:@"document.title"] isEqualToString:@"财神爷灵签"];
    
    if (self.type == WEB_VIEW_TYPE_BAGUA || self.type == WEB_VIEW_TYPE_ZIXUN || self.type == WEB_VIEW_TYPE_SHARE) {
        title = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"tt\").innerText"];
        content = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"c2\").innerText"];
        content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (content.length > 30) {
            content = [content substringToIndex:30];
        }
    }
    
    if (isYaoQian) {
        NSString *str = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"name\").innerText"];
        title = [NSString stringWithFormat:@"我抽到的财神爷灵签 - %@",str];
        content = [NSString stringWithFormat:@"求财交易:%@",[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"vc\").innerText"]];
    }
    
    NSArray *arr = [self.myUrl componentsSeparatedByString:@"="];
    if (arr.count > 1) {
        [SharedInstance sharedSharedInstance].sid = arr[1];
    }
    
    if (self.type == WEB_VIEW_TYPE_BAGUA) {
        [SharedInstance sharedSharedInstance].res_code = @"S_GOSSIP";
    } else if (self.type == WEB_VIEW_TYPE_ZIXUN) {
        [SharedInstance sharedSharedInstance].res_code = @"S_STOCKNEWS";
        [SharedInstance sharedSharedInstance].sid = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"nid\").innerText"];
    } else if (isYaoQian) {
        [SharedInstance sharedSharedInstance].res_code = @"S_DRAW";
    } else {
        [SharedInstance sharedSharedInstance].res_code = @"S_FEED";
    }
    

    [SharedInstance sharedSharedInstance].image = image;
    [SharedInstance sharedSharedInstance].tt = title;
    [SharedInstance sharedSharedInstance].c = content;
    [SharedInstance sharedSharedInstance].url = url;
    [[SharedInstance sharedSharedInstance] shareWithImage:NO];
    
}

- (void)setUpCollectionBtn {
    UIButton *sharedBtn = [_navBar valueForKey:@"_rightButton1"];
    if (_hcd) {
        [sharedBtn setImage:[UIImage imageNamed:@"ic_collect_pre"] forState:UIControlStateNormal];
    }else {
        [sharedBtn setImage:[UIImage imageNamed:@"ic_collect_nor"] forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.type == WEB_VIEW_TYPE_BAGUA || self.type == WEB_VIEW_TYPE_PERSONAL || self.type == WEB_VIEW_TYPE_TOPCLEAR) {
        CGFloat alpha = 1.0 / 200.0 * (scrollView.contentOffset.y);
        _navBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
        
        if (alpha > 0.8) {
            [_navBar setTitle:
             [_webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
            [_navBar setLeftBtnImg:[UIImage imageNamed:@"navbar_back"]];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            if (self.type == WEB_VIEW_TYPE_BAGUA) {
                [_navBar setRightBtnImg:[UIImage imageNamed:@"send_icon"]];
            }else if (self.type == WEB_VIEW_TYPE_PERSONAL) {
                [self.btn_personal setTitleColor:kTitleColor forState:UIControlStateNormal];
                self.btn_personal.layer.borderColor = kTitleColor.CGColor;
            }
        }else {
            [_navBar setTitle:@""];
            [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            if (self.type == WEB_VIEW_TYPE_BAGUA) {
                [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share1_nor"]];
            }else if (self.type == WEB_VIEW_TYPE_PERSONAL) {
                [self.btn_personal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.btn_personal.layer.borderColor = [UIColor whiteColor].CGColor;
            }
        }
    }
    
}

- (UIButton *)btn_personal {
    if (_btn_personal == nil) {
        _btn_personal = [UIButton new];
        [_btn_personal.titleLabel setFont:[UIFont systemFontOfSize:12 * kScale]];
        _btn_personal.layer.cornerRadius = 4;
        [_btn_personal setTitle:@"关注" forState:UIControlStateNormal];
        [_btn_personal setTitle:@"已关注" forState:UIControlStateSelected];
        [_btn_personal setTitle:@"已关注" forState:UIControlStateHighlighted | UIControlStateSelected];
        _btn_personal.layer.borderColor = [UIColor whiteColor].CGColor;
        _btn_personal.layer.borderWidth = 1;
        [_btn_personal addTarget:self action:@selector(personalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_personal;
}

- (void)dealloc {

    _webView.delegate = nil;
    _webView.scrollView.delegate = nil;
}

@end
