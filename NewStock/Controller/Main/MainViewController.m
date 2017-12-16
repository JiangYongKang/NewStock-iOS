//
//  MainViewController.m
//  NewStock
//
//  Created by Willey on 16/7/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MainViewController.h"
#import "Mantle.h"
#import "SystemUtil.h"
#import "UIView+Masonry_Arrange.h"
#import "MarketConfig.h"
#import "UserInfoInstance.h"
#import "AppDelegate.h"
#import "StockHistoryUtil.h"
#import "NativeUrlRedirectAction.h"

#import "MainPageAPI.h"
#import "FeedLikeAPI.h"
#import "IndexInfoAPI.h"
#import "RecommendListAPI.h"
#import "MainTalkNewsAPI.h"

#import "MainPageModel.h"
#import "DrawLotsModel.h"
#import "IndexInfoModel.h"

#import "WebViewController.h"
#import "LoginViewController.h"
#import "IndexChartViewController.h"
#import "SearchViewController.h"
#import "MessageViewController.h"
#import "QingHuaiViewController.h"
#import "DetailWebViewController.h"
#import "TaoSearchPeopleViewController.h"
#import "FirstLoginViewController.h"
#import "NewStockCalenderViewController.h"
#import "StockChartViewController.h"
#import "HotThemeListViewController.h"

#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"

#import "MessageInstance.h"
#import "BaguaCell.h"
#import "DrawLotsPopView.h"
#import "TalkNewsView.h"
#import "MainStockApplyView.h"
#import "MainBtnBlockView.h"
#import "BaGuaView.h"
#import "MainThemeView.h"
#import "QingHuaiTopScrollView.h"
#import <AudioToolbox/AudioToolbox.h>


@interface MainViewController ()<DrawLotsPopViewDelegate,BaGuaViewDelegate,QingHuaiScrollViewDelegate,MainStockApplyViewDelegate,MainThemeViewDelegate>
{
    IndexInfoAPI *_indexInfoAPI;
    MainPageAPI *_mainPageAPI;
    FeedLikeAPI *_feedLikeAPI;
    RecommendListAPI *_baguaAPI;
    MainTalkNewsAPI *_talkNewsAPI;
    
    IndexInfoModel *_shIndexModel;
    IndexInfoModel *_szIndexModel;
    IndexInfoModel *_cybIndexModel;
    
    NSArray *_newsArr;
    NSMutableArray *_gossipArr;
    NSArray *_feelingArr;
    NSArray *_linksArr;
    
    DrawLotsPopView *_drawLotsPopView;
    QingHuaiTopScrollView *_qinhuaiView;
    TalkNewsView *_topicBg;
    MainBtnBlockView *_btnBlockView;
    MainThemeView *_mainThemeView;
    MainStockApplyView *_stockApplyView;
    
    //修改右上角 搜索按钮样式
    UIButton *_searchBtn;
    UIView *_singleLine;
    
    int padding1;
    int blockHeight;
    int blockWidth;
    int btnBlockHeight ;
    int topicHeight ;
    int stockApplyHeight;
    int themeHeight;
    int qinhuaiHeight;
    UIView *tableHeaderView;
}

@property (nonatomic, strong) UITableView *baguaTableView;
@property (nonatomic, copy) NSString *newsfuncUrl;
@property (nonatomic, copy) NSString *drawUrl;
@property (nonatomic, strong) NSMutableArray *dataArray1;

//@property (nonatomic, strong) UIView *introView;

@end

@implementation MainViewController

static NSString *baguaCellID = @"baguaCellID";

