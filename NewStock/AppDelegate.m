//
//  AppDelegate.m
//  NewStock
//
//  Created by Willey on 16/7/5.
//  Copyright © 2016年 Willey. All rights reserved.


#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "MyStockViewController.h"
#import "AccountViewController.h"
//#import "MarketViewController.h"
#import "NewMomentViewController.h"
#import "OptionalViewController.h"
#import "SuggestViewController.h"
#import "GoodStockViewController.h"
#import "TigerSearchViewController.h"
#import "TaoSearchPeopleViewController.h"

#import "APINetworkConfig.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "APIUrlArgumentsFilter.h"
#import "SystemUtil.h"
#import "Defination.h"
#import "MMPlaceHolder.h"
#import "VersionManager.h"
#import "SDVersion.h"
#import <Masonry.h>
#import "CommendPopView.h"
#import "CustomUrlProtocol.h"

#import "StockCodesAPI.h"
#import "TaoAllDepartmentAPI.h"
#import "TaoAllUserAPI.h"
#import "GetMyStockAPI.h"
#import "ResetMyStockAPI.h"
#import "TaoDepartmentInfoModel.h"
#import "TaoHotPeopleModel.h"
#import "GetUserLoginStateAPI.h"

#import "StockHistoryUtil.h"
#import "AFSecurityPolicy.h"
#import "UMMobClick/MobClick.h"
#import "MessageInstance.h"
#import "UrlRedirectAction.h"
#import "UserInfoInstance.h"
#import "NativeUrlRedirectAction.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//
////微信SDK头文件
//#import "WXApi.h"
//
////新浪微博SDK头文件
//#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

#import "LunchAPPUpdateAPI.h"

//#import <TKWebViewApp/TKWebViewApp.h>
//#import <TKOpen/TKOpen.h>

#import "WebViewController.h"
#import "Reachability.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface AppDelegate () <JPUSHRegisterDelegate,CommendPopViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) StockCodesAPI *stockCodesInfoAPI;
@property (nonatomic, strong) TaoAllDepartmentAPI *departmentAllAPI;
@property (nonatomic, strong) TaoAllUserAPI *allUserAPI;
@property (nonatomic, strong) GetUserLoginStateAPI *getUserLoginStateAPI;
@property (nonatomic, strong) GetMyStockAPI *getMyStockAPI;
@property (nonatomic, strong) ResetMyStockAPI *resetMyStockAPI;
@property (nonatomic, strong) LunchAPPUpdateAPI *lunchUpdateAPI;

@property (nonatomic, weak) UIView *blackView;
@property (nonatomic, weak) CommendPopView *popView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = self.navigationController;

    [self.window makeKeyAndVisible];
//----------------------------------------------------------------------
    
    //网络设置，添加公共参数
    [self setupRequestFilters];
    
    //cookie
    if ([SystemUtil isSignIn]) {
        [SystemUtil setCookie];
    }
    
    //检查网络
    [self checkNetState];
    
    //检查登录状态
    [self getUserLoginStateFunc];
    
    //注册 urlprotocol 拦截请求
    [NSURLProtocol registerClass:[CustomUrlProtocol class]];
    
    //请求码表
    dispatch_async(dispatch_get_main_queue(), ^{
        [self checkAllUsers];
        [self checkStockCodes];
        [self checkAllDepartment];
    });
    
//----------------------------------------------------------------------
   
    //120s 定时弹出评论界面
    [self showAppStoreCommentView];
   
    //友盟初始化
    [self initUMengAnalytice];

    //极光推送初始化
    [self initJPush:launchOptions];
    
    //版本控制
    [self checkVersion];
    
    //初始化自选股
    [StockHistoryUtil initMyStock];
    
    //初始化分享功能
    [self initShareSDK];
    
    //3D touch
    [self add3DTouch];
    
    //东莞证券开户插件
    [[TKAppEngine shareInstance] start];
    
    //查看是否有未读消息
    [[MessageInstance sharedMessageInstance] requestUnReadMsg];

    return YES;
}

