//
//  RedRootViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/13.
//  Copyright © 2017年 Willey. All rights reserved.
//
#import <Masonry.h>
#import "MJRefresh.h"
#import <MTLJSONAdapter.h>

#import "RedRootViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"
#import "TaoSearchStockViewController.h"
#import "TigerSearchViewController.h"

#import "MJChiBaoZiHeader.h"
#import "RedRootAPI.h"
#import "TaoDateList.h"
#import "YearModel.h"
#import "RedRootModel.h"
#import "RedRootTableViewCell.h"
#import "WDHorButton.h"

static NSString *cellID = @"redRootCell";

@interface RedRootViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UILabel *centerLb;
@property (nonatomic, strong) UILabel *centerNumLb;
@property (nonatomic, strong) WDHorButton *calenderBtn;
@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) NSArray <RedRootListModel *> *dataArray;

@property (nonatomic, strong) RedRootAPI *redRootAPI;
@property (nonatomic, strong) RedRootModel *model;
@property (nonatomic, strong) TaoDateList *taoDateListAPI;

@property (nonatomic, strong) NSArray *yearArray;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *dataYearArr;
@property (nonatomic, strong) NSArray *dataMonthArr;
@property (nonatomic, strong) NSArray *dataDayArr;

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *pickerTopView;

@end

@implementation RedRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    self.title = self.name;
    
    [self setupUI];
    
    [self.taoDateListAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        self.yearArray = [YearModel anayliesDate:request.responseJSONObject];
        [self setupPickerView];
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"failed");
    }];
}

- (void)setupPickerView {
    
    [self.view addSubview:self.coverView];
    
    [self.view addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@(200 * kScale));
    }];
    
    [self.view addSubview:self.pickerTopView];
    [self.pickerTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.pickerView.mas_top);
        make.height.equalTo(@(50 * kScale));
    }];
    
    [self closePickerView];
}

- (void)setupUI {
    [self.view addSubview:self.calenderBtn];
    [self.view addSubview:self.centerLb];
    [self.view addSubview:self.centerNumLb];
    [self.view addSubview:self.searchBtn];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.equalTo(@(180 * kScale));
    }];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).offset(19 * kScale);
        make.top.equalTo(self.headerView.mas_bottom).offset(16.5 * kScale);
    }];
    
    [self.centerNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerLb);
        make.left.equalTo(self.centerLb.mas_right).offset(3);
    }];
    
    [self.calenderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15 * kScale);
        make.centerY.equalTo(self.centerLb);
        make.width.equalTo(@(110 * kScale));
        make.height.equalTo(@(27 * kScale));
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15 * kScale);
        make.centerY.equalTo(self.centerLb);
        make.width.height.equalTo(self.calenderBtn);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(47 * kScale);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.tableView.tableFooterView = [UIView new];
    
    _navBar.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:_navBar];
    _navBar.line_view.hidden = YES;
}

#pragma mark ------

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark loadData 