- (UITableView *)baguaTableView {
    if (_baguaTableView == nil) {
        _baguaTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _baguaTableView.delegate = self;
        _baguaTableView.dataSource = self;
        [_baguaTableView registerClass:[BaguaCell class] forCellReuseIdentifier:baguaCellID];
        _baguaTableView.separatorInset = UIEdgeInsetsMake(0, 10 * kScale, 0, 10 * kScale);
        _baguaTableView.separatorColor = kUIColorFromRGB(0xe4e4e4);
        _baguaTableView.backgroundColor = REFRESH_BG_COLOR;
    }
    return _baguaTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_navBar setRightBtnImg:[UIImage imageNamed:@"white_search_nor"]];
    [_navBar setLeftBtnImg:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _navBar.line_view.hidden = YES;
    
    self.title = @"发现";
    
    //修改 nav bar 右上角搜索按钮
    _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH - 40, 30, 30, 30)];
    [_searchBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_searchBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [_searchBtn setImage:[UIImage imageNamed:@"white_search_nor"] forState:UIControlStateNormal];
    [_navBar addSubview:_searchBtn];
    _searchBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
    _searchBtn.layer.cornerRadius = 15;
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.adjustsImageWhenHighlighted = NO;
    _searchBtn.alpha = 0;
    [_searchBtn addTarget:self action:@selector(navBar:rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _scrollView.backgroundColor = REFRESH_BG_COLOR;
    _scrollView.delegate = self;

    padding1 = 5 * kScale ;
    blockHeight = 64 * kScale;
    blockWidth = MAIN_SCREEN_WIDTH / 3;
    btnBlockHeight = 160 * kScale;
    topicHeight = 40 * kScale;
    themeHeight = 560 * kScale;
    stockApplyHeight = 40 * kScale;
    
    qinhuaiHeight = 150 * kScale ;
    
    __weak typeof(self)weakSelf = self;
    
    [self.view addSubview:self.baguaTableView];
    [self.baguaTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-49);
    }];

    tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, padding1 * 4 + blockHeight + topicHeight + qinhuaiHeight + btnBlockHeight + themeHeight + stockApplyHeight)];
    
    self.baguaTableView.tableHeaderView = tableHeaderView;
    
    //情怀界面
    _qinhuaiView = [[QingHuaiTopScrollView alloc] init];
    _qinhuaiView.delegate = self;
    
    [tableHeaderView addSubview:_qinhuaiView];
    [_qinhuaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableHeaderView).offset(0);
        make.left.equalTo(tableHeaderView).offset(0);
        make.right.equalTo(tableHeaderView).offset(0);
        make.height.mas_equalTo(qinhuaiHeight);
    }];
    
    //板块
    UIView *indexBg = [[UIView alloc] init];
    indexBg.backgroundColor = [UIColor whiteColor];
    [tableHeaderView addSubview:indexBg];
    [indexBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_qinhuaiView.mas_bottom).offset(padding1);
        make.right.equalTo(tableHeaderView);
        make.left.equalTo(tableHeaderView);
        make.height.mas_equalTo(blockHeight);
    }];
    
    _shIndex = [[IndexBlock alloc] initWithDelegate:self tag:0 type:IndexBlockTypeMainPage];
    _szIndex = [[IndexBlock alloc] initWithDelegate:self tag:1 type:IndexBlockTypeMainPage];
    _cybIndex = [[IndexBlock alloc] initWithDelegate:self tag:2 type:IndexBlockTypeMainPage];
    
    [indexBg addSubview:_shIndex];
    [indexBg addSubview:_szIndex];
    [indexBg addSubview:_cybIndex];

    [_shIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_szIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [_cybIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(blockWidth, blockHeight));
    }];
    [tableHeaderView distributeSpacingHorizontallyWith:@[_shIndex,_szIndex,_cybIndex]];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [indexBg addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(indexBg).offset(blockWidth);
        make.centerY.equalTo(indexBg);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(30);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [indexBg addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_szIndex.mas_right);
        make.centerY.width.height.equalTo(line1);
    }];
    
    _btnBlockView = [MainBtnBlockView new];
    [tableHeaderView addSubview:_btnBlockView];
    [_btnBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indexBg.mas_bottom).offset(padding1);
        make.left.right.equalTo(tableHeaderView);
        make.height.mas_equalTo(btnBlockHeight);
    }];
    
    _btnBlockView.pushBlock = ^(NSString *url) {
        if (url.length == 0) {
            [weakSelf popShakeView];
            return ;
        }
        [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
     };
    
    //快讯
    _topicBg = [[TalkNewsView alloc] init];
    [tableHeaderView addSubview:_topicBg];
    [_topicBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnBlockView.mas_bottom).offset(0);
        make.left.equalTo(tableHeaderView).offset(0);
        make.right.equalTo(tableHeaderView).offset(0);
        make.height.mas_equalTo(topicHeight);
    }];
    
    _topicBg.tapBlock = ^{
        [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:@"native://FM0500"];
    };
    
    //新股申购
    
    _stockApplyView = [MainStockApplyView new];
    _stockApplyView.delegate = self;
    [tableHeaderView addSubview:_stockApplyView];
    [_stockApplyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tableHeaderView);
        make.top.equalTo(_topicBg.mas_bottom).offset(padding1);
        make.height.equalTo(@(stockApplyHeight));
    }];
    
    
    //热门题材
    _mainThemeView = [MainThemeView new];
    _mainThemeView.delegate = self;
    [tableHeaderView addSubview:_mainThemeView];
    [_mainThemeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tableHeaderView);
        make.top.equalTo(_stockApplyView.mas_bottom).offset(padding1);
        make.height.equalTo(@(themeHeight));
    }];
    
    _newsArr = [[NSMutableArray alloc] init];
    
    //

    [tableHeaderView layoutIfNeeded];
    [_topicBg updateItemSize:_topicBg.bounds.size];
    //
    _indexInfoAPI = [[IndexInfoAPI alloc] initWithSymbolTyp:@"" symbol:@"" marketCd:@""];
    
    _baguaAPI = [[RecommendListAPI alloc] initWithCount:@"10" res_code:@"S_GOSSIP" page:@"0"];
    _baguaAPI.flag = @"1";
    
    _talkNewsAPI = [MainTalkNewsAPI new];
    
    _navBar.backgroundColor = kTitleColor;
    [self.view bringSubviewToFront:_navBar];
    
    self.baguaTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    [self loadData];

    // 设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
}