#pragma mark 3D touch --------

- (void)add3DTouch {
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        return;
    }
    
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3d_mingdan_nor"];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"ns" localizedTitle:@"牛散名单" localizedSubtitle:nil icon:icon1 userInfo:nil];
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3d_hangqing_nor"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"hq" localizedTitle:@"行情" localizedSubtitle:nil icon:icon2 userInfo:nil];
    
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3d_zixuan_nor"];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"zx" localizedTitle:@"自选" localizedSubtitle:nil icon:icon3 userInfo:nil];
    
    UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3d_search_nor"];
    UIApplicationShortcutItem *item4 = [[UIApplicationShortcutItem alloc] initWithType:@"ss" localizedTitle:@"龙虎榜搜索" localizedSubtitle:nil icon:icon4 userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3,item4];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self.navigationController.visibleViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    if ([shortcutItem.type isEqualToString:@"zx"]) {
        OptionalViewController *optVC = (OptionalViewController *)_tabBarController.backingViewControllers[1];
        optVC.hangQing = 2;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tabBarController.tab btnClick:_tabBarController.tab.btn2];
        });
    } else if ([shortcutItem.type isEqualToString:@"hq"]) {
        OptionalViewController *optVC = (OptionalViewController *)_tabBarController.backingViewControllers[1];
        optVC.hangQing = 1;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tabBarController.tab btnClick:_tabBarController.tab.btn2];
        });
    } else if ([shortcutItem.type isEqualToString:@"ss"]) {
        TigerSearchViewController *vc = [TigerSearchViewController new];
        [self.navigationController pushViewController:vc animated:NO];
    } else if ([shortcutItem.type isEqualToString:@"ns"]) {
        TaoSearchPeopleViewController *vc = [TaoSearchPeopleViewController new];
        [self.navigationController pushViewController:vc animated:NO];
    }
}

#pragma mark 120s商店评论弹框  APP首次启动引导页

- (void)showAppStoreCommentView {
    NSString *strFirstLoan = [SystemUtil getCache:versionStr];
    
    if([strFirstLoan isEqualToString:@""]) {
        [SystemUtil putCache:versionStr value:@"NO"];
        [self showIntroView];
//        [self addTimer];
    } else if ([strFirstLoan isEqualToString:@"NO"]){
//        [self addTimer];
    }
}

- (void)showIntroView {
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introImg01"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introImg02"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introImg03"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introImg04"]];
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    
    [intro showInView:self.window animateDuration:0.0];
}

#pragma states bar touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint p = [event.allTouches.anyObject locationInView:_window];
//    NSLog(@"%@",NSStringFromCGPoint(p));
    CGRect r = [UIApplication sharedApplication].statusBarFrame;
    if (CGRectContainsPoint(r, p)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:STATESBAR_TOUCH_NOTIFICATION object:nil];
    }
}

#pragma mark popView -------------------- start -------------------

- (void)getUserLoginStateFunc {
    self.getUserLoginStateAPI = [GetUserLoginStateAPI new];
    [self.getUserLoginStateAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
//        NSLog(@"%@",request.responseJSONObject);
        if (request.responseJSONObject == NULL) {
            [SystemUtil signOut];
            
            [UserInfoInstance sharedUserInfoInstance].userInfoModel = nil;
            [StockHistoryUtil getMyStockFromServer];
            [UserInfoInstance sharedUserInfoInstance].lastIcon = nil;
            [UserInfoInstance sharedUserInfoInstance].postSecretString = nil;
        } else {
            [StockHistoryUtil getMyStockFromServer];
            
            UserInfoModel *model = [MTLJSONAdapter modelOfClass:[UserInfoModel class] fromJSONDictionary:request.responseJSONObject error:nil];
            [UserInfoInstance sharedUserInfoInstance].userInfoModel = model;
            
//            NSLog(@"user info model:%@",model);
            [SystemUtil putCache:USER_NAME value:model.ph];
//            [SystemUtil putCache:INPUT_USER_NAME value:model.ph];
            
            [SystemUtil putCache:USER_PW value:@""];
            [SystemUtil putCache:USER_ID value:model.userId];
            
            [SystemUtil saveCookie];
            [SystemUtil setCookie];
        }
    } failure:^(__kindof APIBaseRequest *request) {
        
    }];
}

