//
//  AccountViewController.m
//  NewStock
//
//  Created by Willey on 16/7/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginViewController.h"
#import "MessageViewController.h"
#import "RecordHoldingController.h"
#import "EditHoldingController.h"
#import "SettingViewController.h"
#import "SuggestViewController.h"
#import "WebViewController.h"
#import "EditHoldingController.h"
#import "PersonalCenterViewController.h"
#import "FollowAndFansController.h"
#import "DetailWebViewController.h"
#import "ScoreTaskViewController.h"
#import "AuthorViewController.h"

#import "SquareCashStyleBar.h"
#import "SquareCashStyleBehaviorDefiner.h"
#import "BLKDelegateSplitter.h"
#import "UserInfoHeaderBottomView.h"
#import "BigVPopView.h"

#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"

#import "UIImageView+WebCache.h"
#import "Defination.h"
#import "AppDelegate.h"
#import "MarketConfig.h"
#import "UIImage+ImageEffects.h"
#import "MessageInstance.h"
#import "UserInfoInstance.h"
#import "NativeUrlRedirectAction.h"

#import "SharedInstance.h"

#import "UserInfoModel.h"
#import "UserDynamicModel.h"
#import "UserDynamicCell.h"

static NSString *cellID = @"dynamicCell";

@interface AccountViewController ()<SquareCashStyleBarDelegate,UserInfoTopViewDelegate,UserDynamicCellDelegate,BigVPopViewDelegate>

@property (nonatomic) SquareCashStyleBar *myCustomBar;
@property (nonatomic) BLKDelegateSplitter *delegateSplitter;

@property (nonatomic) UIImageView *headerImgBg;

@property (nonatomic) UIView *tableHeaderView;

@property (nonatomic) BigVPopView *popView;

@property (nonatomic) UserInfoHeaderBottomView *headerBottomView;

//保存是否有未读邮件
@property (nonatomic, assign) BOOL hasUnRead;

//保存 tatusBar 状态
@property (nonatomic, assign) BOOL isDefult;

//下方列表
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL isFirstTimeLoad;

@end

@implementation AccountViewController

- (UIView *)tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 620 * kScale)];//
    }
    return _tableHeaderView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UserDynamicCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (BigVPopView *)popView {
    if (_popView == nil) {
        _popView = [[BigVPopView alloc] initWithFrame:CGRectMake(0, 0, 280 * kScale, 180 * kScale)];
        _popView.delegate = self;
    }
    return _popView;
}

- (UserInfoHeaderBottomView *)headerBottomView {
    if (_headerBottomView == nil) {
        _headerBottomView = [UserInfoHeaderBottomView new];
    }
    return _headerBottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtnImg:nil];
    [_navBar setTitle:@""];
    self.hasUnRead = [[MessageInstance sharedMessageInstance] hasUnReadMsg];
    [_navBar setRightBtnImg:[UIImage imageNamed:@"setting_icon"]];
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_mail_nor-1"]];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.backgroundColor = REFRESH_BG_COLOR;
    self.tableView.tableHeaderView = self.tableHeaderView;

    self.headerImgBg = [[UIImageView alloc] init];
    self.headerImgBg.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImgBg.userInteractionEnabled = YES;
    self.headerImgBg.clipsToBounds = YES;
    [self.tableHeaderView addSubview:self.headerImgBg];
    [self.headerImgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.tableHeaderView);
        make.height.mas_equalTo(180 * kScale);
    }];
    
    UIImageView *ac_more_icon = [[UIImageView alloc] init];
    ac_more_icon.image = [UIImage imageNamed:@"ac_more_icon"];
    ac_more_icon.userInteractionEnabled = YES;
    [self.headerImgBg addSubview:ac_more_icon];
    [ac_more_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerImgBg);
        make.right.equalTo(self.headerImgBg).offset(- 10 * kScale);
        make.width.mas_equalTo(22 * kScale);
        make.height.mas_equalTo(22 * kScale);
    }];
    
    // Setup the bar
    self.myCustomBar = [[SquareCashStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, _nMainViewWidth, 180 * kScale)];
    self.myCustomBar.delegate = self;
    __weak AccountViewController *weakSelf = self;
    __block UIImage *tempImage;
    self.myCustomBar.sendImgBlock = ^(UIImage *image,BOOL isClear) {
        
        if (isClear) {
            weakSelf.headerImgBg.image = image;
        }else {
            tempImage = [image applyBlurWithRadius:8 tintColor:[UIColor colorWithWhite:0 alpha:0.3] saturationDeltaFactor:1.8 maskImage:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.headerImgBg.image = tempImage;
                [UserInfoInstance sharedUserInfoInstance].lastIcon = [UserInfoInstance sharedUserInfoInstance].userInfoModel.origin;
            });
        }
    };
    
    SquareCashStyleBehaviorDefiner *behaviorDefiner = [[SquareCashStyleBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.elasticMaximumHeightAtTop = YES;
    self.myCustomBar.behaviorDefiner = behaviorDefiner;
    
    // Configure a separate UITableViewDelegate and UIScrollViewDelegate (optional)
    self.delegateSplitter = [[BLKDelegateSplitter alloc] initWithFirstDelegate:behaviorDefiner secondDelegate:self];
    _tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
    
    [self.tableHeaderView addSubview:self.myCustomBar];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)];
    tap.delegate = self;
    [self.myCustomBar addGestureRecognizer:tap];
    [_navBar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)]];
    
    _userInfoTopView = [[UserInfoTopView alloc] init];
    [self.tableHeaderView addSubview:_userInfoTopView];
    _userInfoTopView.delegate = self;
    [_userInfoTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImgBg.mas_bottom);
        make.left.right.equalTo(self.tableHeaderView);
        make.height.equalTo(@(413.5 * kScale));//
    }];

    [self.tableHeaderView addSubview:self.headerBottomView];
    [self.headerBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userInfoTopView.mas_bottom).offset(0 * kScale);
        make.left.right.equalTo(self.tableHeaderView);
        make.bottom.equalTo(self.tableHeaderView);
    }];
    
    _tableView.backgroundColor = REFRESH_BG_COLOR;
    _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//------------------------------------------------------------------------
    
    [self.view bringSubviewToFront:_navBar];
    _navBar.backgroundColor = [UIColor clearColor];
    
    _getUserInfoAPI = [[GetUserInfoAPI alloc] init];
    _getUserInfoAPI.delegate = self;
    _getUserInfoAPI.ignoreCache = YES;
    
    _getUserDynamicAPI = [[GetUserDynamicAPI alloc] initWithPage:@"0" count:@"10"];
    
    [self loadData];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onHoldingSheetMsg:) name:HOLDING_SHEET_MSG object:nil];
    
    [center addObserver:self selector:@selector(popBigV) name:@"POPBigV" object:nil];
}

