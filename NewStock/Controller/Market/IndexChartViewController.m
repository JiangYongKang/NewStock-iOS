//
//  IndexChartViewController.m
//  NewStock
//
//  Created by Willey on 16/8/8.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "IndexChartViewController.h"
#import "StockNoticeViewController.h"

#import "Y_StockChartView.h"
#import "Y_StockChartView.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"
#import "NetWorking.h"
#import "StockInfoView.h"
#import "MarketConfig.h"

#import "StockBaseInfoAPI.h"
#import "KLineInfoAPI.h"
#import "FinanceInfoAPI.h"
#import "SymbolnewsAPI.h"

#import "StockBaseInfoModel.h"

#import "HMSegmentedControl.h"
#import "ListPopView.h"

#import "TalkStockTableViewCell.h"
#import "NoticeTableViewCell.h"
#import "FinanceTableViewCell.h"

#import "StockHistoryUtil.h"

#import "EmbedWebView.h"

#import "UMSocial.h"
#import "UMMobClick/MobClick.h"

#import "BlurCommentView.h"
#import "StockBottomBar.h"

#import "SystemUtil.h"
#import "NativeUrlRedirectAction.h"
#import "FeedMappedAPI.h"

#import "APIBaseRequest+AnimatingAccessory.h"

#import "SearchViewController.h"

#import "MJChiBaoZiHeader.h"

#import "AppDelegate.h"
#import "HorChartViewController.h"

#import "SharedInstance.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface IndexChartViewController ()<Y_StockChartViewDataSource,StockInfoViewDelegate,ListPopViewDelegate,EmbedWebViewDelegate,UMSocialUIDelegate,BlurCommentViewDelegate,StockBottomBarDelegate>

@property (nonatomic, strong) StockInfoView *stockInfoView;
@property (nonatomic, strong) StockBottomBar *bottomBar;
@property (nonatomic) UIImageView *bottomPopImg;

@property (nonatomic, strong) Y_StockChartView *stockChartView;

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;
@property (nonatomic, strong) StockBaseInfoModel *stockBaseInfoModel;

//api
@property (nonatomic, strong) StockBaseInfoAPI *stockBaseInfoAPI;
@property (nonatomic, strong) KLineInfoAPI *klineInfoAPI;
@property (nonatomic, strong) FinanceInfoAPI *financeInfoAPI;
@property (nonatomic, strong) SymbolnewsAPI *symbolnewsAPI;

@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger curSelSegmentIndex;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ListPopView *stockInfoPopView;
@property (nonatomic, strong) NSMutableArray *stockInfoArray;

@property (nonatomic, strong) EmbedWebView *webView;

@property (nonatomic, strong) FeedMappedAPI *feedMappedAPI;

@property (nonatomic, assign) NSInteger stockChartViewHeight;
@property (nonatomic, assign) NSInteger stockInfoViewHeight;


@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, strong) JSContext *context;

@property (nonatomic, strong) UIView *sepView;

@end


