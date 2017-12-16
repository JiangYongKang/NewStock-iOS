//
//  NewMomentViewController.m
//  NewStock
//
//  Created by Willey on 16/11/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "NewMomentViewController.h"
#import "PostViewController.h"
#import "PostSecretViewController.h"
#import "MomentTalkViewController.h"
#import "MomentSecretViewController.h"
#import "MomentHeadlineViewController.h"
#import "QuickNewsViewController.h"
#import "LoginViewController.h"
#import "UserInfoInstance.h"
#import "MomentUnreadCountAPI.h"
#import "Defination.h"
#import "SharedInstance.h"
#import "MarketConfig.h"

@interface NewMomentViewController ()

@property (nonatomic, strong) MomentUnreadCountAPI *unreadCountAPI;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) DMLazyScrollView *lazyScrollView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation NewMomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBtnImg:nil];
    [self setLeftBtnImg:nil];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    self.title = @"股侠圈";
    
    [_navBar addSubview:self.segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_segmentedControl.superview).offset(-8);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(180);
        make.centerX.equalTo(_segmentedControl.superview.mas_centerX);
    }];
    
    [self.view addSubview:self.lazyScrollView];
    [_lazyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lazyScrollView.superview).offset(64);
        make.left.equalTo(_lazyScrollView.superview).offset(0);
        make.right.equalTo(_lazyScrollView.superview).offset(0);
        make.bottom.equalTo(_lazyScrollView.superview).offset(0);
    }];
    
    _navBar.backgroundColor = kTitleColor;
    _navBar.line_view.hidden = YES;
    [self.view bringSubviewToFront:_navBar];
    
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToTop) name:STATESBAR_TOUCH_NOTIFICATION object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.timer invalidate];
    _timer = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    if (_isPostVC) {
        [self loadData];
        _isPostVC = NO;
    } else {
        [self getUnreadNum];
    }
    
    [self changeRightBtnImg];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark scrollToTop

- (void)scrollToTop {
    NSLog(@"dsd");
    if (_segmentedControl.selectedSegmentIndex == 0) {
        MomentTalkViewController *vc = (MomentTalkViewController *)_viewControllerArray[0];
        [vc scrollToTop];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        MomentHeadlineViewController *vc = (MomentHeadlineViewController *)_viewControllerArray[1];
        [vc scrollToTop];
    } else if (_segmentedControl.selectedSegmentIndex == 2) {
        QuickNewsViewController *vc = (QuickNewsViewController *)_viewControllerArray[2];
        [vc scrollToTop];
    }
}

#pragma mark loadData

- (void)loadData {
    if (_nativePush == 0) {
        BaseViewController *contr = [_viewControllerArray objectAtIndex:(long)_segmentedControl.selectedSegmentIndex];
        [contr loadData];
    } else if (_nativePush == 1) {
        _segmentedControl.selectedSegmentIndex = 0;
        [_navBar setRightBtnImg:nil];
        [_lazyScrollView moveByPages:0 -_lazyScrollView.currentPage animated:NO];
        BaseViewController *contr = [_viewControllerArray objectAtIndex:0];
        [contr loadData];
    } else if (_nativePush == 3) {
        _segmentedControl.selectedSegmentIndex = 2;
        [_lazyScrollView moveByPages:2 - _lazyScrollView.currentPage animated:NO];
        BaseViewController *contr = [_viewControllerArray objectAtIndex:2];
        [contr loadData];
    }

    _nativePush = 0;
}

- (void)getUnreadNum {
    if ([SystemUtil isSignIn]) {
        [self.unreadCountAPI start];
    } else {
        MomentTalkViewController *talkVc = (MomentTalkViewController *)_viewControllerArray[0];
        talkVc.unreadCount = 0;
    }
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSDictionary *forumDict = request.responseJSONObject[@"S_FORUM"];
    NSNumber *fCount = forumDict[@"num"];
    MomentTalkViewController *talkVc = (MomentTalkViewController *)_viewControllerArray[0];
    talkVc.unreadCount = fCount.integerValue;
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
}

#pragma mark - DMLazyScrollViewDelegate
- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentedControl setSelectedSegmentIndex:pageIndex animated:YES];
    [self changeRightBtnImg];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    [_lazyScrollView moveByPages:segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:NO];
    [self loadData];
    [self changeRightBtnImg];
}

