//
//  MomentSecretViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/3/23.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentSecretViewController.h"
#import "FeedChildListViewController.h"
#import "MomentSecretTableViewCell.h"
#import "NewMomentViewController.h"
#import "DetailWebViewController.h"
#import "TalkNoticeViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "PostSecretViewController.h"
#import "AppDelegate.h"
#import "PYPhotoBrowser.h"
#import "NSString+getLength.h"
#import "MarketConfig.h"
#import <UIImageView+WebCache.h>
#import "IndexInfoModel.h"
#import "SharedInstance.h"

#import "RecommendListAPI.h"
#import "MomentListAPI.h"
#import "FeedListModel.h"
#import "FeedLikeAPI.h"

#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"

static NSString *cellid = @"MomentFeedSecretListCell";

@interface MomentSecretViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate,MomentSecretTableViewCellDelegate>

@property (nonatomic, strong) MomentSecretTableViewCell *cell;

@property (nonatomic, assign) BOOL isfirstLoad;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MomentListAPI *listAPI;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *topNoticeView;

@property (nonatomic, strong) UIButton *topNoticeBtn;

@end

@implementation MomentSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    self.title = @"匿名说";
    
    _navBar.hidden = YES;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topNoticeView];
    [self.topNoticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0 * kScale);
        make.height.equalTo(@(0));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topNoticeView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
 
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
}

#pragma mark - loadData
- (void)loadData {

    if (self.tableView.mj_header.isRefreshing) {
        return;
    }
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadMoreData {
    self.listAPI.page = [NSString stringWithFormat:@"%zd",_listAPI.page.integerValue + 1];
    [_listAPI start];
}

- (void)loadNewData {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    WXTabBarController *tabbarVC = appDelegate.tabBarController;
    NewMomentViewController *newVC = (NewMomentViewController *)tabbarVC.backingViewControllers[3];
    [newVC getUnreadNum];
    
    self.isfirstLoad = YES;
    
    self.listAPI.page = @"1";
    
    [self.listAPI start];
}

#pragma mark aciton

- (void)topNoticeBtnClick:(UIButton *)btn {
    NSLog(@"dsada");
    TalkNoticeViewController *vc = [TalkNoticeViewController new];
    vc.res_code = @"S_DISCLOSE";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
}

- (void)setUnreadCount:(NSInteger)unreadCount {
    _unreadCount = unreadCount;
    if (_unreadCount == 0) {
        [self.topNoticeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        _topNoticeBtn.hidden = YES;
    } else {
        [self.topNoticeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(80 * kScale));
        }];
        _topNoticeBtn.hidden = NO;
        [self.topNoticeBtn setTitle:[NSString stringWithFormat:@"%zd条匿名通知 >>",unreadCount] forState:UIControlStateNormal];
    }
    [self.view layoutIfNeeded];
}