@implementation IndexChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _indexModel.symbolName;
    [_navBar setTitle:self.title];
    [_navBar setSubTitle:_indexModel.symbol];
    [self setRightBtnImg:[UIImage imageNamed:@"navbar_search_yellow"]];
    _navBar.line_view.hidden = NO;
    
    _bOneDay = NO;
    _bFiveDay = NO;
    _bDayKLine = NO;
    _bWeekKLine = NO;
    _bMonthKLine = NO;

    self.stockInfoViewHeight = 80 * kScale;
    self.stockChartViewHeight = 360 * kScale;
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 49 * kScale, 0));
    }];
    [_scrollView updateConstraints];
    [_scrollView layoutIfNeeded];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _totalHeight = MAIN_SCREEN_HEIGHT + _stockInfoViewHeight + _stockChartViewHeight + 10 * kScale * 3;
    
    NSDictionary *dic = @{@"s":_indexModel.symbol,
                          @"m":_indexModel.marketCd,
                          @"t":_indexModel.symbolTyp};
    NSDictionary *param = @{@"page":@1,
                            @"count":@20,
                            @"list":@[dic]};
    NSString *url = [MarketConfig getUrlWithPath:H5_STOCK_HP0104 Param:param];

    self.webView = [[EmbedWebView alloc] initWithUrl:url];
    self.webView.delegate = self;
    
    self.webView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, _totalHeight);
    
    [_scrollView addSubview:self.webView];
    _scrollView.scrollEnabled = NO;
    [_scrollView updateConstraints];
    [_scrollView layoutIfNeeded];
    
    _mainView.backgroundColor = kUIColorFromRGB(0xf1f1f1);

    [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_webView);
        make.left.right.equalTo(_webView);
        make.height.mas_equalTo(_totalHeight - MAIN_SCREEN_HEIGHT);
    }];
    [_mainView updateConstraints];//
    [_mainView layoutIfNeeded];//
    
    _stockInfoView = [[StockInfoView alloc] initWithDelegate:self :STOCKINFOVIEWTYPE_INDEX];
    _stockInfoView.backgroundColor = [UIColor whiteColor];//TITLE_BAR_BG_COLOR;
    [_mainView addSubview:_stockInfoView];
    [_stockInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stockInfoView.superview).offset(0);
        make.left.equalTo(_stockInfoView.superview).offset(0);
        make.right.equalTo(_stockInfoView.superview).offset(0);
        make.height.mas_equalTo(self.stockInfoViewHeight);
    }];
    [_stockInfoView setCode:_indexModel.symbol
                      value:[SystemUtil getPrecisionPrice:[_indexModel.consecutivePresentPrice doubleValue] precision:[_indexModel.pricePrecision intValue]]
                     change:[NSString stringWithFormat:@"%.2f",[_indexModel.stockUD doubleValue]]
                 changeRate:[SystemUtil getPercentage:[_indexModel.tradeIncrease doubleValue]]
                    highest:@"--"
                     amount:@"--"
                     lowest:@"--"
                     volume:@"--"
               turnoverRate:@"--"
                      open:@"--"
                       swing:@"--"
                  prevClose:@"--"];
    
    self.currentIndex = 0;
    self.stockChartView.backgroundColor = [UIColor backgroundColor];
    
    [_mainView layoutIfNeeded];
    
    BOOL b = [StockHistoryUtil searchStockFromMyStock:_indexModel.symbol symbolTyp:_indexModel.symbolTyp marketCd:_indexModel.marketCd];
    if (b) {
        [self setAddBtnMode:YES];
    }
    
    [_webView addSubview:_mainView];
    self.webView.webView.scrollView.contentInset = UIEdgeInsetsMake(self.stockInfoViewHeight + 10 * kScale * 3 + self.stockChartViewHeight , 0, 0, 0 );
    
    _scrollView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(49 * kScale));
    }];
    
    [self.view addSubview:self.bottomPopImg];
    [self.bottomPopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-2);
        make.bottom.equalTo(self.bottomBar.mas_top);
        make.height.equalTo(@(0 * kScale));
    }];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    
    _scrollView.contentSize = CGSizeMake(0, _totalHeight);
}

- (Y_StockChartView *)stockChartView {
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.currentStockType = Y_StockType_Index;

        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5日" type:Y_StockChartcenterViewTypeTimeLine],
                                      
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"日K" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"周K" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"月K" type:Y_StockChartcenterViewTypeKline],
                                       
                                       ];
        _stockChartView.dataSource = self;
        _stockChartView.currentStockType = Y_StockType_Index;
        [_mainView addSubview:_stockChartView];
        
        [self.stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_stockInfoView.mas_bottom).offset(10 * kScale);
            make.left.equalTo(self.stockChartView.superview).offset(0);
            make.right.equalTo(self.stockChartView.superview).offset(0);
            make.height.mas_equalTo(self.stockChartViewHeight);
        }];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showHorChart)];
        tap.numberOfTapsRequired = 1;//2;
        [self.stockChartView addGestureRecognizer:tap];
        
        [_mainView addSubview:self.sepView];
        [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_mainView);
            make.top.equalTo(_stockChartView.mas_bottom).offset(0);
            make.height.equalTo(@(20 * kScale));
        }];
    }
    return _stockChartView;
}

