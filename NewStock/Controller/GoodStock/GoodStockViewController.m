//
//  GoodStockViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/13.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MJChiBaoZiHeader.h"
#import <Masonry.h>
#import "MJRefresh.h"

#import "GoodStockViewController.h"
#import "RedRootViewController.h"
#import "TigerSearchViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "TaoSearchStockViewController.h"
#import "LoginViewController.h"
#import "TaoSearchPeopleViewController.h"
#import "ZhuangGuViewController.h"
#import "TaoPPlViewController.h"
#import "WebViewController.h"
#import "YouZiViewController.h"
#import "TaoTuiJianViewController.h"
#import "TaoSkillStockViewController.h"
#import "TaoDeepTigerViewController.h"
#import "TaoZhuLiStockListViewController.h"
#import "TaoCXZYViewController.h"
#import "TaoNewStockPoolViewController.h"
#import "TaoLimitAnalysisViewController.h"
#import "TaoContinueLimitCatchViewController.h"
#import "QLNGViewController.h"

#import "TaoIndexAPI.h"
#import "TaoIndexModel.h"
#import "TaoHotPeopleModel.h"

#import "MarketConfig.h"
#import "NativeUrlRedirectAction.h"
#import "TaoNoticeStartMessage.h"

#import "GoodStockIndexDataCenterView.h"
#import "TaoIndexSmartView.h"
#import "TaoIndexSkillBottomView.h"
#import "TaoSkillStockView.h"

@interface GoodStockViewController () <GoodStockIndexDataCenterViewDelegate,TaoIndexSmartViewDelegate,TaoSkillStockViewDelegate,TaoIndexSkillBottomViewDelegate>

@property (nonatomic, strong) TaoIndexAPI *indexAPI;
@property (nonatomic, strong) TaoNoticeStartMessage *mesageAPI;
@property (nonatomic, strong) TaoIndexModel *model;

@property (nonatomic, strong) GoodStockIndexDataCenterView *dataCenterView;
@property (nonatomic, strong) TaoIndexSmartView *smartStockView;
@property (nonatomic, strong) TaoSkillStockView *skillStockView;
@property (nonatomic, strong) TaoIndexSkillBottomView *skillBottomView;

@end

@implementation GoodStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setLeftBtnImg:nil];
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:@"淘牛股" attributes:@{
                NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    _navBar.backgroundColor = kTitleColor;
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    [_mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(@(650 * kScale));
    }];
    [_scrollView layoutIfNeeded];
    
    _scrollView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self setupUI];
    
    [self.view bringSubviewToFront:_navBar];
    _scrollView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
}

- (void)setupUI {
    
    [_mainView addSubview:self.dataCenterView];
    [_mainView addSubview:self.smartStockView];
    [_mainView addSubview:self.skillStockView];
    [_mainView addSubview:self.skillBottomView];
    
    [self.dataCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_mainView);
        make.height.equalTo(@(190 * kScale));
    }];
    
    [self.smartStockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_mainView);
        make.top.equalTo(_dataCenterView.mas_bottom).offset(10 * kScale);
        make.height.equalTo(@(130 * kScale));
    }];
    
    [self.skillStockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_mainView);
        make.top.equalTo(self.smartStockView.mas_bottom).offset(10 * kScale);
        make.height.equalTo(@(154 * kScale));
    }];
    
    [self.skillBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_mainView);
        make.top.equalTo(self.skillStockView.mas_bottom).offset(10 * kScale);
        make.height.equalTo(@(300 * kScale));
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark loadData 

- (void)loadData {
    [_scrollView.mj_header beginRefreshing];
}

- (void)loadNewData {
    [self.indexAPI start];
    [self.mesageAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSArray class]]) {
            NSString *msg = [request.responseJSONObject[0] objectForKey:@"msg"];
            if ([msg isEqualToString:@""]) {
                return ;
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }];
        }
    } failure:nil];
}

#pragma mark request

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"index failed");
    [_scrollView.mj_header endRefreshing];
}