- (void)pushToStock:(FeedListSLModel *)item {
    if (!(item.t && item.s.length && item.m && item.n.length)) {
        return;
    }
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (([item.t intValue] == 1) || ([item.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.indexModel = model;
        [delegate.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.stockListModel = model;
        [delegate.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)momentSecretTableViewCellTopicDelegate:(NSInteger)index andModel:(FeedListModel *)model {
    if (index == 1) {
        PostSecretViewController *vc = [PostSecretViewController new];
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.tt = model.tt;
        vc.pid = model.ids;
        [appdelegate.navigationController presentViewController:nav animated:YES completion:nil];
    } else if (index == 2) {
        [SharedInstance sharedSharedInstance].image = [UIImage imageNamed:@"shareLogo"];
        [SharedInstance sharedSharedInstance].tt = @"一起来说说";
        [SharedInstance sharedSharedInstance].c = model.tt;
        [SharedInstance sharedSharedInstance].url = model.url;
        [SharedInstance sharedSharedInstance].res_code = @"S_DISCLOSE";
        [SharedInstance sharedSharedInstance].sid = model.ids;
        [[SharedInstance sharedSharedInstance] shareWithImage:NO];
    }
}

#pragma mark request

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    NSArray *array = [_listAPI.responseJSONObject objectForKey:@"list"];
    NSInteger count = [[_listAPI.responseJSONObject objectForKey:@"count"] intValue];
    
    //解析出其他需要的数据
    
    NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[FeedListModel class] fromJSONArray:array error:nil];
    if (self.isfirstLoad) {
        self.dataArray = [NSMutableArray arrayWithArray:modelArray];
        self.isfirstLoad = NO;
    }else {
        [self.dataArray addObjectsFromArray:modelArray];
    }
    [_tableView reloadData];
    
    if (count >= 10) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } else {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {
    [super requestFailed:request];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

#pragma mark 3d touch delegate

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell *)previewingContext.sourceView];
    FeedListModel *model = self.dataArray[indexPath.row];
    DetailWebViewController *viewController = [[DetailWebViewController alloc] init];
    viewController.type = WEB_VIEW_TYPE_COMMENT;
    NSString *url = [MarketConfig getUrlWithPath:model.url];
    if (url.length == 0) {
        return nil;
    }
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    viewController.myUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    return viewController;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.navigationController pushViewController:viewControllerToCommit animated:YES];
}

#pragma UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedListModel *model = self.dataArray[indexPath.row];
    if (model.height != 0) {
        return model.height;
    }
    CGFloat h = [self.cell getRowHeight:model];
    model.height = h;
    return h;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedListModel *model = self.dataArray[indexPath.row];

    MomentSecretTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    
    cell.model = model;
    cell.delegate = self;
    cell.photoBlock = ^(UIImageView *image,CGRect rect){
        PYPhotoBrowseView *photoBrowseView = [[PYPhotoBrowseView alloc] init];
        photoBrowseView.sourceImgageViews = @[image];
        [photoBrowseView show];
    };
    
    cell.pushStock = ^(FeedListSLModel *model){
        [self pushToStock:model];
    };
    
    [self registerForPreviewingWithDelegate:self sourceView:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == 0) {
        return;
    } 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    FeedListModel *model = self.dataArray[indexPath.row];
    if (model.ty.integerValue == 2) {
        FeedChildListViewController *vc = [FeedChildListViewController new];
        vc.tt = model.tt;
        vc.pid = model.ids;
        vc.model = model;
        if (model.ids == nil) {
            NSLog(@"no pid");
            return;
        }
        [appDelegate.navigationController pushViewController:vc animated:YES];
        return;
    }
    DetailWebViewController *viewController = [[DetailWebViewController alloc] init];
    viewController.type = WEB_VIEW_TYPE_COMMENT;
    NSString *url = [MarketConfig getUrlWithPath:model.url];
    if (url.length == 0) {
        return;
    }
    viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //@"http://192.168.8.21:9001/MY0405.html";
    //@"http://192.168.8.21:9001/FM0401.html";
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma mark lazy

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MomentSecretTableViewCell class] forCellReuseIdentifier:cellid];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _tableView;
}

- (MomentListAPI *)listAPI {
    if (_listAPI == nil) {
        _listAPI = [[MomentListAPI alloc] initWithCount:@"10" res_code:@"S_DISCLOSE" page:@"1" order:@"1"fromNum:1 toNum:PAGE_COUNT];
        _listAPI.delegate = self;
    }
    return _listAPI;
}

- (MomentSecretTableViewCell *)cell {
    if (_cell == nil) {
        _cell = [MomentSecretTableViewCell new];
    }
    return _cell;
}

- (UIView *)topNoticeView {
    if (_topNoticeView == nil) {
        _topNoticeView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, 80 * kScale)];
        _topNoticeView.backgroundColor = [UIColor whiteColor];
        [_topNoticeView addSubview:self.topNoticeBtn];
        [_topNoticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topNoticeView).offset(15 * kScale);
            make.centerX.equalTo(_topNoticeView);
            make.width.equalTo(@(140 * kScale));
            make.height.equalTo(@(36 * kScale));
        }];
    }
    return _topNoticeView;
}

- (UIButton *)topNoticeBtn {
    if (_topNoticeBtn == nil) {
        _topNoticeBtn = [[UIButton alloc] init];
        [_topNoticeBtn setTitleColor:kNameColor forState:UIControlStateNormal];
        [_topNoticeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
        [_topNoticeBtn.titleLabel setFont:[UIFont systemFontOfSize:12 * kScale]];
        _topNoticeBtn.layer.cornerRadius = 18 * kScale;
        _topNoticeBtn.layer.masksToBounds = YES;
        _topNoticeBtn.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
        _topNoticeBtn.layer.borderWidth = 0.5 * kScale;
        _topNoticeBtn.adjustsImageWhenHighlighted = NO;
        [_topNoticeBtn addTarget:self action:@selector(topNoticeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *ic = [[UIImageView alloc] init];
        [ic sd_setImageWithURL:[NSURL URLWithString:API_MOMENT_NOTICE_ICON]];
        ic.layer.cornerRadius = 12 * kScale;
        ic.layer.masksToBounds = YES;
        [_topNoticeBtn addSubview:ic];
        [ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_topNoticeBtn);
            make.left.equalTo(_topNoticeBtn).offset(10 * kScale);
            make.height.width.equalTo(@(24 * kScale));
        }];
        _topNoticeBtn.hidden = YES;
    }
    return _topNoticeBtn;
}

@end