- (void)loadData {
    [self.redRootAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    [self.tableView.mj_header endRefreshing];
}

- (void)requestFinished:(APIBaseRequest *)request {
    [self.tableView.mj_header endRefreshing];
    
    NSLog(@"%@",request.responseJSONObject);
    self.model = [MTLJSONAdapter modelOfClass:[RedRootModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    self.dataArray = [MTLJSONAdapter modelsOfClass:[RedRootListModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
    self.centerNumLb.text = [NSString stringWithFormat:@"%zd",self.dataArray.count];
    [self.tableView reloadData];
}

#pragma mark actions

- (void)calenderBtnClick:(UIButton *)btn {
    self.pickerView.hidden = NO;
    self.coverView.hidden = NO;
    self.pickerTopView.hidden = NO;
}

- (void)searchBtnClick:(UIButton *)btn {

    TigerSearchViewController *tiger = [TigerSearchViewController new];
    [self.navigationController pushViewController:tiger animated:YES];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self closePickerView];
}

- (void)sureBtnClick:(UIButton *)btn {
    [self closePickerView];
    
    NSInteger row0 = [self.pickerView selectedRowInComponent:0];
    NSInteger row1 = [self.pickerView selectedRowInComponent:1];
    NSInteger row2 = [self.pickerView selectedRowInComponent:2];
    
    YearModel *yearS = self.dataYearArr[row0];
    MonthModel *monthS = self.dataMonthArr[row1];
    DayModel *dayS = self.dataDayArr[row2];
    
    NSString *sendS = [NSString stringWithFormat:@"%@-%@-%@",yearS.yearStr,monthS.monthStr,dayS.dayStr];
    self.redRootAPI.d = sendS;
    [self loadData];
}

- (void)cancelBtnClick:(UIButton *)btn {
    [self closePickerView];
}

- (void)closePickerView {
    self.coverView.hidden = YES;
    self.pickerView.hidden = YES;
    self.pickerTopView.hidden = YES;
}

#pragma mark tableView delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UILabel *nameLb = [UILabel new];
    nameLb.text = @"名称 / 代码";
    nameLb.textColor = kUIColorFromRGB(0x666666);
    nameLb.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *rateLb = [UILabel new];
    rateLb.text = @" 当日涨跌幅";
    rateLb.textColor = kUIColorFromRGB(0x666666);
    rateLb.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *pureBuyLb = [UILabel new];
    pureBuyLb.text = @" 当日净买入(万)";
    pureBuyLb.textColor = kUIColorFromRGB(0x666666);
    pureBuyLb.font = [UIFont systemFontOfSize:12 * kScale];
    
    [v addSubview:nameLb];
    [v addSubview:rateLb];
    [v addSubview:pureBuyLb];
    
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v).offset(15 * kScale);
        make.centerY.equalTo(v);
    }];
    
    [rateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(v);
        make.right.equalTo(v.mas_centerX).offset(-20 * kScale);
    }];
    
    [pureBuyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(v);
        make.left.equalTo(v.mas_centerX).offset(20 * kScale);
    }];
    
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RedRootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.heightBlcok = ^ {
        RedRootListModel *item = self.dataArray[indexPath.row];
        
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
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RedRootListModel *item = self.dataArray[indexPath.row];
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    vc.d = self.calenderBtn.title;
    vc.s = item.s;
    vc.t = item.t;
    vc.m = item.m;
    vc.n = item.n;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark pickerView delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataYearArr.count;
    } else if (component == 1) {
        return self.dataMonthArr.count;
    } else {
        return self.dataDayArr.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        YearModel *m = self.dataYearArr[row];
        return [NSString stringWithFormat:@"%@年",m.yearStr];
    } else if (component == 1) {
        MonthModel *m = self.dataMonthArr[row];
        return [NSString stringWithFormat:@"%@月",m.monthStr];
    } else {
        DayModel *m = self.dataDayArr[row];
        return [NSString stringWithFormat:@"%@日",m.dayStr];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"%zd %zd",row,component);
    
    if (component == 0) {
        YearModel *m = self.dataYearArr[row];
        self.dataMonthArr = m.monthArray;
        [pickerView reloadComponent:1];
        
        MonthModel *m1 = self.dataMonthArr[0];
        self.dataDayArr = m1.dayArray;
        [pickerView reloadComponent:2];
        
    } else if (component == 1) {
        MonthModel *m = self.dataMonthArr[row];
        self.dataDayArr = m.dayArray;
        [pickerView reloadComponent:2];
    } else {
    
    }

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40 * kScale;
}

#pragma mark lazy loading 

- (UIImageView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RedRoot_pic"]];
        _headerView.clipsToBounds = YES;
        
        UILabel *lb = [[UILabel alloc] init];
        lb.font = [UIFont boldSystemFontOfSize:19 * kScale];
        lb.textColor = [UIColor whiteColor];
        lb.text = self.name;
        [_headerView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(lb.superview);
            make.top.equalTo(lb.superview).offset(30);
        }];
        
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.font = [UIFont systemFontOfSize:12 * kScale];
        lb1.textColor = [UIColor whiteColor];
        lb1.text = @"";
        [_headerView addSubview:lb1];
        [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(lb1.superview);
            make.top.equalTo(lb1.superview).offset(64 + 15 * kScale);
        }];
        self.topLabel = lb1;
        
        UILabel *lb2 = [[UILabel alloc] init];
        lb2.font = [UIFont systemFontOfSize:14 * kScale];
        lb2.numberOfLines = 2;
        lb2.textColor = [UIColor whiteColor];
        NSString *str = @"";
        NSMutableParagraphStyle *nmPara = [NSMutableParagraphStyle new];
        nmPara.lineSpacing = 4;
        NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{
                                NSParagraphStyleAttributeName : nmPara,
                                }];
        lb2.attributedText = nmAttrStr.copy;
        
        [_headerView addSubview:lb2];
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb2.superview).offset(15);
            make.right.equalTo(lb2.superview).offset(-15);
            make.top.equalTo(lb1.mas_bottom).offset(15 * kScale);
        }];
        
        self.bottomLabel = lb2;
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        [_tableView registerClass:[RedRootTableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15 * kScale, 0, 15 * kScale);
    }
    return _tableView;
}

