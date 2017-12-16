//
//  IdleFundViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/14.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import <Masonry.h>
#import "IdleFundViewController.h"
#import "TigerSearchViewController.h"
#import "IdleFundStockCellTableViewCell.h"
#import "TaoSearchStockViewController.h"
#import "IdleFundAPI.h"

#import "TaoDateList.h"
#import "YearModel.h"

#import "WDHorButton.h"

static NSString *cellID = @"idleFundCell";

@interface IdleFundViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *topLb;
@property (nonatomic, strong) UILabel *bottomLb;
@property (nonatomic, strong) UIImageView *headerIv;

@property (nonatomic, strong) UILabel *centerLb;
@property (nonatomic, strong) UILabel *centerNumLb;
@property (nonatomic, strong) WDHorButton *calenderBtn;
@property (nonatomic, strong) UIButton *searchBtn;

#pragma mark calender view

@property (nonatomic, strong) TaoDateList *taoDateListAPI;

@property (nonatomic, strong) NSArray *yearArray;
@property (nonatomic, strong) NSArray *sendDateArray;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *dataYearArr;
@property (nonatomic, strong) NSArray *dataMonthArr;
@property (nonatomic, strong) NSArray *dataDayArr;

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *pickerTopView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) IdleFundAPI *idleFundAPI;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IdleFundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
    self.title = @"游资侠股";
    
    [self setupUI];
    
    [self.taoDateListAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        self.sendDateArray = request.responseJSONObject;
        [self setupPickerView];
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"failed");
    }];

    
    _navBar.line_view.hidden = YES;
    _navBar.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:_navBar];
}

- (void)setupPickerView {
    
    if (self.sendDateArray.count == 0) {
        self.calenderBtn.title = @"--";
        return;
    }
    
    self.calenderBtn.title = self.sendDateArray.firstObject;
    self.yearArray = [YearModel anayliesDate:self.sendDateArray];
    
    if (_pickerView != nil) {
        [self.pickerView reloadAllComponents];
        return;
    }
    
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
    
    self.headerIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ldleFund_pic"]];
    [self.view addSubview:self.headerIv];
    [self.headerIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(180 * kScale));
    }];
    
    [self.headerIv addSubview:self.topLb];
    [self.headerIv addSubview:self.bottomLb];
    
    [self.topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerIv);
        make.top.equalTo(self.view).offset(64 + 15 * kScale);
    }];
    
    [self.bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerIv);
        make.top.equalTo(self.topLb.mas_bottom).offset(15 * kScale);
        make.left.equalTo(self.view).offset(15 * kScale);
        make.right.equalTo(self.view).offset(-15 * kScale);
    }];
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headerIv.mas_bottom);
        make.height.equalTo(@(47 * kScale));
    }];
    
    [centerView addSubview:self.calenderBtn];
    [centerView addSubview:self.centerLb];
    [centerView addSubview:self.centerNumLb];
    [centerView addSubview:self.searchBtn];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-9 * kScale);
        make.centerY.equalTo(centerView);
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
        make.width.equalTo(@(110 * kScale));
        make.height.equalTo(@(27 * kScale));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(centerView.mas_bottom);
    }];
    
    UILabel *titleLb = [_navBar valueForKeyPath:@"_titleLb"];
    titleLb.textColor = kUIColorFromRGB(0xffffff);
    titleLb.text = self.name;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.idleFundAPI start];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark request

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"idleFundStock failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
    
    IdleFundStockModel *model = [MTLJSONAdapter modelOfClass:[IdleFundStockModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    self.topLb.text = [NSString stringWithFormat:@"%@ %@",model.tm,model.slg];
    self.bottomLb.text = model.dsc;
    self.dataArray = [MTLJSONAdapter modelsOfClass:[IdleFundStockListModel class] fromJSONArray:[request.responseJSONObject objectForKey:@"list"] error:nil];
    
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
    self.idleFundAPI.d = sendS;
    [self.idleFundAPI start];
    
    self.calenderBtn.title = sendS;
}

- (void)cancelBtnClick:(UIButton *)btn {
    [self closePickerView];
}

- (void)closePickerView {
    self.coverView.hidden = YES;
    self.pickerView.hidden = YES;
    self.pickerTopView.hidden = YES;
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
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40 * kScale;
}

#pragma mark tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49 * kScale;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_HEIGHT, 30 * kScale)];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UILabel *lb1 = [UILabel new];
    lb1.text = @"股票 / 代码";
    lb1.font = [UIFont systemFontOfSize:12 * kScale];
    lb1.textColor = kUIColorFromRGB(0x666666);
    
    UILabel *lb2 = [UILabel new];
    lb2.text = @"当日收盘价";
    lb2.font = [UIFont systemFontOfSize:12 * kScale];
    lb2.textColor = kUIColorFromRGB(0x666666);
    
    UILabel *lb3 = [UILabel new];
    lb3.text = @"当日涨跌幅";
    lb3.font = [UIFont systemFontOfSize:12 * kScale];
    lb3.textColor = kUIColorFromRGB(0x666666);
    
    [view addSubview:lb1];
    [view addSubview:lb2];
    [view addSubview:lb3];
    
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(15 * kScale);
    }];
    
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.centerX.equalTo(view);
    }];
    
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-15 * kScale);
    }];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IdleFundStockCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IdleFundStockListModel *item = self.dataArray[indexPath.row];
    
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

#pragma mark lazy loading

- (IdleFundAPI *)idleFundAPI {
    if (_idleFundAPI == nil) {
        if (_idleFundAPI == nil) {
            _idleFundAPI = [[IdleFundAPI alloc] init];
            _idleFundAPI.code = @"yz";
            _idleFundAPI.d = @"";
            _idleFundAPI.delegate = self;
        }
        return _idleFundAPI;
    }
    return _idleFundAPI;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15 * kScale, 0, 15 * kScale);
        _tableView.separatorColor = kUIColorFromRGB(0xd3d3d3);
        [_tableView registerClass:[IdleFundStockCellTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}


- (UILabel *)topLb {
    if (_topLb == nil) {
        _topLb = [UILabel new];
        _topLb.font = [UIFont systemFontOfSize:12 * kScale];
        _topLb.textColor = [UIColor whiteColor];
    }
    return _topLb;
}

- (UILabel *)bottomLb {
    if (_bottomLb == nil) {
        _bottomLb = [UILabel new];
        _bottomLb.font = [UIFont systemFontOfSize:14 * kScale];
        _bottomLb.textColor = [UIColor whiteColor];
        _bottomLb.numberOfLines = 0;
    }
    return _bottomLb;
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

- (TaoDateList *)taoDateListAPI {
    if (_taoDateListAPI == nil) {
        _taoDateListAPI = [[TaoDateList alloc] init];
        _taoDateListAPI.code = @"yz";
        _taoDateListAPI.count = @1000;
    }
    return _taoDateListAPI;
}

@end
