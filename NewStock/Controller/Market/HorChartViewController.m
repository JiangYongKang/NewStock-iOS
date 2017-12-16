//
//  HorChartViewController.m
//  NewStock
//
//  Created by Willey on 16/11/2.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "HorChartViewController.h"
#import "Y_StockChartView.h"
#import "Y_StockChartView.h"

#import "UIColor+Y_StockChart.h"
#import "NetWorking.h"
#import "HorStockInfoView.h"
#import "MarketConfig.h"

#import "StockBaseInfoAPI.h"
#import "KLineInfoAPI.h"
#import "FifthPosAPI.h"
#import "FinanceInfoAPI.h"
#import "SymbolnewsAPI.h"
#import "TradesDetailAPI.h"

#import "FifthPosModel.h"
#import "StockBaseInfoModel.h"
#import "TradeDetailModel.h"

#import "HMSegmentedControl.h"
#import "ListPopView.h"
#import "FifthPosView.h"
#import "ProductSelView.h"

#import "Y_StockChartGlobalVariable.h"

#import "APIBaseRequest+AnimatingAccessory.h"

#import "AppDelegate.h"

@interface HorChartViewController ()<Y_StockChartViewDataSource,HorStockInfoViewDelegate,ListPopViewDelegate, FifthPosViewDelegate,ProductSelViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) HorStockInfoView *stockInfoView;

@property (nonatomic, strong) Y_StockChartView *stockChartView;
@property (nonatomic, strong) FifthPosView *fifthPosView;
@property (nonatomic, strong) ProductSelView *productSelView;

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;
@property (nonatomic, strong) StockBaseInfoModel *stockBaseInfoModel;
@property (nonatomic, strong) NSMutableArray *tradeDetailArray;

//api
@property (nonatomic, strong) StockBaseInfoAPI *stockBaseInfoAPI;
@property (nonatomic, strong) KLineInfoAPI *klineInfoAPI;
@property (nonatomic, strong) FifthPosAPI *fifthPosAPI;
@property (nonatomic, strong) TradesDetailAPI *tradeDetailAPI;

//@property (nonatomic, strong) FinanceInfoAPI *financeInfoAPI;
//@property (nonatomic, strong) SymbolnewsAPI *symbolnewsAPI;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;


@property (nonatomic, strong) ListPopView *stockInfoPopView;
@property (nonatomic, strong) NSMutableArray *stockInfoArray;


@property (nonatomic, assign) int stockChartViewHeight;
@property (nonatomic, assign) NSInteger stockInfoViewHeight;
@end

@implementation HorChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navBar.hidden = YES;
    self.stockInfoViewHeight = 44 * kScale;
    self.stockChartViewHeight = _nMainViewWidth - 44 * kScale;
    
    _tradeDetailArray = [[NSMutableArray alloc] init];
    
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);//.with.insets(UIEdgeInsetsMake(0, 0,0, 0));//0
    }];
    [_scrollView layoutIfNeeded];//
    _scrollView.delegate = self;
    
    _mainView.backgroundColor = [UIColor whiteColor];
    [_mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(_scrollView);//.multipliedBy(2)
    }];
    [_mainView layoutIfNeeded];//
    
    _stockInfoView = [[HorStockInfoView alloc] initWithDelegate:self];
    _stockInfoView.backgroundColor = [UIColor whiteColor];//[SystemUtil hexStringToColor:@"#005dae"];//kUIColorFromRGB(0x0071e1);//
    [_mainView addSubview:_stockInfoView];
    [_stockInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stockInfoView.superview).offset(0);
        make.left.equalTo(_stockInfoView.superview).offset(0);
        make.right.equalTo(_stockInfoView.superview).offset(0);
        make.height.mas_equalTo(self.stockInfoViewHeight);
    }];
    
    [_stockInfoView setCode:_stockListModel.symbol
                       name:_stockListModel.symbolName
                      value:_stockListModel.consecutivePresentPrice
                     change:[NSString stringWithFormat:@"%.2f",[_stockListModel.stockUD doubleValue]]
                 changeRate:[SystemUtil getPercentage:[_stockListModel.tradeIncrease doubleValue]]
                     volume:@"--"
                       time:@""];
    
    self.currentIndex = 0;
    self.stockChartView.backgroundColor = [UIColor backgroundColor];
}

