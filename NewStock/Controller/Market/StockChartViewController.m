//
//  StockChartViewController.m
//  NewStock
//
//  Created by Willey on 16/7/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "StockChartViewController.h"
#import "SearchViewController.h"
#import "HorChartViewController.h"
#import "IndexChartViewController.h"
#import "StockNoticeViewController.h"

#import "Y_StockChartView.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"
#import "Y_StockChartGlobalVariable.h"

#import "NetWorking.h"
#import "NativeUrlRedirectAction.h"
#import "StockInfoView.h"
#import "MarketConfig.h"
#import "APIBaseRequest+AnimatingAccessory.h"
#import "StockHistoryUtil.h"
#import "AppDelegate.h"
#import "SharedInstance.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "StockBaseInfoAPI.h"
#import "KLineInfoAPI.h"
#import "FifthPosAPI.h"
#import "FinanceInfoAPI.h"
#import "SymbolnewsAPI.h"
#import "TradesDetailAPI.h"
#import "FeedMappedAPI.h"
#import "IndexInfoAPI.h"

#import "FifthPosModel.h"
#import "StockBaseInfoModel.h"
#import "TradeDetailModel.h"
#import "IndexInfoModel.h"

#import "HMSegmentedControl.h"
#import "MJChiBaoZiHeader.h"
#import "EmbedWebView.h"
#import "ListPopView.h"
#import "FifthPosView.h"
#import "StockBottomBar.h"

#import "TalkStockTableViewCell.h"
#import "NoticeTableViewCell.h"
#import "FinanceTableViewCell.h"

#import "UMSocial.h"
#import "UMMobClick/MobClick.h"

@interface StockChartViewController () <Y_StockChartViewDataSource,StockInfoViewDelegate,ListPopViewDelegate, FifthPosViewDelegate,EmbedWebViewDelegate,UMSocialUIDelegate,BlurCommentViewDelegate,CAAnimationDelegate,StockBottomBarDelegate>

@property (nonatomic, strong) StockInfoView *stockInfoView;
@property (nonatomic, strong) StockBottomBar *bottomBar;

@property (nonatomic, strong) Y_StockChartView *stockChartView;
@property (nonatomic, strong) FifthPosView *fifthPosView;

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;
@property (nonatomic, strong) StockBaseInfoModel *stockBaseInfoModel;
@property (nonatomic, strong) NSMutableArray *tradeDetailArray;

//api
@property (nonatomic, strong) StockBaseInfoAPI *stockBaseInfoAPI;
@property (nonatomic, strong) KLineInfoAPI *klineInfoAPI;
@property (nonatomic, strong) FifthPosAPI *fifthPosAPI;
@property (nonatomic, strong) TradesDetailAPI *tradeDetailAPI;
@property (nonatomic, strong) IndexInfoAPI *indexInfoAPI;

@property (nonatomic, strong) FinanceInfoAPI *financeInfoAPI;
@property (nonatomic, strong) SymbolnewsAPI *symbolnewsAPI;

@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) HMSegmentedControl *segmentedControlNews;
@property (nonatomic, strong) HMSegmentedControl *segmentedControlNews2;
@property (nonatomic, assign) NSInteger curSelSegmentIndex;

@property (nonatomic, assign) NSInteger segmentedControlNewsHeight;

@property (nonatomic, strong) ListPopView *stockInfoPopView;
@property (nonatomic, strong) NSMutableArray *stockInfoArray;

@property (nonatomic, strong) EmbedWebView *webView;

@property (nonatomic, strong) FeedMappedAPI *feedMappedAPI;

@property (nonatomic, assign) int stockChartViewHeight;
@property (nonatomic, assign) NSInteger stockInfoViewHeight;

//新增按钮 接入已有逻辑
@property (nonatomic) IndexInfoModel *indexInfoModel;
@property (nonatomic) UIImageView *bottomPopImg;
@property (nonatomic) UIView *topBlockView;

@property (nonatomic) JSContext *context;

@end