- (void)showHorChart {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isEable = YES;
    HorChartViewController *stockChartVC = [HorChartViewController new];
    //stockChartVC.modelsDict = self.modelsDict;
    
    StockListModel *model = [[StockListModel alloc] init];
    model.symbolName = self.indexModel.symbolName;
    model.symbol = self.indexModel.symbol;
    model.symbolTyp = self.indexModel.symbolTyp;
    model.marketCd = self.indexModel.marketCd;
    stockChartVC.stockListModel = model;
    
    stockChartVC.currentStockType = Y_StockType_Index;
    
//    stockChartVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    stockChartVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;    // 设置动画效果

    [self presentViewController:stockChartVC animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [StockHistoryUtil addStockToHistory:_indexModel.symbol symbolName:_indexModel.symbolName symbolTyp:_indexModel.symbolTyp marketCd:_indexModel.marketCd];
    
    [_myTimer invalidate];
    float f = [MarketConfig getAppRefreshTime];
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:f
                                                target:self
                                              selector:@selector(timerMethod:) userInfo:nil
                                               repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_myTimer invalidate];
    
}

- (void)timerMethod:(NSTimer *)paramSender {
    if (self.currentIndex == 0)
    {
        static int updateCount1 = 0;
        
        float f = [MarketConfig getAppRefreshTime];
        int n = 30/f;
        if (updateCount1 % n == 0)
        {
            [self loadStockData];
        }
        else
        {
            [self loadStockBaseData];
        }
        updateCount1++;
    }
    else
    {
        [self loadStockBaseData];
    }
}