- (void)deleteBtnClick:(UIButton *)btn {
    [self commendPopViewDelegate:0];
}

- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(popCommendView) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)popCommendView {
    [SystemUtil putCache:versionStr value:@"YES"];
    UIView *blackView = [[UIView alloc] initWithFrame:self.window.bounds];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.7;
    [self.window addSubview:blackView];
    self.blackView = blackView;
    
    CommendPopView *popView = [[CommendPopView alloc] init];
    [self.navigationController.visibleViewController.view endEditing:YES];
    [self.window addSubview:popView];
    popView.delegate = self;
    self.popView = popView;
    
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.window);
        make.width.equalTo(@(250 * kScale));
        make.height.equalTo(@(250 * kScale));
    }];
    
}

- (void)commendPopViewDelegate:(NSInteger)index {
    
    NSLog(@"%zd",index);
    
    if (index == 0) {

    }else if (index == 1) {
        
    }else if (index == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1160573329"]];
    }else if (index == 3) {
        SuggestViewController *suggessVC = [[SuggestViewController alloc] init];
        [self.navigationController pushViewController:suggessVC animated:YES];
    }
    [self.popView removeFromSuperview];
    [self.blackView removeFromSuperview];
}

#pragma mark popView ---------------------- end --------------------

- (void)checkVersion {
    [self.lunchUpdateAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSString *must = [request.responseJSONObject objectForKey:@"must"];
        if (must.integerValue == 1) {
            [VersionManager checkVerSion];
        }
    } failure:nil];
}

- (void)initUMengAnalytice {
    UMConfigInstance.appKey = UM_SOCIALKEY;
    UMConfigInstance.channelId = @"AppStore";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}

- (void)initJPush:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
//    else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        } else {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

}

- (WDNavController *)navigationController {
    if (_navigationController == nil) {
        WDNavController *navigationController = [[WDNavController alloc] initWithRootViewController:self.tabBarController];
        navigationController.navigationBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];
        navigationController.navigationBarHidden = YES;

        _navigationController = navigationController;
    }
    return _navigationController;
}