- (Y_StockChartView *)stockChartView {
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.currentStockType = self.currentStockType;

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
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分钟 ▼" type:Y_StockChartcenterViewTypeKline]//∨▽﹀▼
                                       
                                       ];
        _stockChartView.dataSource = self;
        _stockChartView.currentStockType = self.currentStockType;
        [_mainView addSubview:_stockChartView];
        
        [self.stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_stockInfoView.mas_bottom).offset(3 * kScale);
            make.left.equalTo(self.stockChartView.superview).offset(0.5);
            make.right.equalTo(self.stockChartView.superview).offset(0);
            make.bottom.equalTo(self.stockChartView.superview).offset(-0.5);
            //make.height.mas_equalTo(self.stockChartViewHeight);
        }];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        tap.numberOfTapsRequired = 2;
//        [self.view addGestureRecognizer:tap];
        
        
        if (self.currentStockType == Y_StockType_AStock) {
            //int viewWidth = MAIN_SCREEN_WIDTH * [Y_StockChartGlobalVariable fifthPosViewRadio];
            int viewWidth = [Y_StockChartGlobalVariable fifthPosViewWidth];
            _fifthPosView = [[FifthPosView alloc] initWithWidth:viewWidth height:self.stockChartViewHeight - 44 * kScale];
            _fifthPosView.delegate = self;
            _fifthPosView.layer.borderWidth = 0.5;
            _fifthPosView.layer.borderColor = kUIColorFromRGB(0xd3d3d3).CGColor;//SEP_BG_COLOR.CGColor;
            [_mainView addSubview:_fifthPosView];
            [_fifthPosView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.stockChartView.mas_top).offset(40 * kScale);
                make.right.equalTo(_fifthPosView.superview).offset(0);
                make.height.mas_equalTo(self.stockChartViewHeight - 44 * kScale);
                make.width.mas_equalTo(viewWidth);
            }];
        }
        
        _productSelView = [[ProductSelView alloc] init];
        _productSelView.delegate = self;
        _productSelView.layer.borderWidth = 0.5;
        _productSelView.layer.borderColor = kUIColorFromRGB(0xd3d3d3).CGColor;//SEP_BG_COLOR.CGColor;
        [_mainView addSubview:_productSelView];
        [_productSelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stockChartView.mas_top).offset(40 * kScale);
            make.right.equalTo(_productSelView.superview).offset(-1);
            make.height.mas_equalTo(self.stockChartViewHeight - 34 * kScale);
            make.width.mas_equalTo(60);
        }];
        _productSelView.hidden = YES;
    }
    return _stockChartView;
}

- (void)dismiss {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isEable = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    if (self.currentIndex == 0) {
        static int updateCount = 0;
        
        float f = [MarketConfig getAppRefreshTime];
        int n = 30 / f;
        if (updateCount % n == 0) {
            [self loadStockData];
        } else {
            [self loadStockBaseData];
        }
        updateCount++;
    } else {
        [self loadStockBaseData];
    }
}