@implementation StockChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _stockListModel.symbolName;
    [_navBar setTitle:self.title];
    [_navBar setSubTitle:_stockListModel.symbol];
    _navBar.line_view.hidden = NO;
    [self setRightBtnImg:[UIImage imageNamed:@"navbar_search_yellow"]];
    
    _bOneDay = NO;
    _bFiveDay = NO;
    _bDayKLine = NO;
    _bWeekKLine = NO;
    _bMonthKLine = NO;
    
    self.stockInfoViewHeight = 80 * kScale;
    self.stockChartViewHeight = 360 * kScale;
    self.segmentedControlNewsHeight = 40;
    
    _tradeDetailArray = [[NSMutableArray alloc] init];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));//0
    }];
    [_scrollView layoutIfNeeded];//
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _mainView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    [_mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.mas_equalTo(self.stockInfoViewHeight + 10 * kScale * 2 + self.stockChartViewHeight + self.segmentedControlNewsHeight + (MAIN_SCREEN_HEIGHT));
    }];
    [_mainView layoutIfNeeded];//
    
    [_mainView addSubview:self.topBlockView];
    [self.topBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_mainView);
        make.height.mas_equalTo(self.stockInfoViewHeight + 10 * kScale * 2 + self.stockChartViewHeight);
    }];
    
    _stockInfoView = [[StockInfoView alloc] initWithDelegate:self :STOCKINFOVIEWTYPE_STOCK];
//    _stockInfoView.backgroundColor = [UIColor purpleColor];//TITLE_BAR_BG_COLOR;
    [_topBlockView addSubview:_stockInfoView];
    [_stockInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stockInfoView.superview).offset(0 * kScale);
        make.left.equalTo(_stockInfoView.superview).offset(0);
        make.right.equalTo(_stockInfoView.superview).offset(0);
        make.height.mas_equalTo(self.stockInfoViewHeight);
    }];
    
    [_stockInfoView setCode:_stockListModel.symbol
                      value:_stockListModel.consecutivePresentPrice
                     change:[NSString stringWithFormat:@"%.2f",[_stockListModel.stockUD doubleValue]]
                 changeRate:[SystemUtil getPercentage:[_stockListModel.tradeIncrease doubleValue]]
                    highest:@"--"
                     amount:@"--"
                     lowest:@"--"
                     volume:@"--"
               turnoverRate:@"--"
                       open:@"--"
                      swing:@"--"
                  prevClose:@"--"];
    
    
    
    //
    //self.currentIndex = -1;
    self.currentIndex = 0;
    self.stockChartView.backgroundColor = [UIColor backgroundColor];
    
    // Tying up the segmented control to a scroll view
    self.curSelSegmentIndex = 0;
    self.segmentedControlNews = [self segmentedControl];

    [_mainView addSubview:self.segmentedControlNews];
    [self.segmentedControlNews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBlockView.mas_bottom).offset(10 * kScale);
        make.left.equalTo(_mainView).offset(0);
        make.right.equalTo(_mainView).offset(0);
        make.height.mas_equalTo(self.segmentedControlNewsHeight);
    }];
    [self.segmentedControlNews layoutIfNeeded];
    UIView *segBottomLine1 = [[UIView alloc]init];
    segBottomLine1.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self.segmentedControlNews addSubview:segBottomLine1];
    [segBottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(segBottomLine1.superview);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(segBottomLine1.superview);
    }];
    
    //2
    self.segmentedControlNews2 = [self segmentedControl];
    [self.view addSubview:self.segmentedControlNews2];
    [self.segmentedControlNews2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBar.mas_bottom).offset(0);
        make.left.equalTo(self.segmentedControlNews2.superview).offset(0);
        make.right.equalTo(self.segmentedControlNews2.superview).offset(0);
        make.height.mas_equalTo(self.segmentedControlNewsHeight);
    }];
    self.segmentedControlNews2.hidden = YES;
    
    UIView *segBottomLine = [[UIView alloc]init];
    segBottomLine.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [self.segmentedControlNews2 addSubview:segBottomLine];
    [segBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(segBottomLine.superview);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(segBottomLine.superview);
    }];
    
    [_mainView layoutIfNeeded];

    __weak typeof(self) weakSelf = self;
    [self.segmentedControlNews setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.segmentedControlNews2 setSelectedSegmentIndex:index animated:NO];
    }];
    
    [self.segmentedControlNews2 setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.segmentedControlNews setSelectedSegmentIndex:index animated:NO];
    }];
    
    NSDictionary *dic = @{@"s":_stockListModel.symbol,
                          @"m":_stockListModel.marketCd,
                          @"t":_stockListModel.symbolTyp};
    NSDictionary *param = @{@"page":@1,
                            @"count":@20,
                            @"list":@[dic]};
    [self.webView setUrl:[MarketConfig getUrlWithPath:H5_STOCK_HP0104 Param:param]];
    NSString *url = [MarketConfig getUrlWithPath:H5_STOCK_HP0104 Param:param];
    //@"http://192.168.8.21:9001/HQ1002.html?param={\"m\":1,\"t\":3,\"count\":20,\"s\":\"601069\",\"page\":1}";
    self.webView = [[EmbedWebView alloc] initWithUrl:url];
    self.webView.delegate = self;
    self.webView.webView.opaque = NO;
    self.webView.webView.backgroundColor = [UIColor whiteColor];
    self.webView.webView.scrollView.scrollEnabled = NO;

    [_mainView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_mainView);
        make.top.equalTo(_segmentedControlNews.mas_bottom);
    }];

    

    BOOL b = [StockHistoryUtil searchStockFromMyStock:_stockListModel.symbol symbolTyp:_stockListModel.symbolTyp marketCd:_stockListModel.marketCd];
    if (b) {
        [self setAddBtnMode:YES];
    }
    
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