- (WXTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        WXTabBarController *tabBarController = [[WXTabBarController alloc] init];
        
        //4
        AccountViewController *accountViewController      = [[AccountViewController alloc] init];
        UIImage *contactsImage                     = [UIImage imageNamed:@"tabbar_account"];
        UIImage *contactsHLImage                   = [UIImage imageNamed:@"tabbar_accountHL"];
        accountViewController.title                = @"我的";
        accountViewController.tabBarItem           = [[UITabBarItem alloc] initWithTitle:@"我的" image:contactsImage selectedImage:contactsHLImage];
        accountViewController.view.backgroundColor = [UIColor colorWithRed:115 / 255.0 green:155 / 255.0 blue:6 / 255.0 alpha:1];
        
        //2
        GoodStockViewController *goodViewController         = [[GoodStockViewController alloc] init];
        UIImage *goodStockImage                    = [UIImage imageNamed:@"tabbar_myStock"];
        UIImage *goodStockHLImage                  = [UIImage imageNamed:@"tabbar_myStockHL"];
        goodViewController.title                   = @"淘牛股";
        goodViewController.tabBarItem              = [[UITabBarItem alloc] initWithTitle:@"淘牛股" image:goodStockImage selectedImage:goodStockHLImage];
        goodViewController.view.backgroundColor    = [UIColor colorWithRed:48 / 255.0 green:67 / 255.0 blue:78 / 255.0 alpha:1];


        //3
        NewMomentViewController *momentViewController       = [[NewMomentViewController alloc] init];
        UIImage *meImage                           = [UIImage imageNamed:@"tabbar_moment"];
        UIImage *meHLImage                         = [UIImage imageNamed:@"tabbar_momentHL"];
        momentViewController.title                 = @"股侠圈";
        momentViewController.tabBarItem            = [[UITabBarItem alloc] initWithTitle:@"股侠圈" image:meImage selectedImage:meHLImage];
        momentViewController.view.backgroundColor  = [UIColor colorWithRed:199 / 255.0 green:135 / 255.0 blue:56 / 255.0 alpha:1];
        
        //1
        MainViewController *mainViewController         = [[MainViewController alloc] init];
        UIImage *mainframeImage                    = [UIImage imageNamed:@"tabbar_discovery"];
        UIImage *mainframeHLImage                  = [UIImage imageNamed:@"tabbar_discoveryHL"];
        mainViewController.title                   = @"发现";
        mainViewController.tabBarItem              = [[UITabBarItem alloc] initWithTitle:@"发现" image:mainframeImage selectedImage:mainframeHLImage];
        mainViewController.view.backgroundColor    = [UIColor colorWithRed:255 / 255.0 green:110 / 255.0 blue:25 / 255.0 alpha:1];
        
        //0
        OptionalViewController *optionalViewController = [[OptionalViewController alloc] init];
        UIImage *discoveryImage                     = [UIImage imageNamed:@"tabbar_myStock"];
        UIImage *discoveryHLImage                   = [UIImage imageNamed:@"tabbar_myStockHL"];
        optionalViewController.title                 = @"自选";
        optionalViewController.tabBarItem            = [[UITabBarItem alloc] initWithTitle:@"自选" image:discoveryImage selectedImage:discoveryHLImage];
        optionalViewController.view.backgroundColor  = [UIColor colorWithRed:32 / 255.0 green:85 / 255.0 blue:128 / 255.0 alpha:1];

        _curTitle = @"发现";
        _curViewController = (MainViewController *)mainViewController;
        
        tabBarController.viewControllers = @[
                                             mainViewController,
                                             optionalViewController,
                                             goodViewController,
                                             momentViewController,
                                             accountViewController,
                                             
                                             ];
        tabBarController.delegate = self;
        _tabBarController = tabBarController;
        
    }
    return _tabBarController;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (_curTitle) {
        [MobClick endLogPageView:_curTitle];
        NSLog(@"---------事件统计结束:%@---------",_curTitle);
    }
    
    if(_curViewController)[_curViewController viewWillDisappear:NO];
    if (![viewController isKindOfClass:[AccountViewController class]]) {
        [(BaseViewController *)viewController loadData];
    }
    
//    [MobClick beginLogPageView:viewController.title];
    _curViewController = (BaseViewController *)viewController;
    [_curViewController viewWillAppear:NO];
    _curTitle = viewController.title;
    NSLog(@"---------事件统计:%@---------",_curTitle);

}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:1];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService setBadge:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:1];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService setBadge:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //请求码表
    dispatch_async(dispatch_get_main_queue(), ^{
        [self checkStockCodes];
    });
    [UMSocialSnsService  applicationDidBecomeActive];
    [self.navigationController.visibleViewController viewWillAppear:NO];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
    
    NSString *userId = [SystemUtil getCache:USER_ID];
    NSSet *tags = [[NSSet alloc] initWithObjects:@"ios",@"open",nil];
    [JPUSHService setTags:tags alias:userId fetchCompletionHandle:nil];

}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
    //[rootViewController addNotificationCount];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0 || application.applicationState > 0) {
        //[rootViewController addNotificationCount];
        {
            // 程序在前台或通过点击推送进来的
            NSString *urlStr = [userInfo objectForKey:@"url"];
            if(urlStr)
            {
                NSURL *url = [[NSURL alloc] initWithString:[userInfo objectForKey:@"url"]];
                [UrlRedirectAction redirectActionWithUrl:url from:@"" navigationType:UIWebViewNavigationTypeOther];
                //[UrlRedirectAction redirectActionWithUrl:@"" from:@"" navigationType:UIWebViewNavigationTypeOther];
            }
        }
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
//    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        //[rootViewController addNotificationCount];
        
        // 程序通过点击推送进来的
        NSString *urlStr = [userInfo objectForKey:@"url"];
        if(urlStr) {
//            NSURL *url = [[NSURL alloc] initWithString:[userInfo objectForKey:@"url"]];
//            [UrlRedirectAction redirectActionWithUrl:url from:@"" navigationType:UIWebViewNavigationTypeOther];
            [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:urlStr];
        }

    } else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
