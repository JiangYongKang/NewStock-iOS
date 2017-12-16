//

//行情页面 native://HQ0001 ；
//牛散达人 native://TG0100 ;
//龙虎榜native://TG0200

#import "NativeUrlRedirectAction.h"
#import "TaoSearchPeopleViewController.h"
#import "WebViewController.h"
#import "TigerSearchViewController.h"
#import "WXTabBarController.h"
#import "OptionalViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "BoardDetailListViewController.h"
#import "LoginViewController.h"
#import "TipOffViewController.h"
#import "FollowAndFansController.h"
#import "DetailWebViewController.h"
#import "NewMomentViewController.h"
#import "RegisterViewController.h"
#import "ReviseNameViewController.h"
#import "ChangeHeadViewController.h"
#import "PostSecretViewController.h"
#import "PostViewController.h"
#import "NewStockCalenderViewController.h"
#import "ScoreTaskViewController.h"
#import "AuthorViewController.h"
#import "MainThemeViewController.h"
#import "HotThemeListViewController.h"
#import "MyStockNewsViewController.h"
#import "MyStockAnnounceListViewController.h"
#import "MyStockOptionalViewController.h"
#import "TaoSearchStockViewController.h"
#import "TaosSearchDepartmentViewController.h"
#import "TaoDeepTigerViewController.h"
#import "TaoZhuLiStockListViewController.h"
#import "TaoCXZYViewController.h"
#import "TaoNewStockPoolViewController.h"
#import "TaoLimitAnalysisViewController.h"
#import "TaoContinueLimitCatchViewController.h"

#import "AppDelegate.h"
#import "StockListModel.h"
#import "UserInfoInstance.h"
#import "SharedInstance.h"
#import "MsgAlertPopView.h"
#import "BigVPopView.h"
#import <TKOpen/TKOpen.h>

@interface NativeUrlRedirectAction ()<MsgAlertPopViewDelegate,BigVPopViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *nmDict;

@property (nonatomic, strong) MsgAlertPopView *popView;

@property (nonatomic) BigVPopView *bigVPopView;

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation NativeUrlRedirectAction
SYNTHESIZE_SINGLETON_FOR_CLASS(NativeUrlRedirectAction)