- (void)showHorChart {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isEable = YES;

    HorChartViewController *stockChartVC = [HorChartViewController new];
    stockChartVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //stockChartVC.modelsDict = self.modelsDict;
    stockChartVC.stockListModel = self.stockListModel;
    stockChartVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;    // 设置动画效果

    [self presentViewController:stockChartVC animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [StockHistoryUtil addStockToHistory:_stockListModel.symbol symbolName:_stockListModel.symbolName symbolTyp:_stockListModel.symbolTyp marketCd:_stockListModel.marketCd];
    
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

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    self.curSelSegmentIndex = segmentedControl.selectedSegmentIndex;
    if (self.curSelSegmentIndex == 500) //删除的评论界面 不执行
    {
        NSDictionary *param = @{//@"page":@1,
                                //@"count":@20,
                                @"s":_stockListModel.symbol,
                                @"m":_stockListModel.marketCd,
                                @"t":_stockListModel.symbolTyp};
        NSString *url = [NSString stringWithFormat:@"%@&%@",[MarketConfig getUrlWithPath:H5_STOCK_TALK Param:param],@"_type=1"];
        [self.webView setUrl:url];
    }
    else if(self.curSelSegmentIndex == 0)
    {
        NSDictionary *dic = @{@"s":_stockListModel.symbol,
                              @"m":_stockListModel.marketCd,
                              @"t":_stockListModel.symbolTyp};
        NSDictionary *param = @{@"page":@1,
                                @"count":@100,
                                @"list":@[dic]};
        [self.webView setUrl:[MarketConfig getUrlWithPath:H5_STOCK_HP0104 Param:param]];
    }
    else if(self.curSelSegmentIndex == 1)
    {
        NSDictionary *param = @{@"page":@1,
                                @"count":@100,
                                @"s":_stockListModel.symbol,
                                @"m":_stockListModel.marketCd,
                                @"t":_stockListModel.symbolTyp};
        [self.webView setUrl:[MarketConfig getUrlWithPath:H5_STOCK_NEWS_LIST Param:param]];
    }
    else if(self.curSelSegmentIndex == 2)
    {
        NSDictionary *param = @{@"s":_stockListModel.symbol,
                                @"m":_stockListModel.marketCd,
                                @"t":_stockListModel.symbolTyp};
        [self.webView setUrl:[MarketConfig getUrlWithPath:H5_STOCK_F10 Param:param]];
    }
    else if(self.curSelSegmentIndex == 3)
    {
        NSDictionary *param = @{@"s":_stockListModel.symbol,
                                @"m":_stockListModel.marketCd,
                                @"n":_stockListModel.symbolName,
                                @"t":_stockListModel.symbolTyp};
        [self.webView setUrl:[MarketConfig getUrlWithPath:H5_STOCK_FINANCE Param:param]];
        
    }
    
//    CGFloat h = self.stockInfoViewHeight + 3 + self.stockChartViewHeight + 3 + self.segmentedControlNewsHeight;
//    [_scrollView setContentOffset:CGPointMake(0, h) animated:YES];
}

- (id)stockDatasWithIndex:(NSInteger)index {
    NSString *type;
    switch (index) {
        case 0:
        {
            type = @"2";
            //type = @"1min";
            _fifthPosView.hidden = NO;
            
            
            if (_bOneDay == NO) {
                //事件统计
                if (_stockListModel.symbolName.length) {
                    NSDictionary *dict = @{@"type":@"详情",@"name":_stockListModel.symbolName};
                    [MobClick event:STOCK_DETAIL attributes:dict];
                    _bOneDay = YES;
                }
            }
        }
            break;
        case 1:
        {
            type = @"13";//@"4";//
            //type = @"5min";
            _fifthPosView.hidden = YES;
            
            if (_bFiveDay == NO) {
                if (_stockListModel.symbolName.length) {
                    NSDictionary *dict = @{@"type":@"5日",@"name":_stockListModel.symbolName};
                    [MobClick event:STOCK_DETAIL attributes:dict];
                    _bFiveDay = YES;
                }
            }
        }
            break;
        case 2:
        {
            type = @"10";
            //type = @"1day";
            _fifthPosView.hidden = YES;
            
            if (_bDayKLine == NO) {
                if (_stockListModel.symbolName.length) {
                    NSDictionary *dict = @{@"type":@"日K",@"name":_stockListModel.symbolName};
                    [MobClick event:STOCK_DETAIL attributes:dict];
                    _bDayKLine = YES;
                }
            }
        }
            break;
        case 3:
        {
            type = @"11";
            //type = @"1week";
            _fifthPosView.hidden = YES;
            
            if (_bWeekKLine == NO) {
                if (_stockListModel.symbolName.length) {
                    NSDictionary *dict = @{@"type":@"周K",@"name":_stockListModel.symbolName};
                    [MobClick event:STOCK_DETAIL attributes:dict];
                    _bWeekKLine = YES;
                }
            }
        }
            break;
        case 4:
        {
            type = @"12";
            //type = @"1month";
            _fifthPosView.hidden = YES;
            
            if (_bMonthKLine == NO) {
                if (_stockListModel.symbolName.length) {
                    NSDictionary *dict = @{@"type":@"月K",@"name":_stockListModel.symbolName};
                    [MobClick event:STOCK_DETAIL attributes:dict];
                    _bMonthKLine = YES;
                }
            }
        }
            break;
            
        default:
            break;
    }

    
    self.currentIndex = index;
    self.type = type;
    if(![self.modelsDict objectForKey:type])
    {
        [self loadStockData];

        //[self reloadData];
        
    } else {
        return [self.modelsDict objectForKey:type].models;
    }
    return nil;
}

#pragma mark loadData
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
    if(!_klineInfoAPI)_klineInfoAPI = [[KLineInfoAPI alloc] initWithSymbolTyp:_stockListModel.symbolTyp symbol:_stockListModel.symbol marketCd:_stockListModel.marketCd chartTyp:self.type];
    [_klineInfoAPI setChartTyp:self.type];
    
    _klineInfoAPI.ignoreCache = YES;
    
    if(![self.modelsDict objectForKey:self.type])
    {
        _klineInfoAPI.animatingView = _scrollView;//self.view;//self.stockChartView;//
        _klineInfoAPI.animatingText = @"数据加载中...";//@"正在加载";
    }
    else
    {
        _klineInfoAPI.animatingView = nil;//self.view;
        _klineInfoAPI.animatingText = @"";
    }
    
    
    [_klineInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        //NSLog(@"update ui");
        NSLog(@"%@",_klineInfoAPI.responseJSONObject);
        
        Y_KLineGroupModel *groupModel;
        
        if ([self.type isEqualToString:@"13"])
        {
            
            groupModel = [Y_KLineGroupModel objectWith5MinArray:_klineInfoAPI.responseJSONObject[@"chartInfLst"]];

        }
        else
        {
            groupModel = [Y_KLineGroupModel objectWithArray:_klineInfoAPI.responseJSONObject[@"chartInfLst"]];
        }
        
        if(groupModel)
        {
            self.groupModel = groupModel;
            [self.modelsDict setObject:groupModel forKey:self.type];
            NSLog(@"%@",groupModel);
            [self.stockChartView reloadData];
        }
        else
        {
            [self.stockChartView reloadData];
        }

        [_scrollView.mj_header endRefreshing];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
        
        [_scrollView.mj_header endRefreshing];
        
    }];
    
    
    
    
    if (self.currentIndex == 0)
    {
        //五档
        if(!_fifthPosAPI)_fifthPosAPI = [[FifthPosAPI alloc] initWithSymbolTyp:_stockListModel.symbolTyp symbol:_stockListModel.symbol marketCd:_stockListModel.marketCd chartTyp:self.type];
        [_fifthPosAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
            //NSLog(@"%@",_fifthPosAPI.responseJSONObject);
            FifthPosModel *model;
            model = [MTLJSONAdapter modelOfClass:[FifthPosModel class] fromJSONDictionary:_fifthPosAPI.responseJSONObject error:nil];
            [_fifthPosView setFifthPosModel:model];
        } failure:^(APIBaseRequest *request) {
            NSLog(@"failed");
        }];

    }
    
    
    
    [self loadStockBaseData];
    
    /*
     _financeInfoAPI = [[FinanceInfoAPI alloc] initWithSymbol:@"600000" marketCd:@"1"];
     _financeInfoAPI.ignoreCache = YES;
     [_financeInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
     NSLog(@"update ui");
     NSLog(@"%@",_financeInfoAPI.responseJSONObject);
     
     } failure:^(APIBaseRequest *request) {
     NSLog(@"failed");
     }];
     
     _symbolnewsAPI = [[SymbolnewsAPI alloc] initWithSymbol:@"600000" symbolTyp:@"3" marketCd:@"1" newsType:@"news" fromNo:@"1" toNo:@"20"];
     _symbolnewsAPI.ignoreCache = YES;
     [_symbolnewsAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
     NSLog(@"update ui");
     //NSLog(@"%@",_symbolnewsAPI.responseJSONObject);
     } failure:^(APIBaseRequest *request) {
     NSLog(@"failed");
     }];
     */

}

