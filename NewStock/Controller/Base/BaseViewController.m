//
//  BaseViewController.m
//  NewStock
//
//  Created by Willey on 16/7/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "UserInfoInstance.h"
#import "MarketConfig.h"
#import "AppDelegate.h"
#import "StockHistoryUtil.h"
#import <Reachability.h>

#import "UMMobClick/MobClick.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)selfr;
    self.view.backgroundColor = [UIColor whiteColor];
    _navBar = [[NavBar alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, NAV_BAR_HEIGHT)];
    _navBar.alpha = 0.98;
    _navBar.delegate = self;
    [self.view addSubview:_navBar];
    [self.view bringSubviewToFront:_navBar];
    
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, TAB_BAR_HEIGHT, 0));
    }];
    
    _mainView = [[UIView alloc] init];
    _mainView.backgroundColor = REFRESH_BG_COLOR;
    [_scrollView addSubview:_mainView];
    
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(_scrollView).priorityMedium();
    }];
    
    
    [_scrollView layoutIfNeeded];//

    _nMainViewWidth = _mainView.frame.size.width;
    _nMainViewHeight = _mainView.frame.size.height;
    
    
    
    /**
     *  MMPlaceHolderConfig设置
     */
    [MMPlaceHolderConfig defaultConfig].lineColor = [UIColor redColor];
    //[MMPlaceHolderConfig defaultConfig].backColor = [UIColor lightGrayColor];
    //[MMPlaceHolderConfig defaultConfig].arrowSize = 3;
    //[MMPlaceHolderConfig defaultConfig].lineWidth = 1;
    [MMPlaceHolderConfig defaultConfig].frameWidth = 1;
//    [_mainView showPlaceHolderWithAllSubviews];
//    [_navBar showPlaceHolderWithAllSubviews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //事件统计
    if (self.title) {
        [MobClick beginLogPageView:self.title];
        NSLog(@"---------事件统计:%@---------",self.title);
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
    NSLog(@"---------事件统计结束:%@---------",self.title);
}

- (void)setNavBarTitle:(NSString *)title {
    [_navBar setTitle:title];
}

- (void)setNavBarSubTitle:(NSString *)title {
    [_navBar setSubTitle:title];
}

- (void)setNavBg:(UIImage *)bg {
    [_navBar setNavBg:bg];
}

- (void)setLeftBtnImg:(UIImage *)image {
    [_navBar setLeftBtnImg:image];
}

- (void)setRightBtnImg:(UIImage *)image {
    [_navBar setRightBtnImg:image];
}

- (void)setRIghtImageFrame:(CGRect)frame {
    [_navBar setRIghtImageFrame:frame];
}

- (void)setRightBtnImg:(UIImage *)image withNum:(int)num {
    [_navBar setRightBtnImg:image withNum:(int)num];
}

- (void)setRightBtnTitle:(NSString *)title {
     [_navBar setRightBtnTitle:title];
}

- (void)navBar:(NavBar*)navBar leftButtonTapped:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender {
    
}

- (void)loadData {
    
}

- (void)popLoginViewController {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed:%@",request.responseJSONObject);
    NSString *code = [request.responseJSONObject objectForKey:@"code"];
    if ([code isEqualToString:@"E0000"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录 ！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = 1001;
        [alertView show];
    } else {
        Reachability *reach = [Reachability reachabilityForInternetConnection];
        NetworkStatus status = [reach currentReachabilityStatus];
        if (status == NotReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络状态不佳,请检查网络!" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alert show];
            return;
        }
        NSString *serverStr = [request.responseJSONObject objectForKey:@"msg"];
        if ([serverStr isEqual:[NSNull null]] || serverStr.length == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器繁忙,请稍候再试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:serverStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 1001) {
        if(buttonIndex == 0) {
            
            [SystemUtil signOut];
            
            [UserInfoInstance sharedUserInfoInstance].userInfoModel = nil;
            [StockHistoryUtil getMyStockFromServer];
            [UserInfoInstance sharedUserInfoInstance].lastIcon = nil;
            
            [self popLoginViewController];
            
        }
    }
}

@end