- (id)stockDatasWithIndex:(NSInteger)index {
    NSString *type;
    switch (index) {
        case 0: {
            type = @"2";
            
            if (_bOneDay == NO) {
                //事件统计
                NSDictionary *dict = @{@"type":@"详情",@"name":_indexModel.symbolName};
                [MobClick event:STOCK_DETAIL attributes:dict];
                _bOneDay = YES;
            }
        }
            break;
        case 1: {
            type = @"13";//@"4";
            
            if (_bFiveDay == NO) {
                NSDictionary *dict = @{@"type":@"5日",@"name":_indexModel.symbolName};
                [MobClick event:STOCK_DETAIL attributes:dict];
                _bFiveDay = YES;
            }
        }
            break;
        case 2: {
            type = @"10";
            
            if (_bDayKLine == NO) {
                NSDictionary *dict = @{@"type":@"日K",@"name":_indexModel.symbolName};
                [MobClick event:STOCK_DETAIL attributes:dict];
                _bDayKLine = YES;
            }
        }
            break;
        case 3: {
            type = @"11";
            
            if (_bWeekKLine == NO) {
                NSDictionary *dict = @{@"type":@"周K",@"name":_indexModel.symbolName};
                [MobClick event:STOCK_DETAIL attributes:dict];
                _bWeekKLine = YES;
            }
        }
            break;
        case 4: {
            type = @"12";
            
            if (_bMonthKLine == NO) {
                NSDictionary *dict = @{@"type":@"月K",@"name":_indexModel.symbolName};
                [MobClick event:STOCK_DETAIL attributes:dict];
                _bMonthKLine = YES;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    self.currentIndex = index;
    self.type = type;
    if(![self.modelsDict objectForKey:type]) {
        [self loadStockData];

        //[self reloadData];
    } else {
        return [self.modelsDict objectForKey:type].models;
    }
    return nil;
}

- (void)reloadData {
    [self loadStockData];

    [self.webView.webView reload];
}

- (void)loadStockData {
    //symbolType 3:股票区分（A股）     symbol 600000 股票代码   marketCd 1 市场代码（上海）  chartTyp 2 K线区分()
    /**
     chartTyp:
     1:Tick
     2:1分K线
     3:3分K线
     4:5分K线
     5:10分K线
     6:15分K线
     7:20分K线
     8:30分K线
     9:60分K线
     10:日K线
     11:周K线
     12:月K线
     13:五日
     14:季K线
     15:年K线
     16:1分
     */
    if(!_klineInfoAPI)_klineInfoAPI = [[KLineInfoAPI alloc] initWithSymbolTyp:_indexModel.symbolTyp symbol:_indexModel.symbol marketCd:_indexModel.marketCd chartTyp:self.type];
    [_klineInfoAPI setChartTyp:self.type];
    _klineInfoAPI.ignoreCache = YES;
    
    if(![self.modelsDict objectForKey:self.type])
    {
        _klineInfoAPI.animatingView = _scrollView;
        _klineInfoAPI.animatingText = @"数据加载中...";//@"正在加载";
    }
    else
    {
        _klineInfoAPI.animatingView = nil;//self.view;
        _klineInfoAPI.animatingText = @"";
    }
    
    
    [_klineInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        //NSLog(@"update ui");
        //NSLog(@"%@",_klineInfoAPI.responseJSONObject);
        
        Y_KLineGroupModel *groupModel;
        
        if ([self.type isEqualToString:@"13"])  {
            
            groupModel = [Y_KLineGroupModel objectWith5MinArray:_klineInfoAPI.responseJSONObject[@"chartInfLst"]];
            
        } else {
            groupModel = [Y_KLineGroupModel objectWithArray:_klineInfoAPI.responseJSONObject[@"chartInfLst"]];
        }
        
        if (groupModel) {
            self.groupModel = groupModel;
            [self.modelsDict setObject:groupModel forKey:self.type];
            //NSLog(@"%@",groupModel);
            [self.stockChartView reloadData];
        }
        
        [_scrollView.mj_header endRefreshing];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
        
        [_scrollView.mj_header endRefreshing];
    }];
    
    [self loadStockBaseData];
}

- (void)loadStockBaseData {
    //基本信息
    if(!_stockBaseInfoAPI)_stockBaseInfoAPI = [[StockBaseInfoAPI alloc] initWithSymbolTyp:_indexModel.symbolTyp symbol:_indexModel.symbol marketCd:_indexModel.marketCd];
    [_stockBaseInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        //NSLog(@"%@",_stockBaseInfoAPI.responseJSONObject);
        StockBaseInfoModel *model = [MTLJSONAdapter modelOfClass:[StockBaseInfoModel class] fromJSONDictionary:_stockBaseInfoAPI.responseJSONObject error:nil];
        self.stockBaseInfoModel = model;
        
        [_stockInfoView setCode:self.stockBaseInfoModel.symbol
                          value:[SystemUtil getPrecisionPrice:_stockBaseInfoModel.consecutivePresentPrice]
                         change:[NSString stringWithFormat:@"%.2f",[self.stockBaseInfoModel.stockUD doubleValue]]
                     changeRate:[SystemUtil getPercentage:[self.stockBaseInfoModel.tradeIncrease doubleValue]]
                        highest:[SystemUtil getPrecisionPrice:self.stockBaseInfoModel.high]//[SystemUtil FormatValue:self.stockBaseInfoModel.high dig:2]
                         amount:[SystemUtil FormatValue:self.stockBaseInfoModel.volumePrice dig:2]
                         lowest:[SystemUtil getPrecisionPrice:self.stockBaseInfoModel.low]
                         volume:[SystemUtil FormatValue:self.stockBaseInfoModel.consecutiveVolume dig:2]
                   turnoverRate:[SystemUtil FormatValue:_stockBaseInfoModel.turnover dig:2]
                          open:[SystemUtil FormatValue:_stockBaseInfoModel.open dig:2]
                          swing:[SystemUtil FormatValue:_stockBaseInfoModel.amplitude dig:2]
                      prevClose:[SystemUtil getPrecisionPrice:_stockBaseInfoModel.prevClose]];//[SystemUtil FormatValue:self.stockBaseInfoModel. dig:2]
        
        _indexModel.symbolName = self.stockBaseInfoModel.symbolName;
        self.title = _indexModel.symbolName;
        [_navBar setTitle:self.title];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];

}

- (NSMutableDictionary <NSString *,Y_KLineGroupModel *> *)modelsDict {
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}

- (void)bottomPopBtnClick:(UIButton *)btn {
    [self sharedBtnClick];
    [self closeBottomPopView];
}

- (void)bottomPopImgTap:(UITapGestureRecognizer *)tap {
    [self stockNoticeBtnClick];
    [self closeBottomPopView];
}

- (void)stockNoticeBtnClick {
    NSLog(@"预警");
    if (![SystemUtil isSignIn]) {
        [self popLoginViewController];
        return;
    }
    StockNoticeViewController *vc = [StockNoticeViewController new];
    if (!(_indexModel.symbol && _indexModel.symbolTyp && _indexModel.marketCd)) {
        return;
    }
    vc.t = _indexModel.symbolTyp;
    vc.s = _indexModel.symbol;
    vc.m = _indexModel.marketCd;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate

//根据scrollView滚动de偏移量来控制窗口菜单的显示与否
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == _scrollView) {
//        CGFloat scrollViewOffsetY = scrollView.contentOffset.y;
//        NSLog(@"%.2lf %.2lf",scrollViewOffsetY,self.totalHeight - MAIN_SCREEN_HEIGHT);
//        if (scrollViewOffsetY < self.totalHeight - MAIN_SCREEN_HEIGHT) {
//            self.webView.webView.scrollView.scrollEnabled = NO;
//        } else {
//            self.webView.webView.scrollView.scrollEnabled = YES;
//        }
//    }
}

- (void)didFinishLoadWebView {
    __weak typeof(self)weakSelf = self;
    UIScrollView *sc = [weakSelf valueForKey:@"_scrollView"];
    self.context[@"getScrollHeight"] = ^() {
        NSString *h = [weakSelf.webView.webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"];
        if (h.floatValue > 40) {
            sc.scrollEnabled = YES;
        } else {
            sc.scrollEnabled = NO;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf updateContentSize];
        });
    };
}

- (void)updateContentSize {
    NSString *h = [self.webView.webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"];
    if (h.floatValue <= 40) {
        return;
    }
    _totalHeight = _totalHeight - MAIN_SCREEN_HEIGHT + h.floatValue;
    self.webView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, _totalHeight);
    [self viewDidLayoutSubviews];
}

#pragma mark bottomBar delegate

- (void)stockBottomBarDelegatePushTo:(NSString *)url {
    NSLog(@"%@",url);
    if ([url isEqualToString:@"交易"]) {
        [self closeBottomPopView];
        NSString *url = [NSString stringWithFormat:@"%@%@?MAC=NULL&CPU=%@&code=%@&trade=buy",API_URL,H5_TR0001,[SystemUtil getUUIDForDevice],_stockBaseInfoModel.symbol];
        [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
    } else if ([url containsString:@"自选"]) {
        [self closeBottomPopView];
        [self addOrDeleteBtnClick];
    } else if ([url isEqualToString:@"更多"]) {
        if (self.bottomPopImg.frame.size.height == 0) {
            [self.bottomPopImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(90 * kScale));
            }];
            [UIView animateWithDuration:0.1 animations:^{
                [self.view layoutIfNeeded];
                _bottomPopImg.alpha = 1;
            }];
        } else {
            [self.bottomPopImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(0 * kScale));
            }];
            [UIView animateWithDuration:0.1 animations:^{
                [self.view layoutIfNeeded];
                _bottomPopImg.alpha = 0;
            }];
        }
    }
}