//    [NSPropertyListSerialization propertyListFromData:tempData
//                                     mutabilityOption:NSPropertyListImmutable
//                                               format:NULL
//                                     errorDescription:NULL];
    [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}


/**
 *  网络设置，添加公共参数
 */

- (void)checkNetState {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置中打开网络访问权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
            
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
                
            }
        }
    }
}

- (void)setupRequestFilters {
    
    APINetworkConfig *config = [APINetworkConfig sharedInstance];
    config.baseUrl = API_URL;
    
    //公共请求头
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *deviceId = [SystemUtil getUUIDForDevice];
    NSString *deviceType = [SDVersion deviceNameString];
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *deviceSystem = [SystemUtil getIOSVersion];
//    NSString *deviceName = [UIDevice currentDevice].name;
//    NSString *deviceSystemName = [UIDevice currentDevice].systemName;
    if ([H5_OPEN_PARAM isEqualToString:@"vest"]) {
        NSString *lastChar = [appVersion substringFromIndex:appVersion.length - 1];
        lastChar = [NSString stringWithFormat:@"%zd",lastChar.integerValue + 1];
        appVersion = [appVersion stringByReplacingCharactersInRange:NSMakeRange(appVersion.length - 1, 1) withString:lastChar];
    }
    
    NSDictionary *dic = @{@"deviceID":deviceId,
                          @"phoneType":deviceType,
                          @"phoneSystem":deviceSystem,
                          @"appVersion":appVersion,
                          @"adId":adId.length ? adId : @"",
                          @"apiVersion":API_VERSION};
    config.headerDictionary = dic;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

/**
 *  请求、更新码表
 */

- (void)checkAllUsers {
    NSString *path = [StockHistoryUtil getallUserPath];
    
    long long stockCodesVersion = [[SystemUtil getCache:@"allUserVersion"] longLongValue];
    
    _allUserAPI = [[TaoAllUserAPI alloc] initWithLastModified:[NSString stringWithFormat:@"%lld", stockCodesVersion]];
    
    [_allUserAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        BOOL bModified = [[_allUserAPI.responseJSONObject objectForKey:@"mdf"] boolValue];
        if (bModified)  {
            NSString *lastModified = [_allUserAPI.responseJSONObject objectForKey:@"lmdf"];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [StockCodesInstance sharedStockCodesInstance].userArray = [MTLJSONAdapter modelsOfClass:[TaoHotPeopleModel class] fromJSONArray:[_allUserAPI.responseJSONObject objectForKey:@"list"] error:nil];
                [NSKeyedArchiver archiveRootObject:[StockCodesInstance sharedStockCodesInstance].userArray toFile:path];
                [SystemUtil putCache:@"allUserVersion" value:lastModified];
            });
        } else {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [StockCodesInstance sharedStockCodesInstance].userArray = arr;
                });
            });
        }
        
    } failure:^(APIBaseRequest *request) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            dispatch_async(dispatch_get_main_queue(), ^{
                [StockCodesInstance sharedStockCodesInstance].userArray = arr;
            });
        });
    }];
}