- (void)requestFinished:(APIBaseRequest *)request {
    [_scrollView.mj_header endRefreshing];
    
    TaoIndexModel *model = [MTLJSONAdapter modelOfClass:[TaoIndexModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    self.model = model;
    
    self.dataCenterView.dataArray = model.centerData.list;
    self.dataCenterView.title = model.centerData.title;
    
    self.smartStockView.dataArray = model.smartStock.list;
    self.smartStockView.title = model.smartStock.title;
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:model.skillStock.list];
    if (arr.count >= 6) {
        self.skillStockView.dataArray = [arr subarrayWithRange:NSMakeRange(0, 6)];
        self.skillBottomView.dataArray = [arr subarrayWithRange:NSMakeRange(6, arr.count - 6)];
    } else {
        self.skillStockView.dataArray = model.skillStock.list;
    }
    
    self.skillStockView.title = model.skillStock.title;
    
    [self dealWithHeight];
}

- (void)dealWithHeight {
    NSInteger dataCenterCount = (_model.centerData.list.count - 1) / 4 + 1;
    CGFloat dataCenterHeight = dataCenterCount * 80 * kScale + 30 * kScale;
    
    [self.dataCenterView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(dataCenterHeight));
    }];
    
    CGFloat bottomHeight = CGRectGetMaxY(self.skillBottomView.subviews.lastObject.frame) + 12;
    [_skillBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(bottomHeight + 12 * kScale));
    }];
    
    [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(dataCenterHeight + 10 * kScale * 3 + 130 * kScale + 154 * kScale + bottomHeight));
    }];
    
    [self.view layoutIfNeeded];
}

#pragma mark action

- (void)goodStockIndexDataCenterViewDelegatePush:(NSString *)url {
    NSLog(@"------%@",url);
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
}

- (void)taoIndexSmartViewDelegatePushTo:(NSString *)url title:(NSString *)title {
    NSLog(@"%@",url);
    QLNGViewController *vc = [QLNGViewController new];
    vc.ids = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)taoSkillStockViewDelegatePushTo:(NSString *)url title:(NSString *)title {
    TaoSkillStockViewController *vc = [TaoSkillStockViewController new];
    vc.ids = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)taoIndexSkillBottomViewDelegatePushTo:(NSString *)url title:(NSString *)title {
    TaoSkillStockViewController *vc = [TaoSkillStockViewController new];
    vc.ids = url;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushTo:(TaoIndexModelClildStock *)model {
    TaoIndexModelClildStock *item = model;
    
    if (!(item.t && item.s && item.m && item.n)) {
        return;
    }
    
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    vc.t = item.t;
    vc.s = item.s;
    vc.m = item.m;
    vc.n = item.n;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - search



#pragma mark    ----------  lazy loading  ------

- (TaoIndexAPI *)indexAPI {
    if (_indexAPI == nil) {
        _indexAPI = [[TaoIndexAPI alloc] init];
        _indexAPI.delegate = self;
    }
    return _indexAPI;
}

- (TaoNoticeStartMessage *)mesageAPI {
    if (_mesageAPI == nil) {
        _mesageAPI = [TaoNoticeStartMessage new];
    }
    return _mesageAPI;
}

- (GoodStockIndexDataCenterView *)dataCenterView {
    if (_dataCenterView == nil) {
        _dataCenterView = [GoodStockIndexDataCenterView new];
        _dataCenterView.delegate = self;
    }
    return _dataCenterView;
}

- (TaoIndexSmartView *)smartStockView {
    if (_smartStockView == nil) {
        _smartStockView = [TaoIndexSmartView new];
        _smartStockView.delegate = self;
    }
    return _smartStockView;
}

- (TaoSkillStockView *)skillStockView {
    if (_skillStockView == nil) {
        _skillStockView = [TaoSkillStockView new];
        _skillStockView.delegate = self;
    }
    return _skillStockView;
}

- (TaoIndexSkillBottomView *)skillBottomView {
    if (_skillBottomView == nil) {
        _skillBottomView = [TaoIndexSkillBottomView new];
        _skillBottomView.delegate = self;
    }
    return _skillBottomView;
}

@end