- (id)stockDatasWithIndex:(NSInteger)index {
    NSString *type;
    switch (index) {
        case 0:
        {
            type = @"2";
            //type = @"1min";
            
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = NO;
            }
            
            _productSelView.hidden = YES;
        }
            break;
        case 1:
        {
            type = @"13";//@"4";//
            //type = @"5min";
            
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }
            
            _productSelView.hidden = YES;
        }
            break;
        case 2:
        {
            type = @"10";
            //type = @"1day";
            
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }
            
            _productSelView.hidden = NO;
        }
            break;
        case 3:
        {
            type = @"11";
            //type = @"1week";
            
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }
            
            _productSelView.hidden = NO;
        }
            break;
        case 4:
        {
            type = @"12";
            //type = @"1month";
            
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }
            
            _productSelView.hidden = NO;
        }
            break;
            
            
        case 5://1分钟
        {
            
            type = @"2";
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }
            
            _productSelView.hidden = NO;
        }
            break;
        case 6://5分钟
        {
            
            type = @"4";
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }
            
            _productSelView.hidden = NO;
        }
            break;
        case 7://15分钟
        {
            type = @"6";
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }
            
            _productSelView.hidden = NO;

        }
            break;
        case 8://30分钟
        {
            
            type = @"8";
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }

            _productSelView.hidden = NO;
        }
            break;
        case 9://60分钟
        {
            
            type = @"9";
            if (self.currentStockType == Y_StockType_AStock)
            {
                _fifthPosView.hidden = YES;
            }

            _productSelView.hidden = NO;
        }
            break;

            
        default:
            break;
    }
    
    /*
     K线种类：
     
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
        
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
    
    if (self.currentIndex == 0) {
        if (self.currentStockType == Y_StockType_AStock) {
            //五档
            if(!_fifthPosAPI)_fifthPosAPI = [[FifthPosAPI alloc] initWithSymbolTyp:_stockListModel.symbolTyp symbol:_stockListModel.symbol marketCd:_stockListModel.marketCd chartTyp:self.type];
            [_fifthPosAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                NSLog(@"%@",_fifthPosAPI.responseJSONObject);
                FifthPosModel *model;
                model = [MTLJSONAdapter modelOfClass:[FifthPosModel class] fromJSONDictionary:_fifthPosAPI.responseJSONObject error:nil];
                [_fifthPosView setFifthPosModel:model];
            } failure:^(APIBaseRequest *request) {
                NSLog(@"failed");
            }];
        }
    }
    
    [self loadStockBaseData];
}

- (void)loadStockBaseData {
    //return;
    //基本信息
    if(!_stockBaseInfoAPI)_stockBaseInfoAPI = [[StockBaseInfoAPI alloc] initWithSymbolTyp:_stockListModel.symbolTyp symbol:_stockListModel.symbol marketCd:_stockListModel.marketCd];
    [_stockBaseInfoAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
        //NSLog(@"%@",_stockBaseInfoAPI.responseJSONObject);
        StockBaseInfoModel *model = [MTLJSONAdapter modelOfClass:[StockBaseInfoModel class] fromJSONDictionary:_stockBaseInfoAPI.responseJSONObject error:nil];
        self.stockBaseInfoModel = model;
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(self.stockBaseInfoModel.consecutivePresentPriceTime.longLongValue) / 1000];
        
        
        
        NSDateFormatter *formatter = [NSDateFormatter new];
//        NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
//        [formatter setTimeZone:timeZone];
        formatter.dateFormat = @"HH:mm";
        NSString *dateStr = [formatter stringFromDate:date];
        
        [_stockInfoView setCode:self.stockBaseInfoModel.symbol
                           name:self.stockBaseInfoModel.symbolName
                          value:[SystemUtil getPrecisionPrice:self.stockBaseInfoModel.consecutivePresentPrice]
                         change:[NSString stringWithFormat:@"%.2f",[self.stockBaseInfoModel.stockUD doubleValue]]
                     changeRate:[SystemUtil getPercentage:[self.stockBaseInfoModel.tradeIncrease doubleValue]]
                         volume:[SystemUtil FormatValue:self.stockBaseInfoModel.consecutiveVolume dig:2]
                           time:dateStr];
        
        
        _stockListModel.symbolName = self.stockBaseInfoModel.symbolName;
        self.title = _stockListModel.symbolName;
        [_navBar setTitle:self.title];
        
    } failure:^(APIBaseRequest *request) {
        NSLog(@"failed");
    }];
}

- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict {
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}

#pragma mark - ProductSelViewDelegate
- (void)productSelView:(ProductSelView*)productSelView selectedIndex:(int)index {
    if (index == 0) {
        [_stockChartView showKLineAccessoryView:NO];
    } else {
        [_stockChartView showKLineAccessoryView:YES];
        [_stockChartView setAccessoryViewIndex:index];
    }
}

#pragma mark - FifthPosViewDelegate
- (void)fifthPosView:(FifthPosView*)fifthPosView selectIndex:(NSInteger)index {
    if (index == 1)
    {
        if (self.currentStockType == Y_StockType_AStock)
        {
            if(!_tradeDetailAPI)_tradeDetailAPI = [[TradesDetailAPI alloc] initWithSymbolTyp:_stockListModel.symbolTyp symbol:_stockListModel.symbol marketCd:_stockListModel.marketCd];
            [_tradeDetailAPI startWithCompletionBlockWithSuccess:^(APIBaseRequest *request) {
                NSLog(@"%@",_tradeDetailAPI.responseJSONObject);
                NSArray *array = [_tradeDetailAPI.responseJSONObject objectForKey:@"symbolTrades"];
                NSArray *arr = [MTLJSONAdapter modelsOfClass:[TradeDetailModel class] fromJSONArray:array error:nil];
                _tradeDetailArray = [NSMutableArray arrayWithArray:arr];
                [_fifthPosView setTradeArray:_tradeDetailArray];
                
            } failure:^(APIBaseRequest *request) {
                NSLog(@"failed");
            }];
        }
        
    }
    
}

#pragma mark - HorStockInfoViewDelegate
- (void)horStockInfoView:(HorStockInfoView*)horStockInfoView {
    [self dismiss];
}


@end