- (void)loadStockBaseData {
    //基本信息
    if(!_stockBaseInfoAPI)_stockBaseInfoAPI = [[StockBaseInfoAPI alloc] initWithSymbolTyp:_stockListModel.symbolTyp symbol:_stockListModel.symbol marketCd:_stockListModel.marketCd];
    [_stockBaseInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        //NSLog(@"%@",_stockBaseInfoAPI.responseJSONObject);
        StockBaseInfoModel *model = [MTLJSONAdapter modelOfClass:[StockBaseInfoModel class] fromJSONDictionary:_stockBaseInfoAPI.responseJSONObject error:nil];
        self.stockBaseInfoModel = model;
        NSString *volume = [SystemUtil FormatValue:[NSString stringWithFormat:@"%.2lf",self.stockBaseInfoModel.consecutiveVolume.floatValue / 100] dig:2];
        [_stockInfoView setCode:self.stockBaseInfoModel.symbol
                          value:[SystemUtil getPrecisionPrice:self.stockBaseInfoModel.consecutivePresentPrice]
                         change:[NSString stringWithFormat:@"%.2f",[self.stockBaseInfoModel.stockUD doubleValue]]
                     changeRate:[SystemUtil getPercentage:[self.stockBaseInfoModel.tradeIncrease doubleValue]]
                        highest:[SystemUtil getPrecisionPrice:self.stockBaseInfoModel.high]
                         amount:[SystemUtil FormatValue:self.stockBaseInfoModel.volumePrice dig:2]
                         lowest:[SystemUtil getPrecisionPrice:self.stockBaseInfoModel.low]
                         volume:volume
                   turnoverRate:[SystemUtil FormatValue:_stockBaseInfoModel.turnover dig:2]
                          open:[SystemUtil FormatValue:_stockBaseInfoModel.open dig:2]
                          swing:[SystemUtil FormatValue:_stockBaseInfoModel.amplitude dig:2]
                      prevClose:[SystemUtil getPrecisionPrice:_stockBaseInfoModel.prevClose]];
        //[SystemUtil getPrecisionPrice:_stockBaseInfoModel.prevClose]

        //[SystemUtil FormatValue:self.stockBaseInfoModel. dig:2]
//        _stockInfoView [SystemUtil FormatValue:_stockBaseInfoModel.turnover dig:2];
        

        _stockListModel.symbolName = self.stockBaseInfoModel.symbolName;
        self.title = _stockListModel.symbolName;
        [_navBar setTitle:self.title];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
}

- (void)timerMethod:(NSTimer *)paramSender {
    if (self.currentIndex == 0)
    {
        static int updateCount = 0;
        
        float f = [MarketConfig getAppRefreshTime];
        int n = 30 / f;
        if (updateCount % n == 0)
        {
            [self loadStockData];
        }
        else
        {
            [self loadStockBaseData];
        }
        updateCount++;
    }
    else
    {
        [self loadStockBaseData];
    }
    
}

#pragma mark - FifthPosViewDelegate
- (void)fifthPosView:(FifthPosView *)fifthPosView selectIndex:(NSInteger)index {
    if (index == 1)
    {
        _tradeDetailAPI = [[TradesDetailAPI alloc] initWithSymbolTyp:_stockListModel.symbolTyp symbol:_stockListModel.symbol marketCd:_stockListModel.marketCd];
        [_tradeDetailAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
            //NSLog(@"%@",_tradeDetailAPI.responseJSONObject);
            NSArray *array = [_tradeDetailAPI.responseJSONObject objectForKey:@"symbolTrades"];
            NSArray *arr = [MTLJSONAdapter modelsOfClass:[TradeDetailModel class] fromJSONArray:array error:nil];
            _tradeDetailArray = [NSMutableArray arrayWithArray:arr];
            [_fifthPosView setTradeArray:_tradeDetailArray];

            
           
            
        } failure:^(APIBaseRequest *request) {
            NSLog(@"failed");
        }];
    }
    
}