- (void)checkAllDepartment {
    NSString *path = [StockHistoryUtil getStockDepartsmentPath];
    
    long long stockCodesVersion = [[SystemUtil getCache:@"departmentVersion"] longLongValue];
    
    _departmentAllAPI = [[TaoAllDepartmentAPI alloc] initWithLastModified:[NSString stringWithFormat:@"%lld", stockCodesVersion]];

    [_departmentAllAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        BOOL bModified = [[_departmentAllAPI.responseJSONObject objectForKey:@"mdf"] boolValue];
        if (bModified)  {
            NSString *lastModified = [_departmentAllAPI.responseJSONObject objectForKey:@"lmdf"];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [StockCodesInstance sharedStockCodesInstance].departmentArray = [MTLJSONAdapter modelsOfClass:[TaoDepartmentInfoModel class] fromJSONArray:[_departmentAllAPI.responseJSONObject objectForKey:@"list"] error:nil];
                [NSKeyedArchiver archiveRootObject:[StockCodesInstance sharedStockCodesInstance].departmentArray toFile:path];
                [SystemUtil putCache:@"departmentVersion" value:lastModified];
            });
        } else {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
               NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [StockCodesInstance sharedStockCodesInstance].departmentArray = arr;
                });
            });
        }
    } failure:^(APIBaseRequest *request) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            dispatch_async(dispatch_get_main_queue(), ^{
                [StockCodesInstance sharedStockCodesInstance].departmentArray = arr;
            });
        });
    }];
}

- (void)checkStockCodes {
    NSString *path = [StockHistoryUtil getStockCodesPath];
    
    long long stockCodesVersion = [[SystemUtil getCache:@"stockCodesVersion"] longLongValue];
    
    _stockCodesInfoAPI = [[StockCodesAPI alloc] initWithLastModified:[NSString stringWithFormat:@"%lld", stockCodesVersion]];

    [_stockCodesInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        BOOL bModified = [[_stockCodesInfoAPI.responseJSONObject objectForKey:@"modified"] boolValue];
        if (bModified)  {
            NSString *lastModified = [_stockCodesInfoAPI.responseJSONObject objectForKey:@"lastModified"];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [StockCodesInstance sharedStockCodesInstance].stockCodesArray = [MTLJSONAdapter modelsOfClass:[StockCodeInfo class] fromJSONArray:[_stockCodesInfoAPI.responseJSONObject objectForKey:@"gxCodeList"] error:nil];
                self.stockCodesModel = [MTLJSONAdapter modelOfClass:[StockCodesModel class] fromJSONDictionary:_stockCodesInfoAPI.responseJSONObject error:nil];
                [NSKeyedArchiver archiveRootObject:[StockCodesInstance sharedStockCodesInstance].stockCodesArray toFile:path];
                [SystemUtil putCache:@"stockCodesVersion" value:lastModified];
            });
        } else {
            if ([StockCodesInstance sharedStockCodesInstance].stockCodesArray.count > 1) {
                return ;
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [StockCodesInstance sharedStockCodesInstance].stockCodesArray = arr;
                });
            });
        }
    } failure:^(APIBaseRequest *request) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            dispatch_async(dispatch_get_main_queue(), ^{
                [StockCodesInstance sharedStockCodesInstance].stockCodesArray = arr;
            });
        });
    }];
}

- (void)initShareSDK {
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UM_SOCIALKEY];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:UM_WXAppId appSecret:UM_WXAppSecret url:@"http://www.guguaixia.com"];
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:UM_QQAPPID appKey:UM_QQAPPKEY url:@"http://www.guguaixia.com"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:UM_Sina_Appkey
                                              secret:UM_Sina_secret
                                         RedirectURL:@"http://www.guguaixia.com"];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if(self.isEable) {
        return UIInterfaceOrientationMaskLandscape;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray * _Nullable))restorationHandler {
    
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webUrl = userActivity.webpageURL;
        if ([webUrl.host isEqualToString:@"www.guguaixia.com"]) {
            NSString *str = [webUrl.absoluteString stringByReplacingOccurrencesOfString:@"/applink" withString:@""];
            str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            WebViewController *webView = [[WebViewController alloc]init];
            webView.myUrl = str;
            [self.navigationController pushViewController:webView animated:YES];
        }else {
            [[UIApplication sharedApplication]openURL:webUrl];
        }
    }
    return YES;
}

- (LunchAPPUpdateAPI *)lunchUpdateAPI {
    if (_lunchUpdateAPI == nil) {
        _lunchUpdateAPI = [LunchAPPUpdateAPI new];
    }
    return _lunchUpdateAPI;
}

@end