- (void)redictNativeUrl:(NSString *)url {
    NSLog(@"%@",url);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    WXTabBarController *tabbarVC = appDelegate.tabBarController;
    
    if ([url hasPrefix:@"native://"]) {
        
        NSString *subUrl = [url substringFromIndex:9];
        
        if ([subUrl hasPrefix:@"Alert?"]) {
            NSString *subStr = [subUrl substringFromIndex:6];
            [self dealWithAlert:subStr];
            return;
        }
        
        if ([subUrl isEqualToString:@"HQ0001"]) {
            [appDelegate.navigationController popToRootViewControllerAnimated:NO];
            OptionalViewController *optVC = (OptionalViewController *)tabbarVC.backingViewControllers[1];
            optVC.hangQing = 1;
            [tabbarVC.tab btnClick:tabbarVC.tab.btn2];
        } else if ([subUrl isEqualToString:@"TG0100"]) {
            TaoSearchPeopleViewController *vc = [TaoSearchPeopleViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl isEqualToString:@"TG0200"]) {
            TigerSearchViewController *vc = [TigerSearchViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"HQ1000"]) {
            NSDictionary *dic = [UrlRedirectAction parseURLParams:[subUrl substringFromIndex:7]];
            NSString *symbolTyp = [dic objectForKey:@"symbolTyp"];
            if (([symbolTyp intValue] == 1) || ([symbolTyp intValue] == 2)) {
                IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                IndexInfoModel *model = [[IndexInfoModel alloc] init];
                model.marketCd = [dic objectForKey:@"marketCd"];
                model.symbol = [dic objectForKey:@"symbol"];
                model.symbolName = @"";
                model.symbolTyp = [dic objectForKey:@"symbolTyp"];
                
                viewController.indexModel = model;
                [appDelegate.navigationController pushViewController:viewController animated:YES];
            } else {
                StockListModel *model = [[StockListModel alloc] init];
                model.marketCd = [dic objectForKey:@"marketCd"];
                model.symbol = [dic objectForKey:@"symbol"];
                model.symbolName = @"";
                model.symbolTyp = [dic objectForKey:@"symbolTyp"];
                
                StockChartViewController *viewController = [[StockChartViewController alloc] init];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                viewController.stockListModel = model;
                [appDelegate.navigationController pushViewController:viewController animated:YES];
            }
        } else if ([subUrl hasPrefix:@"Board"]) {
            NSDictionary *dic = [UrlRedirectAction parseURLParams:[subUrl substringFromIndex:6]];
            BoardDetailListViewController *viewController = [[BoardDetailListViewController alloc] init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            BoardListModel *model = [[BoardListModel alloc] init];
            model.marketCd = [dic objectForKey:@"marketCd"];
            model.symbol = [dic objectForKey:@"symbol"];
            model.industryName = [dic objectForKey:@"industryName"];
            model.symbolTyp = [dic objectForKey:@"symbolTyp"];
            
            NSAssert(model.symbol.length != 0, @"缺少板块代码");
            
            viewController.title = model.industryName;
            viewController.boardListModel = model;
            [appDelegate.navigationController pushViewController:viewController animated:YES];
        } else if ([subUrl hasPrefix:@"Login"]) {
            if ([SystemUtil isSignIn]) {
                return;
            }
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.navigationController pushViewController:loginViewController animated:YES];
        } else if ([subUrl hasPrefix:@"CM0103"]) {
            TipOffViewController *viewController = [[TipOffViewController alloc] init];
            NSString *subStr = [subUrl substringFromIndex:10];
            viewController.contentId = subStr;
            viewController.ty = @"S_COMMENT";
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.navigationController pushViewController:viewController animated:YES];
        } else if ([subUrl hasPrefix:@"FM0100"]) {
            NSLog(@"帖子列表");
            [appDelegate.navigationController popToRootViewControllerAnimated:NO];
            NewMomentViewController *momentVC = (NewMomentViewController *)tabbarVC.backingViewControllers[3];
            momentVC.nativePush = 1;
            [tabbarVC.tab btnClick:tabbarVC.tab.btn4];
        } else if ([subUrl hasPrefix:@"FM0400"]) {
            NSLog(@"匿名列表");
//            [appDelegate.navigationController popToRootViewControllerAnimated:NO];
//            NewMomentViewController *momentVC = (NewMomentViewController *)tabbarVC.backingViewControllers[3];
//            momentVC.nativePush = 2;
//            [tabbarVC.tab btnClick:tabbarVC.tab.btn4];
        } else if ([subUrl hasPrefix:@"FM0500"]) {
            NSLog(@"快讯列表");
            [appDelegate.navigationController popToRootViewControllerAnimated:NO];
            NewMomentViewController *momentVC = (NewMomentViewController *)tabbarVC.backingViewControllers[3];
            momentVC.nativePush = 3;
            [tabbarVC.tab btnClick:tabbarVC.tab.btn4];
        } else if ([subUrl hasPrefix:@"TG0001"]) {
            NSLog(@"淘牛股");
            [appDelegate.navigationController popToRootViewControllerAnimated:NO];
            [tabbarVC.tab btnClick:tabbarVC.tab.btn3];
        } else if ([subUrl hasPrefix:@"TG0300"]) {
            NSLog(@"深度龙虎榜");
            TaoDeepTigerViewController *vc = [TaoDeepTigerViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"MF0101"]) {
            NSLog(@"主力股票池");
            TaoZhuLiStockListViewController *vc = [TaoZhuLiStockListViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"DB0001"]) {
            NSLog(@"db1");
            TaoLimitAnalysisViewController *vc = [TaoLimitAnalysisViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"DB0002"]) {
            NSLog(@"db2");
            TaoContinueLimitCatchViewController *vc = [TaoContinueLimitCatchViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"DB0003"]) {
            NSLog(@"db3");
            TaoCXZYViewController *vc = [TaoCXZYViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"DB0004"]) {
            NSLog(@"db4");
            TaoNewStockPoolViewController *vc = [TaoNewStockPoolViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"ZX0200"]) {
            NSLog(@"自选资讯");
            if ([SystemUtil isSignIn]) {
                MyStockOptionalViewController *vc = [MyStockOptionalViewController new];
                vc.pushIndex = 1;
                [appDelegate.navigationController pushViewController:vc animated:YES];
            } else {
                [appDelegate.navigationController pushViewController:[LoginViewController new] animated:YES];
            }
        } else if ([subUrl hasPrefix:@"HQ1003"]) {
            NSLog(@"自选公告");
            if ([SystemUtil isSignIn]) {
                MyStockOptionalViewController *vc = [MyStockOptionalViewController new];
                vc.pushIndex = 2;
                [appDelegate.navigationController pushViewController:vc animated:YES];
            } else {
                [appDelegate.navigationController pushViewController:[LoginViewController new] animated:YES];
            }
        } else if ([subUrl hasPrefix:@"UpdateIcon"]) {
            NSLog(@"更换头像");
            if ([SystemUtil isSignIn]) {
                ChangeHeadViewController *vc = [ChangeHeadViewController new];
                vc.headerImgUrl = [UserInfoInstance sharedUserInfoInstance].userInfoModel.origin;
                [appDelegate.navigationController pushViewController:vc animated:YES];
            } else {
                [appDelegate.navigationController pushViewController:[LoginViewController new] animated:YES];
            }
        } else if ([subUrl hasPrefix:@"UpdateName"]) {
            NSLog(@"更改昵称");
            if ([SystemUtil isSignIn]) {
                ReviseNameViewController *vc = [ReviseNameViewController new];
                vc.nickName = [UserInfoInstance sharedUserInfoInstance].userInfoModel.n;
                [appDelegate.navigationController pushViewController:vc animated:YES];
            } else {
                [appDelegate.navigationController pushViewController:[LoginViewController new] animated:YES];
            }
        } else if ([subUrl hasPrefix:@"Register"]) {
            NSLog(@"注册");
            RegisterViewController *vc = [RegisterViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"PubDisclose"]) {
            NSLog(@"发匿名");
            if ([SystemUtil isSignIn]) {
                PostSecretViewController *viewController = [[PostSecretViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
                [appDelegate.navigationController presentViewController:nav animated:YES completion:^{}];
            } else {
                [appDelegate.navigationController pushViewController:[LoginViewController new] animated:YES];
            }
        } else if ([subUrl hasPrefix:@"ShareApp"]) {
            NSLog(@"分享APP");
            [self shareToFriend];
        } else if ([subUrl hasPrefix:@"PubForum"]) {
            NSLog(@"发帖");
            if ([SystemUtil isSignIn]) {
                if ([UserInfoInstance sharedUserInfoInstance].userInfoModel.aty.integerValue == 3 || [UserInfoInstance sharedUserInfoInstance].userInfoModel.aty.integerValue == 4) {
                    PostViewController *viewController = [[PostViewController alloc] init];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
                    [appDelegate.navigationController presentViewController:nav animated:YES completion:^{}];
                }
            } else {
                [appDelegate.navigationController pushViewController:[LoginViewController new] animated:YES];
            }
        } else if ([subUrl hasPrefix:@"ApplyNewStock"]) {
            NewStockCalenderViewController *vc = [NewStockCalenderViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"ApplyV"]) {
            NSLog(@"applyv");
            [self popBigV];
        } else if ([subUrl hasPrefix:@"MY0600"]) {
            if ([SystemUtil isSignIn]) {
                [appDelegate.navigationController pushViewController:[ScoreTaskViewController new] animated:YES];
            } else {
                [appDelegate.navigationController pushViewController:[LoginViewController new] animated:YES];
            }
        } else if ([subUrl hasPrefix:@"MY0700"]) {
            AuthorViewController *vc = [AuthorViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"TH0001"]) {
            MainThemeViewController *vc = [MainThemeViewController new];
            vc.ids = [self getPara:@"id" andUrl:[subUrl substringFromIndex:7]];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"TH0000"]) {
            HotThemeListViewController *vc = [HotThemeListViewController new];
            [appDelegate.navigationController pushViewController:vc animated:YES];
        } else if ([subUrl hasPrefix:@"OpenAccount"]) {
            TKOpenController *vc = [[TKOpenController alloc] initWithParams:[NSDictionary dictionaryWithObjectsAndKeys:DGZQ_OPENURL,@"h5Url", nil]];//@"channel_url"
            vc.statusBarBgColor = kUIColorFromRGB(0x00A9FF);
            vc.statusBarStyle = UIStatusBarStyleLightContent;
            [appDelegate.navigationController pushViewController:vc animated:YES];
        }
        
    } else if ([url hasPrefix:@"./"]) {
        url = [url stringByReplacingOccurrencesOfString:@"./" withString:API_URL];
        [self jumpUrl:url];
    } else if ([url hasPrefix:@"http://www.guguaixia.com"] || [url hasPrefix:@"https://www.guguaixia.com"] || [url hasPrefix:API_URL] || [url containsString:@"dgzq.com.cn"] ) {
        [self jumpUrl:url];
    }
    
}