#pragma mark - UIScrollViewDelegate 根据scrollView滚动de偏移量来控制窗口菜单的显示与否
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollViewOffsetY = scrollView.contentOffset.y;

    if (scrollView == _scrollView) {
        
        [self updateContentSize];
        
        if (scrollViewOffsetY < self.segmentedControlNews.frame.origin.y) {
            self.segmentedControlNews2.hidden = YES;
            self.webView.webView.scrollView.scrollEnabled = NO;
        } else {
            self.segmentedControlNews2.hidden = NO;
            if ([self.webView.myUrl containsString:@"HQ1002"] | [self.webView.myUrl containsString:@"HP0104"]) {
                self.webView.webView.scrollView.scrollEnabled = YES;
            } else {
                self.webView.webView.scrollView.scrollEnabled = NO;
            }
        }
    }
    [self closeBottomPopView];
}

#pragma mark Webview delegate

- (void)didFinishLoadWebView {
    __weak typeof(self)weakSelf = self;
    self.context[@"getScrollHeight"] = ^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf updateContentSize];
        });
    };
}

- (void)updateContentSize {
    NSString *h = [self.webView.webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"];
    if (h.floatValue <= 0) {
        return;
    }
    [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.stockInfoViewHeight + 10 * kScale + self.stockChartViewHeight + 10 * kScale + self.segmentedControlNewsHeight + (h.floatValue) + 60 * kScale);
    }];
}