- (void)timerMethod:(NSTimer *)paramSender {
    [self loadIndexData];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear:发现");
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:_navBar.line_view.hidden ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault];

    [_qinhuaiView addTimerScroll];
    [_topicBg addTimerScroll];
    [_myTimer invalidate];
    float f = [MarketConfig getAppRefreshTime];
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:f
                                                target:self
                                              selector:@selector(timerMethod:) userInfo:nil
                                               repeats:YES];
    
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"viewWillDisappear:发现");

    [super viewWillDisappear:animated];
    [_scrollView.mj_header endRefreshing];
    [_qinhuaiView deleteTimer];
    [_topicBg deleteTimer];
    [_myTimer invalidate];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self resignFirstResponder];
}

- (void)loadNewData {
    //有缓存读缓存，没有缓存读工程
    if (!_mainPageAPI) {
        _mainPageAPI = [[MainPageAPI alloc] init];
        _mainPageAPI.delegate = self;
        
        if ([_mainPageAPI cacheJson]) {
            NSDictionary *json = [_mainPageAPI cacheJson];
            [self analysisData:json];
        }
    }
    
    _mainPageAPI.ignoreCache = YES;
    [_mainPageAPI start];
    
    [self loadIndexData];
}

- (void)loadIndexData {
    //
    [_indexInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        NSArray * array = [MTLJSONAdapter modelsOfClass:[IndexInfoModel class] fromJSONArray:_indexInfoAPI.responseJSONObject error:nil];
        for (int i = 0; i < [array count]; i++)  {
            IndexInfoModel *model = [array objectAtIndex:i];
            if([model.symbol isEqualToString:@"000001"]) {
                _shIndexModel = model;
                [_shIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            } else if([model.symbol isEqualToString:@"399006"]) {
                _cybIndexModel = model;
                [_cybIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            } else if([model.symbol isEqualToString:@"399001"]) {
                _szIndexModel = model;
                [_szIndex setCode:@"" title:model.symbolName value:[SystemUtil getPrecisionPrice:[model.consecutivePresentPrice doubleValue] precision:[model.pricePrecision intValue]] change:[NSString stringWithFormat:@"%.2f",[model.stockUD doubleValue]] changeRate:[SystemUtil getPercentage:[model.tradeIncrease doubleValue]]];
            }
        }
    } failure:nil];
    
    [_talkNewsAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        _newsArr = [MTLJSONAdapter modelsOfClass:[NewsModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
        _topicBg.dataArray = _newsArr;
    } failure:nil];
}

#pragma mark - loadData

- (void)loadData {
    [StockHistoryUtil getMyStockFromServer];
    
    [self.baguaTableView.mj_header beginRefreshing];

    [self loadIndexData];
}

- (void)analysisData:(NSDictionary *)json {
    
    //说闻解股
    _newsArr = [MTLJSONAdapter modelsOfClass:[NewsModel class] fromJSONArray:[[json objectForKey:@"news"] objectForKey:@"list"] error:nil];
    NSString *funcUrl = [[json objectForKey:@"news"] objectForKey:@"funcUrl"];
    if (funcUrl.length) {
        funcUrl = [funcUrl stringByReplacingOccurrencesOfString:@"./" withString:@""];
        self.newsfuncUrl = funcUrl;
    }
    _topicBg.dataArray = _newsArr;
    
    //申购新股
    NewStockModel *newStockM = [MTLJSONAdapter modelOfClass:[NewStockModel class] fromJSONDictionary:[json objectForKey:@"nstock"] error:nil];
    [_stockApplyView setApplyCount:newStockM.count.integerValue];
    _stockApplyView.btnStr = newStockM.funcTitle;
    _stockApplyView.url = newStockM.funcUrl;
    
    //题材
    NSArray *themeArr = [MTLJSONAdapter modelsOfClass:[MainThemeModel class] fromJSONArray:[[json objectForKey:@"theme"] objectForKey:@"list"] error:nil];
    _mainThemeView.dataArray = themeArr;
    [self updateThemeCons:themeArr];
    
    //抽签按钮 4
    NSArray *linkList = [[json objectForKey:@"link"] objectForKey:@"list"];
    _linksArr = [MTLJSONAdapter modelsOfClass:[LinksModel class] fromJSONArray:linkList error:nil];
    _btnBlockView.array = _linksArr;
    for (LinksModel *model in _linksArr) {
        if ([model.code isEqualToString:@"draw"]) {
            _drawUrl = model.url;
            break;
        }
    }
    
    //帖子
    NSArray *forumArray = [MTLJSONAdapter modelsOfClass:[ForumModel class] fromJSONArray:[[json objectForKey:@"forum"] objectForKey:@"list"] error:nil];
    self.dataArray1 = [NSMutableArray arrayWithArray:forumArray];
    [self.baguaTableView reloadData];
    //炒个情怀
    _feelingArr = [MTLJSONAdapter modelsOfClass:[ForumModel class] fromJSONArray:[[json objectForKey:@"feeling"] objectForKey:@"list"] error:nil];
    _qinhuaiView.dataArray = _feelingArr;
}

- (void)updateThemeCons:(NSArray *)array {
    CGFloat totalH = 0;
    for (MainThemeModel *model in array) {
        NSString *tt = model.tt;
        CGFloat w = [tt boundingRectWithSize:CGSizeMake(MAXFLOAT, [UIFont boldSystemFontOfSize:16 * kScale].lineHeight) options:1 attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16 * kScale]} context:nil].size.width;
        if (w > MAIN_SCREEN_WIDTH - 48 * kScale) {
            totalH += 163;
        } else {
            totalH += 137;
        }
    }
    
    themeHeight = 44 * kScale + totalH * kScale;
    
    tableHeaderView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, padding1 * 4 + blockHeight + topicHeight + qinhuaiHeight + btnBlockHeight + themeHeight + stockApplyHeight);
    [_mainThemeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(themeHeight));
    }];
    [self.view layoutIfNeeded];
}