- (void)closeBottomPopView {
    [self.bottomPopImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0 * kScale));
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
        _bottomPopImg.alpha = 0;
    }];
}

#pragma StockInfoViewDelegate
- (void)stockInfoView:(StockInfoView *)stockInfoView {
    if (_stockBaseInfoModel)
    {
        UIColor *highColor = [SystemUtil getStockUpDownColor:_stockBaseInfoModel.high.floatValue preClose:_stockBaseInfoModel.prevClose.floatValue];
        UIColor *lowColor = [SystemUtil getStockUpDownColor:_stockBaseInfoModel.low.floatValue preClose:_stockBaseInfoModel.prevClose.floatValue];
        UIColor *openColor = [SystemUtil getStockUpDownColor:_stockBaseInfoModel.open.floatValue preClose:_stockBaseInfoModel.prevClose.floatValue];
        UIColor *planColor = PLAN_COLOR;
        NSString *volum = [SystemUtil FormatValue:[NSString stringWithFormat:@"%.2lf",_stockBaseInfoModel.consecutiveVolume.floatValue / 100] dig:2];
        
        self.stockInfoArray = [NSMutableArray arrayWithArray:@[
                                                               @{
                                                                   @"最高": @{@"value":[SystemUtil getPrecisionPrice:_stockBaseInfoModel.high],@"color":highColor},
                                                                   @"昨收": @{@"value":[SystemUtil getPrecisionPrice:_stockBaseInfoModel.prevClose],@"color":planColor},
                                                                   @"最低": @{@"value":[SystemUtil getPrecisionPrice:_stockBaseInfoModel.low],@"color":lowColor},
                                                                   @"今开": @{@"value":[SystemUtil getPrecisionPrice:_stockBaseInfoModel.open],@"color":openColor},
                                                                   },
                                                               @{
                                                                   @"成交量": @{@"value":volum,@"color":planColor},
                                                                   @"成交额": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.volumePrice dig:2],@"color":planColor},
                                                                   @"振幅": @{@"value":[SystemUtil getPercentage:[_stockBaseInfoModel.amplitude doubleValue]],@"color":planColor},
                                                                   @" ": @{@"value":@"",@"color":planColor},
                                                                   },
                                                               /*@{
                                                                @"总市值": [SystemUtil FormatValue:_stockBaseInfoModel.totalMarketVal dig:2],
                                                                @"流通市值": [SystemUtil FormatValue:_stockBaseInfoModel.marketVal dig:2],
                                                                @" ": @" ",
                                                                @"量比": _stockBaseInfoModel.quantityRatio,
                                                                },*/
                                                               ]];
        
        if(self.stockInfoArray == nil) return;
        if(self.stockInfoPopView == nil)
        {
            self.stockInfoPopView              = [[ListPopView alloc] initWithFrame:CGRectMake(0, 0, 300, 280)];
            self.stockInfoPopView.delegate     = self;
        }
        self.stockInfoPopView.contentArray = self.stockInfoArray;
        [self.stockInfoPopView setTitle:_indexModel.symbolName
                                  value:[SystemUtil getPrecisionPrice:_stockBaseInfoModel.consecutivePresentPrice]
                          increaseValue:[NSString stringWithFormat:@"%.2f",_stockBaseInfoModel.stockUD.doubleValue]
                               increase:[SystemUtil getPercentage:[_stockBaseInfoModel.tradeIncrease doubleValue]]];//@"行情数据"
        [self.stockInfoPopView setUp:_stockBaseInfoModel.riseCount plan:_stockBaseInfoModel.keepCount down:_stockBaseInfoModel.fallCount];
        [self.stockInfoPopView showInView:self.view
                                fromPoint:_scrollView.center//CGPointMake(self.stockInfoView.center.x, self.stockInfoView.center.y+60)
                            centerAtPoint:self.view.center
                               completion:nil];
    }
    
}