#pragma mark stockBottomBar delegate

- (void)stockBottomBarDelegatePushTo:(NSString *)url {
    
    if ([url isEqualToString:@"上证"]) {
        [self closeBottomPopView];
        IndexChartViewController *vc = [IndexChartViewController new];
        vc.indexModel = _indexInfoModel;
        if (_indexInfoModel == nil) {
            return;
        }
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate.navigationController pushViewController:vc animated:YES];
    } else if ([url isEqualToString:@"买入"]) {
        [self closeBottomPopView];
        NSString *url = [NSString stringWithFormat:@"%@%@?MAC=""&CPU=%@&code=%@&trade=buy",API_URL,H5_TR0001,[SystemUtil getUUIDForDevice],_stockBaseInfoModel.symbol];
        [[NativeUrlRedirectAction sharedNativeUrlRedirectAction] redictNativeUrl:url];
    } else if ([url isEqualToString:@"卖出"]) {
        [self closeBottomPopView];
        NSString *url = [NSString stringWithFormat:@"%@%@?MAC=""&CPU=%@&code=%@&trade=sale",API_URL,H5_TR0001,[SystemUtil getUUIDForDevice],_stockBaseInfoModel.symbol];
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

#pragma StockInfoViewDelegate
- (void)stockInfoView:(StockInfoView *)stockInfoView {
    if (_stockBaseInfoModel)
    {
        UIColor *highColor = [SystemUtil getStockUpDownColor:_stockBaseInfoModel.high.floatValue preClose:_stockBaseInfoModel.prevClose.floatValue];
        UIColor *lowColor = [SystemUtil getStockUpDownColor:_stockBaseInfoModel.low.floatValue preClose:_stockBaseInfoModel.prevClose.floatValue];
        UIColor *openColor = [SystemUtil getStockUpDownColor:_stockBaseInfoModel.open.floatValue preClose:_stockBaseInfoModel.prevClose.floatValue];
        
        UIColor *highLimitedColor = [SystemUtil getStockUpDownColor:_stockBaseInfoModel.highLimited.floatValue preClose:_stockBaseInfoModel.prevClose.floatValue];
        UIColor *lowLimitedColor = [SystemUtil getStockUpDownColor:_stockBaseInfoModel.lowLimited.floatValue preClose:_stockBaseInfoModel.prevClose.floatValue];
        
        UIColor *planColor = PLAN_COLOR;
        NSString *volum = [SystemUtil FormatValue:[NSString stringWithFormat:@"%.2lf",_stockBaseInfoModel.consecutiveVolume.floatValue / 100] dig:2];
        
        NSArray *arr =  @[
                          @{
                              @"今开": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.open dig:2],@"color":openColor},
                              @"最高": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.high dig:2],@"color":highColor},
                              @"昨收": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.prevClose dig:2],@"color":planColor},
                              @"最低": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.low dig:2],@"color":lowColor},
                              },
                          @{
                              @"涨停": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.highLimited dig:2],@"color":highLimitedColor},
                              @"跌停": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.lowLimited dig:2],@"color":lowLimitedColor},
                              @"换手率": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.turnover dig:2],@"color":planColor},
                              @"振幅": @{@"value":[SystemUtil getPercentage:[_stockBaseInfoModel.amplitude doubleValue]],@"color":planColor},
                              },
                          @{
                              @"成交量": @{@"value":volum,@"color":planColor},
                              @"成交额": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.volumePrice dig:2],@"color":planColor},
                              @"市盈率": @{@"value":_stockBaseInfoModel.earning,@"color":planColor},
                              //@"市净率": @{@"value":_stockBaseInfoModel.pbRatio,@"color":planColor},
                              },
                          @{
                              @"流通股本": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.ltg dig:2],@"color":planColor},
                              @"流通市值": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.marketVal dig:2],@"color":planColor},
                              @"总股本": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.zgb dig:2],@"color":planColor},
                              @"总市值": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.totalMarketVal dig:2],@"color":planColor},
                              },
                          //                                @{
                          //                                    @"内盘": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.sellTotal dig:2],@"color":planColor},
                          //                                    @"外盘": @{@"value":[SystemUtil FormatValue:_stockBaseInfoModel.buyTotal dig:2],@"color":planColor},
                          //                                    //@"52周最高": @"????",
                          //                                    //@"52周最低": @"????",
                          //                                    }
                          
                          ];
        self.stockInfoArray = [NSMutableArray arrayWithArray:arr];
        
        if(self.stockInfoArray == nil)return;
        if(self.stockInfoPopView == nil)
        {
            self.stockInfoPopView              = [[ListPopView alloc] initWithFrame:CGRectMake(0, 0, 300, 340)];
            self.stockInfoPopView.delegate     = self;
        }
        self.stockInfoPopView.contentArray = self.stockInfoArray;
        //[self.stockInfoPopView setTitle:_stockListModel.symbolName value:_stockListModel.consecutivePresentPrice increaseValue:_stockListModel.stockUD increase:_stockListModel.tradeIncrease];//@"行情数据"
        
        
        [self.stockInfoPopView setTitle:_stockBaseInfoModel.symbolName
                                  value:[SystemUtil getPrecisionPrice:_stockBaseInfoModel.consecutivePresentPrice]
                          increaseValue:[NSString stringWithFormat:@"%.2f",_stockBaseInfoModel.stockUD.doubleValue]
                               increase:[SystemUtil getPercentage:[_stockBaseInfoModel.tradeIncrease doubleValue]]];
        
        
        [self.stockInfoPopView showInView:self.view
                                fromPoint:_scrollView.center//CGPointMake(self.stockInfoView.center.x, self.stockInfoView.center.y+60)
                            centerAtPoint:self.view.center
                               completion:nil];
    }
    
}

