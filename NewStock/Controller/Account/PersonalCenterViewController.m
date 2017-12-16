//
//  PersonalCenterViewController.m
//  NewStock
//
//  Created by Willey on 16/8/24.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "ChangeHeadViewController.h"
#import "UserInfoInstance.h"
#import "WebViewController.h"
#import "MarketConfig.h"
#import "RevisePwViewController.h"
#import "ReviseNameViewController.h"
#import "RevisePhViewController.h"
#import "StockHistoryUtil.h"
#import "LogoutAPI.h"

@interface PersonalCenterViewController ()

@property (nonatomic) ZFSettingItem *item01;
@property (nonatomic) ZFSettingItem *item02;
@property (nonatomic) ZFSettingItem *item11;
@property (nonatomic) ZFSettingItem *item12;
@property (nonatomic) ZFSettingItem *item21;

@property (nonatomic, strong) LogoutAPI *logoutAPI;

@end


@implementation PersonalCenterViewController

- (LogoutAPI *)logoutAPI {

    if (_logoutAPI == nil) {
        _logoutAPI = [LogoutAPI new];
        _logoutAPI.animatingView = self.view;
        _logoutAPI.animatingText = @"正在退出...";
        _logoutAPI.delegate = self;
    }
    return _logoutAPI;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    [_navBar setTitle:self.title];
    
    [self add0SectionItems];
    
    [self add1SectionItems];
    
    if (TO_DO_FLAG)
    {
        [self add2SectionItems];
    }
    
    _getUserInfoAPI = [[GetUserInfoAPI alloc] init];
    _getUserInfoAPI.delegate = self;
    
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _loginBtn.backgroundColor = kUIColorFromRGB(0xffffff);
    
    _loginBtn.layer.masksToBounds = YES;
    [_mainView addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_mainView).offset(-150);
        make.left.equalTo(_mainView).offset(0);
        make.right.equalTo(_mainView).offset(0);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)btnAction:(id)sender {
    if ([SystemUtil isSignIn])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要退出登录吗？"
                                                       delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 101;
        [alert show];
    }
    else
    {
        [self popLoginViewController];
    }
}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 101)
    {
        if(buttonIndex == 0)
        {
            [self.logoutAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
                [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
                [SystemUtil signOut];
                
                [UserInfoInstance sharedUserInfoInstance].userInfoModel = nil;
                [StockHistoryUtil getMyStockFromServer];
                [UserInfoInstance sharedUserInfoInstance].lastIcon = nil;
                [UserInfoInstance sharedUserInfoInstance].postSecretString = nil;
                
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(__kindof APIBaseRequest *request) {
                NSLog(@"退出失败 %@ ",request.responseJSONObject);
            }];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([SystemUtil isSignIn])
    {
        NSString *userId = [SystemUtil getCache:USER_ID];
        _getUserInfoAPI.userId = userId;
        _getUserInfoAPI.ignoreCache = YES;
        _getUserInfoAPI.animatingView = _mainView;
        _getUserInfoAPI.animatingText = @"正在加载";
        
        [_getUserInfoAPI start];
    }
    
    
    
    if ([SystemUtil isSignIn])
    {
        [_loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }
    else
    {
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
}

- (void)analysisData:(NSDictionary *)json {
    UserInfoModel *model = [MTLJSONAdapter modelOfClass:[UserInfoModel class] fromJSONDictionary:json error:nil];
    [UserInfoInstance sharedUserInfoInstance].userInfoModel = model;

    self.item01.imgUrl = model.origin;
    self.item02.detail = model.n;
    self.item11.detail = [NSString stringWithFormat:@"已绑定：%@",[SystemUtil getMobileString:model.ph]];
    
    [_tableView reloadData];
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed:%@",request.responseJSONObject);
    [self analysisData:request.responseJSONObject];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems {
    __weak typeof(self) weakSelf = self;
    UserInfoModel *model = [UserInfoInstance sharedUserInfoInstance].userInfoModel;

    self.item01 = [ZFSettingItem itemWithIcon:@"" title:@"头像" type:ZFSettingItemTypeImage imgUrl:model.origin];
    self.item01.operation = ^{
        ChangeHeadViewController *viewController = [[ChangeHeadViewController alloc] init];
        viewController.headerImgUrl = [UserInfoInstance sharedUserInfoInstance].userInfoModel.origin;
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
    

    self.item02 = [ZFSettingItem itemWithIcon:@"" title:@"昵称" type:ZFSettingItemTypeDetail detail:model.n];
    self.item02.operation = ^{
        ReviseNameViewController *viewController = [[ReviseNameViewController alloc] init];
        viewController.nickName = [UserInfoInstance sharedUserInfoInstance].userInfoModel.n;
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    //group.header = @"基本设置";
    group.items = @[self.item01, self.item02];
    [_allGroups addObject:group];
}

- (void)add1SectionItems {
    __weak typeof(self) weakSelf = self;
    UserInfoModel *model = [UserInfoInstance sharedUserInfoInstance].userInfoModel;
    
    self.item11 = [ZFSettingItem itemWithIcon:@"" title:@"修改手机号码" type:ZFSettingItemTypeDetail detail:[NSString stringWithFormat:@"已绑定：%@",[SystemUtil getMobileString:model.ph]]];
    self.item11.operation = ^{
        RevisePhViewController *viewController = [[RevisePhViewController alloc] init];
        viewController.type = REVISE_PH_STEP_ONE;
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
    
    self.item12 = [ZFSettingItem itemWithIcon:@"" title:@"修改登录密码" type:ZFSettingItemTypeArrow];
    self.item12.operation = ^{
        RevisePwViewController *viewController = [[RevisePwViewController alloc] init];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    //group.header = @"基本设置";
    group.items = @[self.item11,self.item12];
    [_allGroups addObject:group];
}

#pragma mark 添加第1组的模型数据
- (void)add2SectionItems {
    __weak typeof(self) weakSelf = self;

    self.item21 = [ZFSettingItem itemWithIcon:@"" title:@"我的等级" type:ZFSettingItemTypeArrow];
    self.item21.operation = ^{
        //        UIViewController *helpVC = [[UIViewController alloc] init];
        //        helpVC.view.backgroundColor = [UIColor grayColor];
        //        helpVC.title = @"帮助";
        //        [weakSelf.navigationController pushViewController:helpVC animated:YES];
        
        WebViewController *viewController = [[WebViewController alloc] init];
        viewController.mytitle = @"我的等级";
        
        NSString *userId = [SystemUtil getCache:USER_ID];
        NSDictionary *param = @{@"id":userId};
        
        NSString *myUrl = [MarketConfig getUrlWithPath:H5_ACCOUNT_MY_GRADE Param:param];
        NSString *urlStr = [myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        viewController.myUrl = urlStr;
        
        //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
    

    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    //    group.header = @"高级设置";
    //    group.footer = @"xxxxxxxx";
    group.items = @[self.item21];
    [_allGroups addObject:group];
}

@end