- (void)setHasUnRead:(BOOL)hasUnRead {
    
    _hasUnRead = hasUnRead;
    
    if (_hasUnRead) {
        [self setLeftBtnImg:[UIImage imageNamed:@"ic_weidumail_nor1"]];
    }else {
        [self setLeftBtnImg:[UIImage imageNamed:@"ic_mail_nor-1"]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear:我的");
    
    [super viewWillAppear:animated];
    
    UserInfoModel *model = [UserInfoInstance sharedUserInfoInstance].userInfoModel;
    
    if(model) {
        [self.myCustomBar setUserName:model.n gradeName:model.lt headImgUrl:model.origin score:model.sc isBigV:model.aty.integerValue == 3 || model.aty.integerValue == 4];
        [_userInfoTopView setFollowNum:model.fl fs:model.fs feeds:model.fds coms:model.cs collections:model.fv secret:model.ams tsc:model.tsc isBigV:model.aty.integerValue == 3 || model.aty.integerValue == 4];
    } else {
        [self.myCustomBar setUserName:@"登录 | 注册" gradeName:@"暂无等级" headImgUrl:nil score:model.sc isBigV:model.aty.integerValue == 3 || model.aty.integerValue == 4];
        [_userInfoTopView setFollowNum:model.fl fs:model.fs feeds:model.fds coms:model.cs collections:model.fv secret:model.ams tsc:model.tsc isBigV:NO];
    }
    
    //未读消息 改变 navbar 状态
    self.hasUnRead = [[MessageInstance sharedMessageInstance] hasUnReadMsg];
    [self changeNavBarModeWithStatusBarMode:self.isDefult];
    
    //是否登录
    
    if ([SystemUtil isSignIn]) {
        self.tableView.mj_footer.hidden = NO;
        _tableView.scrollEnabled = YES;
    }else {
        self.tableView.mj_footer.hidden = YES;
        _tableView.scrollEnabled = NO;
    }
    
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"viewWillDisappear:我的");
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - loadData
- (void)loadData {
    if ([SystemUtil isSignIn]) {
        NSString *userId = [SystemUtil getCache:USER_ID];
        _getUserInfoAPI.userId = userId;
        [_getUserInfoAPI start];
        
        self.isFirstTimeLoad = YES;
        _getUserDynamicAPI.page = @"0";
        [self loadNewData];
    }else {
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
    }
    
}

- (void)loadNewData {

    _getUserDynamicAPI.page = [NSString stringWithFormat:@"%zd",_getUserDynamicAPI.page.integerValue + 1];
    [_getUserDynamicAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
//        NSLog(@"%@",request.responseJSONObject);
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[UserDynamicModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
        
        if (self.isFirstTimeLoad) {
            [self.dataArray removeAllObjects];
            self.isFirstTimeLoad = NO;
        }
        [self.dataArray addObjectsFromArray:modelArray];
        [self.tableView reloadData];
        
        if (modelArray.count >= 10) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.requestOperationError);
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)analysisData:(NSDictionary *)json {
    UserInfoModel *model = [MTLJSONAdapter modelOfClass:[UserInfoModel class] fromJSONDictionary:json error:nil];
    [UserInfoInstance sharedUserInfoInstance].userInfoModel = model;
    
    [self.myCustomBar setUserName:model.n gradeName:model.lt headImgUrl:model.origin score:model.sc isBigV:model.aty.integerValue == 3 || model.aty.integerValue == 4];
    [_userInfoTopView setFollowNum:model.fl fs:model.fs feeds:model.fds coms:model.cs collections:model.fv secret:model.ams tsc:model.tsc isBigV:model.aty.integerValue == 3 || model.aty.integerValue == 4];
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
    if (request.responseJSONObject) {
        [self analysisData:request.responseJSONObject];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
    NSLog(@"%zd %@",request.responseStatusCode,request.requestOperationError);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == _tableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > 85) {
            float fAlpha = (1 - (offsetY - 85) / 100);
            self.headerImgBg.alpha = fAlpha;
        }
        if (offsetY < 50) {
            self.headerImgBg.alpha = 1.0;
        }
        if (offsetY < 0) {
            [self.headerImgBg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view);
                make.left.right.equalTo(self.view);
                make.height.mas_equalTo(180 * kScale - offsetY);
            }];
        } else {
            [self.headerImgBg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.tableHeaderView);
                make.height.equalTo(@(180 * kScale));
            }];
        }
        
        [self changeNavBarModeWithStatusBarMode:(self.headerImgBg.alpha > 0.2) ? NO : YES];
    }
}