- (UIViewController *)controllerAtIndex:(NSInteger)index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        if (index == 0) {
            MomentTalkViewController *contr = [[MomentTalkViewController alloc] init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        } else if(index == 1) {
            MomentHeadlineViewController *vc = [MomentHeadlineViewController new];
            [_viewControllerArray replaceObjectAtIndex:index withObject:vc];
            return vc;
        } else if (index == 2) {
            QuickNewsViewController *vc = [QuickNewsViewController new];
            [_viewControllerArray replaceObjectAtIndex:index withObject:vc];
            return vc;
        }
    }
    return res;
}

#pragma mark - navbar tap
- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        [self post];
    } else if (_segmentedControl.selectedSegmentIndex == 2) {
        [self share];
    }
}

#pragma mark function

- (void)share {
    
    NSDictionary *param = @{@"id":@1,@"count":@10};
    NSString *url = [MarketConfig getUrlWithPath:H5_LEIDA_NEWS_LIST Param:param];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *c = @"24小时不间断播报，一手头条即时掌握";
    UIImage *image = [UIImage imageNamed:@"shareLogo"];
    
    [SharedInstance sharedSharedInstance].image = image;
    [SharedInstance sharedSharedInstance].tt = @"7*24 小时快讯";
    [SharedInstance sharedSharedInstance].c = c;
    [SharedInstance sharedSharedInstance].url = url;
    [SharedInstance sharedSharedInstance].res_code = @"S_HOTNEWS";
    [SharedInstance sharedSharedInstance].sid = @"";
    [[SharedInstance sharedSharedInstance] shareWithImage:NO];
    
}

- (void)post {
    if ([SystemUtil isSignIn]) {
        if (_segmentedControl.selectedSegmentIndex == 0) {
            PostViewController *viewController = [[PostViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
            [self.navigationController presentViewController:nav animated:YES completion:^{}];
        }
        _isPostVC = YES;
    }else {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

- (void)changeRightBtnImg {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        if ([UserInfoInstance sharedUserInfoInstance].userInfoModel.aty.integerValue == 3 || [UserInfoInstance sharedUserInfoInstance].userInfoModel.aty.integerValue == 4) {
            [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_post_btn_nor"]];
        } else {
            [_navBar setRightBtnImg:nil];
        }
    } else if (_segmentedControl.selectedSegmentIndex == 2) {
        [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_share1_nor"]];
    } else {
        [_navBar setRightBtnImg:nil];
    }
}

- (void)timeMethod {
    if (_segmentedControl.selectedSegmentIndex == 2) {
         QuickNewsViewController *vc = (QuickNewsViewController *)_viewControllerArray[2];
        [vc timerRefresh];
    }
}

#pragma mark lazy

- (MomentUnreadCountAPI *)unreadCountAPI {
    if (_unreadCountAPI == nil) {
        _unreadCountAPI = [MomentUnreadCountAPI new];
        _unreadCountAPI.res_code = @"";
        _unreadCountAPI.delegate = self;
    }
    return _unreadCountAPI;
}

- (HMSegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"大V说",@"头条",@"快讯"]];
        _segmentedControl.backgroundColor = [UIColor clearColor];
        _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:1]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kTitleColor};
        
        _segmentedControl.selectionIndicatorColor = kUIColorFromRGB(0xffffff);
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
        _segmentedControl.selectionIndicatorBoxOpacity = 1;
        _segmentedControl.selectionIndicatorBoxMaskToBouns = YES;
        _segmentedControl.selectionIndicatorBoxCornerRadius = 14;
        
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _segmentedControl.layer.borderWidth = 1;
        _segmentedControl.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
        _segmentedControl.layer.cornerRadius = 14;
        _segmentedControl.layer.masksToBounds = YES;
        [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (DMLazyScrollView *)lazyScrollView {
    if (_lazyScrollView == nil) {
        NSUInteger numberOfPages = 3;
        _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
        for (NSUInteger k = 0; k < numberOfPages; ++k) {
            [_viewControllerArray addObject:[NSNull null]];
        }
        _lazyScrollView.scrollsToTop = NO;
        _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, _nMainViewWidth, _nMainViewHeight)];
        [_lazyScrollView setEnableCircularScroll:NO];
        [_lazyScrollView setAutoPlay:NO];
        
        __weak __typeof(&*self)weakSelf = self;
        _lazyScrollView.dataSource = ^(NSUInteger index) {
            return [weakSelf controllerAtIndex:index];
        };
        _lazyScrollView.numberOfPages = numberOfPages;
        _lazyScrollView.controlDelegate = self;
    }
    return _lazyScrollView;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:[MarketConfig getRefreshTime] target:self selector:@selector(timeMethod) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