- (void)requestFinished:(APIBaseRequest *)request {
    if (request == _mainPageAPI) {
        [self analysisData:_mainPageAPI.responseJSONObject];
    }
    [self.baguaTableView.mj_header endRefreshing];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [self.baguaTableView.mj_header endRefreshing];
}

#pragma mark themeView delegate

- (void)MainThemeViewClick:(NSString *)url {
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
}

- (void)MainThemeViewStockClick:(MainThemeStockModel *)model {
    MainThemeStockModel *item = model;
    if (!(item.t && item.s && item.m && item.n)) {
        return;
    }
    
    if (([item.t intValue] == 1) || ([item.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.indexModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = item.m;
        model.symbol = item.s;
        model.symbolName = item.n;
        model.symbolTyp = item.t;
        
        viewController.stockListModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)MainThemeViewMoreClick {
    HotThemeListViewController *vc = [HotThemeListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark mainStockApplyView delegate

- (void)mainStockApplyViewBtnClick:(NSString *)url {
    [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
}

#pragma IndexBlockDelegate
- (void)indexBlock:(IndexBlock*)indexBlock code:(NSString *)code {
    IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
    
    switch (indexBlock.tag) {
        case 0:
        {
            //viewController.title = @"上证指数";
            viewController.indexModel = _shIndexModel;
            break;
        }
        case 1:
        {
            //viewController.title = @"深证指数";
            viewController.indexModel = _szIndexModel;
            break;
        }
        case 2:
        {
            //viewController.title = @"创业板指";
            viewController.indexModel = _cybIndexModel;
            break;
        }
            
        default:
            break;
    }
    if (!viewController.indexModel) return;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

- (void)baGuaView:(BaGuaView *)drawLotsView funcUrl:(NSString *)funcUrl {
    if (funcUrl) {
        WebViewController *viewController = [[WebViewController alloc] init];
        NSString *url = funcUrl;
        url = [url stringByReplacingOccurrencesOfString:@"./" withString:API_URL];
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.myUrl = urlStr;
        viewController.type = WEB_VIEW_TYPE_BAGUA;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - QinHuaiViewDelegate

- (void)qinHuaiTopScrollView:(NSString *)url {
    if (url.length) {
        [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
    } else {
        QingHuaiViewController *qingHuaiVC = [[QingHuaiViewController alloc] init];
        [self.navigationController pushViewController:qingHuaiVC animated:YES];
    }
}

#pragma mark - search

- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

- (void)navBar:(NavBar*)navBar leftButtonTapped:(UIButton*)sender {
    MessageViewController *viewController = [[MessageViewController alloc] init];
    viewController.title = @"消息";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 摇一摇相关方法
- (BOOL)canBecomeFirstResponder {
    return YES;// default is NO
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");

    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"摇动结束");
        if(_drawLotsPopView && _drawLotsPopView.shakeStatus == SHAKE_STATUS_NOR) {
            [_drawLotsPopView shake];
            
            SystemSoundID soundId;
            NSString *path = [[NSBundle mainBundle]pathForResource:@"yaoyiyao" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &soundId);
            AudioServicesPlaySystemSound(soundId);
            
        } else {
            if (_drawUrl.length) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"小主，您今日已抽过签啦！明日财运明日测。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            } else {
                if(_drawLotsPopView == nil) {
                    _drawLotsPopView = [[DrawLotsPopView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
                    _drawLotsPopView.delegate = self;
                }
                
                AppDelegate *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                _drawLotsPopView.shakeStatus = SHAKE_STATUS_NOR;
                [_drawLotsPopView showInView:appD.navigationController.view//self.view
                                   fromPoint:CGPointMake(MAIN_SCREEN_WIDTH/2, MAIN_SCREEN_HEIGHT/2)//_mainView.center
                               centerAtPoint:CGPointMake(MAIN_SCREEN_WIDTH/2, MAIN_SCREEN_HEIGHT/2)//self.view.center
                                  completion:^{
                                      
                                  }];
                [_drawLotsPopView shake];
            }
        }
    }
    return;
}

- (void)drawLotsPopView:(DrawLotsPopView*)drawLotsPopView drawLotsModel:(DrawLotsModel *)drawLotsModel {
    _drawUrl = drawLotsModel.funcUrl;
    for (LinksModel *model in _linksArr) {
        if ([model.code isEqualToString:@"draw"]) {
            model.url = _drawUrl;
            break;
        }
    }
}

- (void)popShakeView {
    if(_drawLotsPopView == nil) {
        _drawLotsPopView = [[DrawLotsPopView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
        _drawLotsPopView.delegate = self;
    }
    
    AppDelegate *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _drawLotsPopView.shakeStatus = SHAKE_STATUS_NOR;
    [_drawLotsPopView showInView:appD.navigationController.view
                       fromPoint:CGPointMake(MAIN_SCREEN_WIDTH/2, MAIN_SCREEN_HEIGHT/2)
                   centerAtPoint:CGPointMake(MAIN_SCREEN_WIDTH/2, MAIN_SCREEN_HEIGHT/2)
                      completion:nil];
}

#pragma mark scrollview

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.baguaTableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        
        float fR = 1;
        float fG = 1;//93/255.0;
        float fB = 1;//174/255.0;
        float fAlpha = 1.2 * (offsetY / (150 - 64));
        
        UIColor *cl= [UIColor colorWithRed:fR green:fG blue:fB alpha:fAlpha];
        _navBar.backgroundColor = cl;
        
        if (fAlpha > 0.9) {
            [UIView animateWithDuration:0.3 animations:^{
                _searchBtn.frame = CGRectMake(10, 27, MAIN_SCREEN_WIDTH - 20, 30);
            }];
            [_searchBtn setTitle:@"请输入股票代码/字母" forState:UIControlStateNormal];
            [_searchBtn setImage:[UIImage imageNamed:@"ic_main_search"] forState:UIControlStateNormal];
            _searchBtn.backgroundColor = kUIColorFromRGB(0xf3f3f3);
            _singleLine.hidden = NO;
            _searchBtn.alpha = 0.96;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            _navBar.line_view.hidden = NO;
        } else if (fAlpha < 0.01 && self.tabBarController.selectedIndex == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                _searchBtn.frame = CGRectMake(MAIN_SCREEN_WIDTH - 40, 27, 30, 30);
            }];
            [_searchBtn setTitle:@"" forState:UIControlStateNormal];
            [_searchBtn setImage:[UIImage imageNamed:@"white_search_nor"] forState:UIControlStateNormal];
            _searchBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
            _searchBtn.alpha = 1;
            _singleLine.hidden = YES;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            _navBar.line_view.hidden = YES;
        }else if (self.tabBarController.selectedIndex == 0){
            _singleLine.hidden = YES;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            _navBar.line_view.hidden = YES;
        }
    }
}

#pragma mark - tableView 

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 47 * kScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 7 * kScale, MAIN_SCREEN_WIDTH, 40 * kScale)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"推荐阅读";
    lb1.textColor = kUIColorFromRGB(0x333333);
    lb1.font = [UIFont boldSystemFontOfSize:16 * kScale];
    [view addSubview:lb1];
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(20 * kScale);
    }];
    
    UILabel *blockLb = [UILabel new];
    blockLb.backgroundColor = kUIColorFromRGB(0xff1919);
    [view addSubview:blockLb];
    [blockLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(12 * kScale);
        make.centerY.equalTo(view);
        make.width.equalTo(@(2 * kScale));
        make.height.equalTo(@(12 * kScale));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.textColor = kUIColorFromRGB(0xff1919);
    lb.text = @"TOP10";
    lb.font = [UIFont boldSystemFontOfSize:11 * kScale];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.layer.borderWidth = 0.5;
    lb.layer.borderColor = kUIColorFromRGB(0xff1919).CGColor;
    [view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(42 * kScale));
        make.height.equalTo(@(16 * kScale));
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-15 * kScale);
    }];
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 47 * kScale)];
    coverView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [coverView addSubview:view];
    return coverView;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaguaCell *cell = [tableView dequeueReusableCellWithIdentifier:baguaCellID];
    
    ForumModel *model = self.dataArray1[indexPath.row];
    
    if (model.rowHeight != 0) {
        return model.rowHeight;
    }
    
    cell.model = model;
    
    [cell.contentView layoutIfNeeded];
    
    if (indexPath.section == 0) {
        
        UIImageView *timeLb = [cell valueForKeyPath:@"_iconIv"];
        
        CGFloat y = CGRectGetMaxY(timeLb.frame);
        
        model.rowHeight = y + 12 * kScale;
    } else {
        
        UILabel *timeLb = [cell valueForKeyPath:@"_timeLb"];
        
        CGFloat y = CGRectGetMaxY(timeLb.frame);
        
        model.rowHeight = y + 12 * kScale;
    }
    
    return model.rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumModel *model = self.dataArray1[indexPath.row];
    BaguaCell *cell = [tableView dequeueReusableCellWithIdentifier:baguaCellID];
    
    cell.isForum = YES;
    
    cell.model = model;
    
    cell.pushBlock = ^(NSString *urlStr) {
        WebViewController *viewController = [[WebViewController alloc] init];
        viewController.myUrl = urlStr;
        viewController.type = WEB_VIEW_TYPE_PERSONAL;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:viewController animated:YES];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumModel *model;
    if (self.dataArray1.count <= indexPath.row) {
        return;
    }
    model = self.dataArray1[indexPath.row];
    NSString *url = model.funcUrl;
    
    NSDictionary *dic = (NSDictionary *)model.ctm;
    if ([dic[@"res_code"] isEqualToString:@"S_GOSSIP"]) {
        WebViewController *viewController = [[WebViewController alloc] init];
        url = [url stringByReplacingOccurrencesOfString:@"./" withString:API_URL];
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.myUrl = urlStr;
        viewController.type = WEB_VIEW_TYPE_BAGUA;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        DetailWebViewController *viewController = [[DetailWebViewController alloc] init];
        url = [MarketConfig getUrlWithPath:url];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        viewController.myUrl = url;
        viewController.type = WEB_VIEW_TYPE_COMMENT;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