#pragma mark - action
- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)addOrDeleteBtnClick {

    BOOL b = [StockHistoryUtil searchStockFromMyStock:_stockListModel.symbol symbolTyp:_stockListModel.symbolTyp marketCd:_stockListModel.marketCd];
    if (b) {
        //已有，删除
        [StockHistoryUtil deleteMyStock:_stockListModel.symbol symbolName:_stockListModel.symbolName symbolTyp:_stockListModel.symbolTyp marketCd:_stockListModel.marketCd];
        [self setAddBtnMode:NO];
        
    }
    else
    {
        //添加
        ADD_STOCK_STATU status = [StockHistoryUtil addStockToMyStock:_stockListModel.symbol symbolName:_stockListModel.symbolName symbolTyp:_stockListModel.symbolTyp marketCd:_stockListModel.marketCd];
        
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
    if (!(_stockListModel.symbol && _stockListModel.symbolTyp && _stockListModel.marketCd)) {
        return;
    }
    vc.t = _stockListModel.symbolTyp;
    vc.s = _stockListModel.symbol;
    vc.m = _stockListModel.marketCd;
    [self.navigationController pushViewController:vc animated:YES];
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

- (void)sharedBtnClick {
    [_scrollView setContentOffset:CGPointZero animated:NO];
    UIImage *image = [SystemUtil getStockShareImg:_navBar and:_topBlockView];
    NSString *title = [NSString stringWithFormat:@"股怪侠-%@",_stockListModel.symbolName];
    
    [SharedInstance sharedSharedInstance].sid = [NSString stringWithFormat:@"%@.%@.%@",_stockListModel.symbol,_stockListModel.symbolTyp,_stockListModel.marketCd];
    [SharedInstance sharedSharedInstance].image = image;
    [SharedInstance sharedSharedInstance].tt = title;
    [SharedInstance sharedSharedInstance].c = @"";
    [SharedInstance sharedSharedInstance].url = @"";
    [SharedInstance sharedSharedInstance].res_code = @"S_STOCK";
    [[SharedInstance sharedSharedInstance] shareWithImage:YES];
}

- (void)setAddBtnMode:(BOOL)isON {
    [self.bottomBar setIsAdd:isON];
}

#pragma mark lazy loading
//news + news2 共用一个 seg
- (HMSegmentedControl *)segmentedControl {
    HMSegmentedControl *segC = [[HMSegmentedControl alloc] init];
    segC.selectionIndicatorHeight = 3.0f;
    segC.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segC.sectionTitles = @[@"新闻",@"公告", @"F10", @"财务"];//资料(F10) @"谈股",
    segC.selectedSegmentIndex = 0;
    segC.backgroundColor = [UIColor whiteColor];
    segC.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName : kUIColorFromRGB(0x666666)};
    segC.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kUIColorFromRGB(0x358ee7)};
    
    segC.selectionIndicatorColor = kUIColorFromRGB(0x358ee7);
    segC.selectionIndicatorBoxOpacity = 0.0;
    segC.verticalDividerColor = kUIColorFromRGB(0x666666);
    segC.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;//HMSegmentedControlSelectionStyleFullWidthStripe;
    segC.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [segC addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    return segC;
}

- (Y_StockChartView *)stockChartView {
    if(!_stockChartView) {
        
        int viewWidth = MAIN_SCREEN_WIDTH * [Y_StockChartGlobalVariable fifthPosViewRadio];
        [Y_StockChartGlobalVariable setFifthPosViewWidth:viewWidth];
        
        _stockChartView = [Y_StockChartView new];
        _stockChartView.itemModels = @[
                                       //[Y_StockChartViewItemModel itemModelWithTitle:@"指标" type:Y_StockChartcenterViewTypeOther],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5日" type:Y_StockChartcenterViewTypeTimeLine],
                                       //                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1分" type:Y_StockChartcenterViewTypeKline],
                                       //                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5分" type:Y_StockChartcenterViewTypeKline],
                                       //                                       [Y_StockChartViewItemModel itemModelWithTitle:@"30分" type:Y_StockChartcenterViewTypeKline],
                                       //                                       [Y_StockChartViewItemModel itemModelWithTitle:@"60分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"日K" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"周K" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"月K" type:Y_StockChartcenterViewTypeKline],
                                       
                                       ];
        _stockChartView.dataSource = self;
        [_topBlockView addSubview:_stockChartView];
        //        _stockChartView.backgroundColor = [UIColor orangeColor];
        
        [self.stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_stockInfoView.mas_bottom).offset(10 * kScale);
            make.left.equalTo(self.stockChartView.superview).offset(0.5);
            make.right.equalTo(self.stockChartView.superview).offset(0);
            make.height.mas_equalTo(self.stockChartViewHeight);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHorChart)];
        tap.numberOfTapsRequired = 1;//2;
        [self.stockChartView addGestureRecognizer:tap];
        
        _fifthPosView = [[FifthPosView alloc] initWithWidth:viewWidth height:self.stockChartViewHeight - 40 * kScale];
        _fifthPosView.delegate = self;
        _fifthPosView.layer.borderWidth = 0.5;
        _fifthPosView.layer.borderColor = kUIColorFromRGB(0xd3d3d3).CGColor;
        [_topBlockView addSubview:_fifthPosView];
        [_fifthPosView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stockChartView.mas_top).offset(39.5 * kScale);//25
            make.right.equalTo(_fifthPosView.superview).offset(0);
            make.height.mas_equalTo(self.stockChartViewHeight - 40 * kScale);
            make.width.mas_equalTo(viewWidth);
        }];
        UIView *bottomV = [UIView new];
        bottomV.backgroundColor = kUIColorFromRGB(0xffffff);
        [_topBlockView addSubview:bottomV];
        [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(_topBlockView);
            make.height.equalTo(@(10 * kScale));
        }];
    }
    return _stockChartView;
}

- (IndexInfoAPI *)indexInfoAPI {
    if (_indexInfoAPI == nil) {
        _indexInfoAPI = [[IndexInfoAPI alloc] initWithSymbolTyp:@"" symbol:@"" marketCd:@""];
    }
    return _indexInfoAPI;
}

- (UIView *)topBlockView {
    if (_topBlockView == nil) {
        _topBlockView = [UIView new];
        _topBlockView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    }
    return _topBlockView;
}

- (StockBottomBar *)bottomBar {
    if (_bottomBar == nil) {
        _bottomBar = [[StockBottomBar alloc] initWithType:STOCK_BAR_TYPE_STOCK];
        _bottomBar.backgroundColor = kUIColorFromRGB(0xffffff);
        _bottomBar.delegate = self;
    }
    return _bottomBar;
}

- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict {
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
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

- (JSContext *)context {
    if (_context == nil) {
        _context = [self.webView.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
}

@end