- (void)jumpUrl:(NSString *)url {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([url containsString:@"style="]) {
        
        NSRange range = [url rangeOfString:@"style="];
        NSString *type = [url substringWithRange:NSMakeRange((range.location + range.length), 1)];
        WebViewController *viewController = [[WebViewController alloc] init];
        if ([type isEqualToString:@"1"]) {
            viewController.type = WEB_VIEW_TYPE_TOPCLEAR;
        } else {
            viewController.type = WEB_VIEW_TYPE_TOPCLEAR;
        }
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.myUrl = urlStr;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
        
    } else if ([url containsString:@"HP0105"]) {
        
        WebViewController *viewController = [[WebViewController alloc]init];
        viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.type = WEB_VIEW_TYPE_ZIXUN;
        viewController.hasParam = YES;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
        
    } else if ([url containsString:@"HQ1009"] || [url containsString:@"HQ1008"] || [url containsString:@"HQ1007"] || [url containsString:@"HQ1003"]) {
        
        WebViewController *viewController = [[WebViewController alloc]init];
        viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.type = WEB_VIEW_TYPE_OTHER;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
        
    } else if ([url containsString:@"FM0301"]) {
        
        WebViewController *viewController = [[WebViewController alloc]init];
        viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.type = WEB_VIEW_TYPE_BAGUA;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
        
    } else if ([url containsString:@"FM0501"]) {
        
        WebViewController *viewController = [[WebViewController alloc]init];
        viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.type = WEB_VIEW_TYPE_SHARE;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
        
    } else if ([url containsString:@"MY9902"]) {
        
        WebViewController *viewController = [[WebViewController alloc]init];
        viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.type = WEB_VIEW_TYPE_PERSONAL;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
        
    } else if ([url containsString:@"MY0500"]) {
        
        FollowAndFansController *ffvc = [FollowAndFansController new];
        ffvc.url0500 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ffvc.view.backgroundColor = [UIColor whiteColor];
        ffvc.segmentedControl.selectedSegmentIndex = 0;
        [appDelegate.navigationController pushViewController:ffvc animated:YES];
        
    } else if ([url containsString:@"MY0501"]) {
        
        FollowAndFansController *ffvc = [FollowAndFansController new];
        ffvc.url0501 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ffvc.view.backgroundColor = [UIColor whiteColor];
        ffvc.segmentedControl.selectedSegmentIndex = 1;
        [appDelegate.navigationController pushViewController:ffvc animated:YES];
        
    } else if ([url containsString:@"FM0101"] || [url containsString:@"FM0401"]) {
        
        DetailWebViewController *vc = [DetailWebViewController new];
        vc.type = WEB_VIEW_TYPE_COMMENT;
        vc.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [appDelegate.navigationController pushViewController:vc animated:YES];
        
    } else if ([url containsString:@"DW1001"]) {
        
        WebViewController *viewController = [[WebViewController alloc] init];
        viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.type = WEB_VIEW_TYPE_SHARE;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
        
    } else if ([url containsString:@"TR0001"]) {
        
        WebViewController *viewController = [[WebViewController alloc] init];
        if ([url containsString:@"&"]) {
            url = [NSString stringWithFormat:@"%@&app=%@",url,H5_OPEN_PARAM];
        } else {
            url = [NSString stringWithFormat:@"%@?app=%@",url,H5_OPEN_PARAM];
        }
        viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.type = WEB_VIEW_TYPE_NOR;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
        
    } else if ([url hasPrefix:@"http://www.guguaixia.com"] || [url hasPrefix:@"https://www.guguaixia.com"] || [url hasPrefix:API_URL]) {
        
        WebViewController *viewController = [[WebViewController alloc] init];
        viewController.myUrl = url;
        NSRange urlRange = [url rangeOfString:@"comment=true"];
        if (urlRange.length > 0) {
            viewController.type = WEB_VIEW_TYPE_COMMENT;
        }
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    } else if ([url containsString:@"dgzq.com.cn"]) {
        WebViewController *viewController = [[WebViewController alloc] init];
        viewController.myUrl = url;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
    
}

+ (void)nativePushToStock:(NSString *)n s:(NSString *)s t:(NSString *)t m:(NSString *)m {
    
    if (!(m && s && t && n)) {
        return;
    }
    
    if (([t intValue] == 1) || ([t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = m;
        model.symbol = s;
        model.symbolName = n;
        model.symbolTyp = t;
        
        viewController.indexModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = m;
        model.symbol = s;
        model.symbolName = n;
        model.symbolTyp = t;
        
        viewController.stockListModel = model;
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
}

+ (void)nativePushToTigetStock:(NSString *)n s:(NSString *)s t:(NSString *)t m:(NSString *)m d:(NSString *)d {
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    vc.n = n;
    vc.s = s;
    vc.t = t;
    vc.m = m;
    vc.d = d;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:vc animated:YES];
}

+ (void)nativePushtoTigerDepartment:(NSString *)name startDate:(NSString *)startDate endDate:(NSString *)endDate {
    TaosSearchDepartmentViewController *departmentVC = [TaosSearchDepartmentViewController new];
    departmentVC.name = name;
    departmentVC.startDate = startDate == nil ? @"" : startDate;
    departmentVC.endDate = endDate == nil ? @"" : endDate;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:departmentVC animated:YES];
}

+ (void)nativePushToUserPage:(NSString *)ids {
    NSString *urlStr = [NSString stringWithFormat:@"%@jiabei/MY9902?id=%@",API_URL,ids];
    WebViewController *viewController = [[WebViewController alloc] init];
    viewController.myUrl = urlStr;
    viewController.type = WEB_VIEW_TYPE_PERSONAL;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma mark delegate

- (void)BigVPopViewDelegate:(BigVPopView *)popView andBtnClick:(UIButton *)btn {
    _popView.userInteractionEnabled = NO;
    AuthorViewController *vc = [AuthorViewController new];
    [self.appDelegate.navigationController pushViewController:vc animated:YES];
}

#pragma mark action

- (void)popBigV {
    if ([SystemUtil isSignIn]) {
        [self.bigVPopView showInView:self.appDelegate.navigationController.view fromPoint:CGPointMake(375 * 0.5 * kScale, 667 * 0.5 * kScale) centerAtPoint:CGPointMake(375 * 0.5 * kScale, 667 * 0.5 * kScale) completion:nil];
        _bigVPopView.userInteractionEnabled = YES;
    } else {
        LoginViewController *vc = [LoginViewController new];
        [self.appDelegate.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark func 

- (NSString *)getPara:(NSString *)key andUrl:(NSString *)url {
    NSArray *aArr = [url componentsSeparatedByString:@"&"];
    for (NSString *str in aArr) {
        NSArray *tempArr = [str componentsSeparatedByString:@"="];
        if ([key isEqualToString:tempArr[0]]) {
            return tempArr[1];
        }
    }
    return @"";
}

- (void)dealWithAlert:(NSString *)url {
    [self.nmDict removeAllObjects];
    
    NSArray *array = [url componentsSeparatedByString:@"&"];
    for (NSString *str in array) {
        NSArray *tempArr = [str componentsSeparatedByString:@"="];
        if ([tempArr[0] isEqualToString:@"msg"] || [tempArr[0] isEqualToString:@"turl"]) {
            [self.nmDict setValue:tempArr[1] forKey:tempArr[0]];
        }
    }
    
    self.popView.msg = self.nmDict[@"msg"];
    self.popView.url = self.nmDict[@"turl"];
    [self.popView showInView:self.appDelegate.navigationController.view fromPoint:CGPointMake(375 * 0.5 * kScale, 667 * 0.5 * kScale) centerAtPoint:CGPointMake(375 * 0.5 * kScale, 667 * 0.5 * kScale) completion:nil];
    _popView.userInteractionEnabled = YES;
}

- (void)MsgAlertPopViewBtnClick:(NSString *)url {
    _popView.userInteractionEnabled = NO;
    [self.popView dismissPopup];
    [self redictNativeUrl:url];
}

- (void)shareToFriend {
    
    NSString *url = @"http://www.guguaixia.com";
    NSString *title = @"专注A股市场，大数据雷达实时跟踪资金动向。";
    UIImage *image = [UIImage imageNamed:@"shareLogo"];
    
    [SharedInstance sharedSharedInstance].image = image;
    [SharedInstance sharedSharedInstance].tt = @"股怪侠-短线淘牛股!";
    [SharedInstance sharedSharedInstance].c = title;
    [SharedInstance sharedSharedInstance].url = url;
    [SharedInstance sharedSharedInstance].res_code = @"S_APP";
    [SharedInstance sharedSharedInstance].sid = @"";
    [[SharedInstance sharedSharedInstance] shareWithImage:NO];
}

- (void)exitAPP {
    [UIView animateWithDuration:0.25 animations:^{
        _appDelegate.window.alpha = 0;
//        _appDelegate.window.frame = CGRectMake(0, _appDelegate.window.bounds.size.height, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

#pragma mark lazyloading

- (NSMutableDictionary *)nmDict {
    if (_nmDict == nil) {
        _nmDict = [NSMutableDictionary dictionary];
    }
    return _nmDict;
}

- (MsgAlertPopView *)popView {
    if (_popView == nil) {
        _popView = [[MsgAlertPopView alloc] initWithFrame:CGRectMake(0, 0, 280 * kScale, 150 * kScale)];
        _popView.delegate = self;
    }
    return _popView;
}

- (BigVPopView *)bigVPopView {
    if (_bigVPopView == nil) {
        _bigVPopView = [[BigVPopView alloc] initWithFrame:CGRectMake(0, 0, 280 * kScale, 180 * kScale)];
        _bigVPopView.delegate = self;
    }
    return _bigVPopView;
}

- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return _appDelegate;
}

@end