- (RedRootAPI *)redRootAPI {
    if (_redRootAPI == nil) {
        _redRootAPI = [[RedRootAPI alloc] init];
        _redRootAPI.delegate = self;
        _redRootAPI.d = @"";
        _redRootAPI.code = self.code.length ? self.code : @"";
    }
    return _redRootAPI;
}

- (void)setModel:(RedRootModel *)model {
    _model = model;
    self.calenderBtn.title = model.tm;
    self.topLabel.text = [NSString stringWithFormat:@"%@ %@",model.tm,model.slg];
    NSMutableParagraphStyle *nmPara = [NSMutableParagraphStyle new];
    nmPara.lineSpacing = 4;
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:model.dsc attributes:@{
                                                                                                              NSParagraphStyleAttributeName : nmPara,
                                                                                                              }];
    self.bottomLabel.attributedText = nmAttrStr.copy;
}

- (UILabel *)centerLb {
    if (_centerLb == nil) {
        _centerLb = [UILabel new];
        _centerLb.textColor = kUIColorFromRGB(0x333333);
        _centerLb.font = [UIFont systemFontOfSize:14 * kScale];
        _centerLb.text = @"今日上榜";
    }
    return _centerLb;
}

- (UILabel *)centerNumLb {
    if (_centerNumLb == nil) {
        _centerNumLb = [UILabel new];
        _centerNumLb.textColor = kUIColorFromRGB(0xff1919);
        _centerNumLb.font = [UIFont systemFontOfSize:14 * kScale];
    }
    return _centerNumLb;
}

- (WDHorButton *)calenderBtn {
    if (_calenderBtn == nil) {
        _calenderBtn = [[WDHorButton alloc] init];
        _calenderBtn.imgStr = @"calender_nor";
        [_calenderBtn addTarget:self action:@selector(calenderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _calenderBtn.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
        _calenderBtn.layer.borderWidth = 0.5 * kScale;
    }
    return _calenderBtn;
}

- (UIButton *)searchBtn {
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_searchBtn setTitle:@"龙虎榜搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:kUIColorFromRGB(0x808080) forState:UIControlStateNormal];
        [_searchBtn setImage:[UIImage imageNamed:@"black_search_nor"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
        _searchBtn.layer.borderWidth = 0.5 * kScale;
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
    }
    return _searchBtn;
}

- (TaoDateList *)taoDateListAPI {
    if (_taoDateListAPI == nil) {
        _taoDateListAPI = [[TaoDateList alloc] init];
        _taoDateListAPI.code = self.code.length ? self.code : @"jghm";
        _taoDateListAPI.count = @1000;
    }
    return _taoDateListAPI;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = kUIColorFromRGB(0xffffff);
    }
    return _pickerView;
}

- (NSArray *)dataYearArr {
    if (_dataYearArr == nil) {
        _dataYearArr = self.yearArray;
    }
    return _dataYearArr;
}

- (NSArray *)dataMonthArr {
    if (_dataMonthArr == nil) {
        YearModel *model = self.yearArray[0];
        _dataMonthArr = model.monthArray;
    }
    return _dataMonthArr;
}

- (NSArray *)dataDayArr {
    if (_dataDayArr == nil) {
        MonthModel *m = self.dataMonthArr[0];
        _dataDayArr = m.dayArray;
    }
    return _dataDayArr;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (UIView *)pickerTopView {
    if (_pickerTopView == nil) {
        _pickerTopView = [UIView new];
        _pickerTopView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        
        UIButton *sureBtn = [[UIButton alloc] init];
        UIButton *cancelBtn = [[UIButton alloc] init];
        
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [sureBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        
        [_pickerTopView addSubview:sureBtn];
        [_pickerTopView addSubview:cancelBtn];
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_pickerTopView);
            make.right.equalTo(_pickerTopView).offset(-15 * kScale);
        }];
        
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_pickerTopView);
            make.left.equalTo(_pickerTopView).offset(15 * kScale);
        }];
        
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _pickerTopView;
}

@end
