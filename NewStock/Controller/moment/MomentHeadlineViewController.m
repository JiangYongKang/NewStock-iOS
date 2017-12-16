//
//  MomentHeadlineViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/5/11.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MomentHeadlineViewController.h"
#import "MomentHeadLineTableViewCell.h"
#import "WebViewController.h"
#import "MarketConfig.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "MomentListAPI.h"
#import "AdListAPI.h"
#import "FeedListModel.h"
#import "NativeUrlRedirectAction.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "FeedListModel.h"
#import "AdListItemModel.h"
#import "MomentHeadLineAdView.h"
#import "Defination.h"
#import <Masonry.h>

static NSString *cellID = @"MomentHeadlineViewControllerCell";
static NSString *adCellID = @"MomentHeadlineViewControllerADCell";

@interface MomentHeadlineViewController ()<UITableViewDelegate,UITableViewDataSource,MomentHeadLineAdViewDelegate,MomentHeadLineTableViewCellPhotoDelegate,UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MomentListAPI *listAPI;
@property (nonatomic, strong) AdListAPI *adListAPI;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *adListArray;
@property (nonatomic, strong) MomentHeadLineAdView *headerView;

@end

@implementation MomentHeadlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    _navBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.title = @"头条";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.headerView addTimerScroll];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.headerView deleteTimer];
}

#pragma mark loaddata

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
    
    self.listAPI.page = @"1";
    
    [self.listAPI start];
    
    [self.adListAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        self.adListArray = [MTLJSONAdapter modelsOfClass:[AdListItemModel class] fromJSONArray:request.responseJSONObject[@"list"] error:nil];
        self.headerView.dataArray = self.adListArray;
    } failure:^(__kindof APIBaseRequest *request) {
        
    }];
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
    
    NSArray *array = [MTLJSONAdapter modelsOfClass:[FeedListModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
    
    if ([[request valueForKey:@"page"] isEqualToString:@"1"]) {
        self.dataArray = [NSMutableArray arrayWithArray:array];
        [_tableView.mj_header endRefreshing];
    } else {
        [self.dataArray addObjectsFromArray:array];
    }
    
    [self.tableView reloadData];
    NSString *count = (NSString *)[request valueForKey:@"count"];
    if (array.count < count.integerValue) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [_tableView.mj_footer endRefreshing];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
    [self.tableView.mj_header endRefreshing];
}

#pragma mark action

- (void)momentHeadLineAdViewClick:(NSString *)url {
    NSLog(@"--%@",url);
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
}

- (void)MomentHeadLineTableViewCellPhotoDelegate:(NSArray *)array andIndex:(NSInteger)index {
    PYPhotoBrowseView *photoBrowseView = [[PYPhotoBrowseView alloc] init];
    photoBrowseView.sourceImgageViews = array;
    photoBrowseView.currentIndex = index;
    [photoBrowseView show];
}

- (void)scrollToTop {
    [_tableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark 3d touch delegate

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell *)previewingContext.sourceView];
    FeedListModel *model = self.dataArray[indexPath.row];
    WebViewController *viewController = [[WebViewController alloc] init];
    viewController.type = WEB_VIEW_TYPE_SHARE;
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

#pragma mark tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedListModel *model = self.dataArray[indexPath.row];
    if (model.imgs.count >= 3) {
        return 150 * kScale;
    } else if (model.imgs.count) {
        return 100 * kScale;
    } else {
        NSString *s = model.tt;
        CGFloat w = [s boundingRectWithSize:CGSizeMake(MAXFLOAT, [UIFont systemFontOfSize:17 * kScale].lineHeight) options:1 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17 * kScale]} context:nil].size.width;
        if (w > MAIN_SCREEN_WIDTH - 24 * kScale) {
            return 100 * kScale;
        } else {
            return 75 * kScale;
        }
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MomentHeadLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    FeedListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9) {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == 0) {
        return;
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FeedListModel *model = self.dataArray[indexPath.row];

    WebViewController *viewController = [[WebViewController alloc] init];
    viewController.type = WEB_VIEW_TYPE_SHARE;
    NSString *url = [MarketConfig getUrlWithPath:model.url];
    if (url.length == 0) {
        NSLog(@"没有url");
        return;
    }
    viewController.myUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma mark lazyloading

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[MomentHeadLineTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _tableView;
}

- (MomentListAPI *)listAPI {
    if (_listAPI == nil) {
        _listAPI = [[MomentListAPI alloc] initWithCount:@"20" res_code:@"S_NEWS" page:@"1" order:@"1"fromNum:1 toNum:20];
        _listAPI.delegate = self;
    }
    return _listAPI;
}

- (AdListAPI *)adListAPI {
    if (_adListAPI == nil) {
        _adListAPI = [AdListAPI new];
    }
    return _adListAPI;
}

- (NSMutableArray <FeedListModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (MomentHeadLineAdView *)headerView {
    if (_headerView == nil) {
        _headerView = [[MomentHeadLineAdView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 180 * kScale)];;
        _headerView.delegate = self;
    }
    return _headerView;
}

@end