#pragma mark -
#pragma mark Actions

- (void)loginBtnAction:(id)sender {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:loginViewController animated:YES];
}

- (void)userInfoTopViewDelegateClick:(NSInteger)tag {
    
    NSLog(@"%zd",tag);
    
    if (tag == 7) {
        [self shareToFriend];
        return;
    } else if (tag == 8) {
        SuggestViewController *suggestVC = [[SuggestViewController alloc] init];
        [self.navigationController pushViewController:suggestVC animated:YES];
        return;
    } else if (tag == 6) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1160573329"]];
        return;
    }
    
    if (![SystemUtil isSignIn]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    } else {
        WebViewController *webVC = [[WebViewController alloc] init];
        if (tag == 1) {
            FollowAndFansController *ffvc = [FollowAndFansController new];
            ffvc.view.backgroundColor = [UIColor whiteColor];
            ffvc.segmentedControl.selectedSegmentIndex = 0;
            [self.navigationController pushViewController:ffvc animated:YES];
        } else if (tag == 2){
            FollowAndFansController *ffvc = [FollowAndFansController new];
            ffvc.view.backgroundColor = [UIColor whiteColor];
            ffvc.segmentedControl.selectedSegmentIndex = 1;
            [self.navigationController pushViewController:ffvc animated:YES];
        } else if (tag == 3){
            NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_ACCOUNT_MY_FEED];
            webVC.myUrl = url;
            [self.navigationController pushViewController:webVC animated:YES];
        } else if (tag == 4){
            NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_ACCOUNT_MY_COMMONED];
            webVC.myUrl = url;
            [self.navigationController pushViewController:webVC animated:YES];
        } else if (tag == 5){
            NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_ACCOUNT_MY_COLLECTION];
            webVC.myUrl = url;
            [self.navigationController pushViewController:webVC animated:YES];
        } else if (tag == 9){
            NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_ACCOUNT_MY_SECRET];
            webVC.myUrl = url;
            [self.navigationController pushViewController:webVC animated:YES];
        } else if (tag == 10) {
            NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_AC0001];
            NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            WebViewController *vc = [WebViewController new];
            vc.type = WEB_VIEW_TYPE_NOR;
            vc.myUrl = urlStr;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (tag == 11) {
            ScoreTaskViewController *vc = [ScoreTaskViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (tag == 12) {
            AuthorViewController *vc = [AuthorViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

- (void)onHoldingSheetMsg:(NSNotification *)notify {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"录入持仓", @"编辑持仓",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)popBigV {
    if ([SystemUtil isSignIn]) {
        [self.popView showInView:self.navigationController.view fromPoint:CGPointMake(375 * 0.5 * kScale, 667 * 0.5 * kScale) centerAtPoint:CGPointMake(375 * 0.5 * kScale, 667 * 0.5 * kScale) completion:nil];
        _popView.userInteractionEnabled = YES;
    } else {
        LoginViewController *vc = [LoginViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)  {
        RecordHoldingController *viewController = [[RecordHoldingController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    } else if (buttonIndex == 1) {
        NSString *userId = [SystemUtil getCache:USER_ID];
        NSDictionary *param = @{@"id":userId};
        EditHoldingController *viewController = [[EditHoldingController alloc] init];
        NSString *url = [MarketConfig getUrlWithPath:H5_ACCOUNT_MY0201 Param:param];
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.myUrl = urlStr;
        viewController.mytitle = @"编辑持仓";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [_deleteDynamicAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
            NSLog(@"%@",request.responseJSONObject);
            if (_deleteDynamicAPI.cellIndex < self.dataArray.count) {
                [self.dataArray removeObjectAtIndex:_deleteDynamicAPI.cellIndex];
                [self.tableView reloadData];
            }
        } failure:^(__kindof APIBaseRequest *request) {
            NSLog(@"删除失败");
        }];
    }
}

- (void)headerClick:(UITapGestureRecognizer *)gestureRecognizer {
    if ([SystemUtil isSignIn])
    {
        PersonalCenterViewController *viewController = [[PersonalCenterViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
    
}

- (void)SquareCashStyleBarScoreLableClicked:(SquareCashStyleBar *)squareCashStyleBar {
    if ([SystemUtil isSignIn]) {
        ScoreTaskViewController *vc = [ScoreTaskViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LoginViewController *vc = [LoginViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)BigVPopViewDelegate:(BigVPopView *)popView andBtnClick:(UIButton *)btn {
    _popView.userInteractionEnabled = NO;
    AuthorViewController *vc = [AuthorViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - search
- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    SettingViewController *viewController = [[SettingViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

- (void)navBar:(NavBar *)navBar leftButtonTapped:(UIButton *)sender {
    MessageViewController *viewController = [[MessageViewController alloc] init];
    viewController.title = @"消息";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

- (void)changeNavBarModeWithStatusBarMode:(BOOL)isDefault {
    
    if (!isDefault) {
        if (_hasUnRead) {
            [self setLeftBtnImg:[UIImage imageNamed:@"ic_weidumail_nor1"]];
        }else {
            [self setLeftBtnImg:[UIImage imageNamed:@"ic_mail_nor-1"]];
        }
        [_navBar setRightBtnImg:[UIImage imageNamed:@"setting_icon"]];
        [_navBar setTitle:@""];
        _navBar.line_view.hidden = YES;
        _navBar.backgroundColor = [UIColor clearColor];
        _isDefult = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        if (_hasUnRead) {
            [self setLeftBtnImg:[UIImage imageNamed:@"ic_weidumail_nor"]];
        }else {
            [self setLeftBtnImg:[UIImage imageNamed:@"ic_mail_nor"]];
        }
        [_navBar setRightBtnImg:[UIImage imageNamed:@"ic_shezhi_nor"]];
        [_navBar setTitle:@"我的"];
        _navBar.line_view.hidden = NO;
        _navBar.backgroundColor = [UIColor whiteColor];
        _isDefult = YES;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

#pragma mark -tableView

- (void)userDynamicCellDelegateClick:(NSInteger)index ids:(NSString *)ids index:(NSInteger)cellIndex{
    
    if (index == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除这条动态吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
        _deleteDynamicAPI = [[DeleteUserDynamicAPI alloc] initWithid:ids];
        _deleteDynamicAPI.cellIndex = cellIndex;
        
    }else if (index == 2){
        NSString *urlStr = [NSString stringWithFormat:@"%@jiabei/MY9902?id=%@",API_URL,ids];
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.type = WEB_VIEW_TYPE_PERSONAL;
        webVC.myUrl = urlStr;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserDynamicModel *model = self.dataArray[indexPath.row];
    if ([model.ty isEqualToString:@"O_COMMENT"]) {
        return 145;
    }else {
        return 106;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArray.count == 0) {
        self.headerBottomView.hasList = NO;
    } else {
        self.headerBottomView.hasList = YES;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UserDynamicModel *model = self.dataArray[indexPath.row];
    
    UserDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.index = indexPath.row;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UserDynamicModel *model = self.dataArray[indexPath.row];
    UserDynamicList *listModel = model.listArray[0];
    if (listModel.url.length) {
        [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:listModel.url];
    }else{
        NSLog(@"null %@",listModel.url);
    }
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

@end