#pragma mark - search
- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)addOrDeleteBtnClick {

    BOOL b = [StockHistoryUtil searchStockFromMyStock:_indexModel.symbol symbolTyp:_indexModel.symbolTyp marketCd:_indexModel.marketCd];
    if (b) {
        //已有，删除
        [StockHistoryUtil deleteMyStock:_indexModel.symbol symbolName:_indexModel.symbolName symbolTyp:_indexModel.symbolTyp marketCd:_indexModel.marketCd];
        
        [self setAddBtnMode:NO];
    } else {
        ADD_STOCK_STATU status = [StockHistoryUtil addStockToMyStock:_indexModel.symbol symbolName:_indexModel.symbolName symbolTyp:_indexModel.symbolTyp marketCd:_indexModel.marketCd];
        
        switch (status) {
            case ADD_STOCK_FALSE: {
                
                break;
            }
            case ADD_STOCK_SUC: {
                
                [self setAddBtnMode:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"添加成功！"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case ADD_STOCK_FULL: {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"自选股超过了100个！"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                
                break;
            }
            case ADD_STOCK_EXIST: {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"该自选股已经存在！"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
        }
        
    }
}

- (void)sharedBtnClick {

    [_scrollView setContentOffset:CGPointZero animated:NO];
    
    UIImage *image = [SystemUtil getStockShareImg:_navBar and:_mainView];
    NSString *url = @"http://www.guguaixia.com";
    NSString *title = [NSString stringWithFormat:@"股怪侠-%@",_indexModel.symbolName];
    
    [SharedInstance sharedSharedInstance].sid = [NSString stringWithFormat:@"%@.%@.%@",_indexModel.symbol,_indexModel.symbolTyp,_indexModel.marketCd];
    [SharedInstance sharedSharedInstance].image = image;
    [SharedInstance sharedSharedInstance].tt = title;
    [SharedInstance sharedSharedInstance].c = @"";
    [SharedInstance sharedSharedInstance].url = url;
    [SharedInstance sharedSharedInstance].res_code = @"S_STOCK";
    [[SharedInstance sharedSharedInstance] shareWithImage:YES];
}

- (void)setAddBtnMode:(BOOL)isON {
    [self.bottomBar setIsAdd:isON];
}

- (StockBottomBar *)bottomBar {
    if (_bottomBar == nil) {
        _bottomBar = [[StockBottomBar alloc] initWithType:STOCK_BAR_TYPE_INDEX];
        _bottomBar.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        _bottomBar.delegate = self;
    }
    return _bottomBar;
}

- (UIImageView *)bottomPopImg {
    if (_bottomPopImg == nil) {
        _bottomPopImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_bottom_pop"]];
        _bottomPopImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomPopImgTap:)];
        [_bottomPopImg addGestureRecognizer:tap];
        
        UIButton *btn = [UIButton new];
        [_bottomPopImg addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_bottomPopImg);
            make.height.equalTo(_bottomPopImg).multipliedBy(0.45);
        }];
        [btn addTarget:self action:@selector(bottomPopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomPopImg;
}

- (UIView *)sepView {
    if (_sepView == nil) {
        _sepView = [UIView new];
        _sepView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [_sepView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(_sepView);
            make.height.equalTo(_sepView).multipliedBy(0.5);
        }];
    }
    return _sepView;
}

- (JSContext *)context {
    if (_context == nil) {
        _context = [self.webView.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
}

- (void)dealloc {
    _webView.webView.delegate = nil;
    _webView.webView.scrollView.delegate = nil;
}

@end
