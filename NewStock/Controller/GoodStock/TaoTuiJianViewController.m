//
//  TaoTuiJianViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/3/10.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoTuiJianViewController.h"
#import "Defination.h"
#import <Masonry.h>
#import "TaoTuiJianDateAPI.h"
#import "TaoTuiJianStockAPI.h"
#import "TaoDateRangeModel.h"
#import "TaoTuiJianModel.h"
#import "TaoTuiJianTableViewCell.h"
#import "TaoSearchStockViewController.h"
#import "TigerSearchViewController.h"

#import "TaoDateList.h"
#import "YearModel.h"
#import "WDHorButton.h"

static NSString *cellID = @"TaoTuiJianCell";

@interface TaoTuiJianViewController () <UITableViewDelegate , UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) TaoTuiJianDateAPI *dateAPI;
@property (nonatomic, strong) TaoTuiJianStockAPI *stockListAPI;
@property (nonatomic, strong) NSArray <TaoDateRangeModel *> *dateArray;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *topLb;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *pickerTopView;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UILabel *centerLb;
@property (nonatomic, strong) UILabel *centerNumLb;
@property (nonatomic, strong) WDHorButton *calenderBtn;
@property (nonatomic, strong) UIButton *searchBtn;

#pragma mark calender view

@property (nonatomic, strong) NSArray *yearArray;
@property (nonatomic, strong) NSArray *sendDateArray;

@property (nonatomic, strong) NSArray *dataYearArr;
@property (nonatomic, strong) NSArray *dataMonthArr;
@property (nonatomic, strong) NSArray *dataDayArr;


@end

@implementation TaoTuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    
    self.title = self.name;
    UILabel *titleLb = [_navBar valueForKeyPath:@"_titleLb"];
    titleLb.text = self.name;
    titleLb.textColor = kUIColorFromRGB(0xffffff);
    _navBar.backgroundColor = [UIColor clearColor];
    _navBar.line_view.hidden = YES;
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    [self getDate];
    [self setupUI];
    [self loadData];
    [self.view bringSubviewToFront:_navBar];
    
}

- (void)getDate {

    [self.dateAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        self.sendDateArray = request.responseJSONObject;
        [self setupPickerView];
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"failed");
    }];
    
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
    [self.view addSubview:self.topImageView];
    
    [self.topImageView addSubview:self.topLb];
    [self.topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topImageView).offset(15 * kScale);
        make.right.equalTo(self.topImageView).offset(-15 * kScale);
        make.centerY.equalTo(self.topImageView.mas_bottom).offset(-67 * kScale);
    }];
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topImageView.mas_bottom);
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
        make.top.equalTo(centerView.mas_bottom).offset(0 * kScale);
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
    [self.stockListAPI start];
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"%@ failed",[request class]);
}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    [self setDscLb:request.responseJSONObject[@"dsc"]];
    self.dataArray = [MTLJSONAdapter modelsOfClass:[TaoTuiJianModel class] fromJSONArray:request.responseJSONObject[@"list"] error:nil];
    self.centerNumLb.text = [NSString stringWithFormat:@"%zd",self.dataArray.count];
    [self.tableView reloadData];
}

- (void)setDscLb:(NSString *)s {
    if (s == nil) {
        return;
    }
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 6 * kScale;
    NSAttributedString *attrS = [[NSAttributedString alloc] initWithString:s attributes:@{
                                                                                          NSParagraphStyleAttributeName : para,
                                                                                          NSFontAttributeName : [UIFont systemFontOfSize:15 * kScale],
                                                                                          
                                                                                          NSForegroundColorAttributeName :  kUIColorFromRGB(0xffffff),
                                                                                          }];
    
    self.topLb.attributedText = attrS;
}

#pragma mark action

#pragma mark actions

- (void)calenderBtnClick:(UIButton *)btn {
    self.pickerView.hidden = NO;
    self.coverView.hidden = NO;
    self.pickerTopView.hidden = NO;
}

- (void)searchBtnClick:(UIButton *)btn {
    TigerSearchViewController *vc = [TigerSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
    
    self.calenderBtn.title = sendS;
    self.stockListAPI.d = sendS;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32 * kScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 32 * kScale)];
    view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    UILabel *nameLb = [UILabel new];
    nameLb.textColor = kUIColorFromRGB(0x666666);
    nameLb.text = @"名称 / 代码";
    nameLb.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *holdLb = [UILabel new];
    holdLb.textColor = kUIColorFromRGB(0x666666);
    holdLb.text = @"当日收盘价";
    holdLb.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *valueLb = [UILabel new];
    valueLb.textColor = kUIColorFromRGB(0x666666);
    valueLb.font = [UIFont systemFontOfSize:12 * kScale];
    valueLb.text = @"当日涨跌幅";
    
    UILabel *bdLb = [UILabel new];
    bdLb.textColor = kUIColorFromRGB(0x666666);
    bdLb.font = [UIFont systemFontOfSize:12 * kScale];
    bdLb.text = @"推荐理由";
    
    [view addSubview:nameLb];
    [view addSubview:holdLb];
    [view addSubview:valueLb];
    [view addSubview:bdLb];
    
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15 * kScale);
        make.centerY.equalTo(view);
    }];
    
    [holdLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view.mas_centerX).offset(-10 * kScale);
    }];
    
    [valueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_centerX).offset(27 * kScale);
    }];
    
    [bdLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15 * kScale);
        make.centerY.equalTo(view);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoTuiJianModel *model = self.dataArray[indexPath.row];

    return model.isSelected ? model.height : 54 * kScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoTuiJianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    TaoTuiJianModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.heightBlcok = ^{
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoTuiJianModel *model = self.dataArray[indexPath.row];
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    
    vc.t = model.t;
    vc.s = model.s;
    vc.m = model.m;
    vc.n = model.n;
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
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40 * kScale;
}

#pragma mark lazy 

- (TaoTuiJianDateAPI *)dateAPI {
    if (_dateAPI == nil) {
        _dateAPI = [TaoTuiJianDateAPI new];
    }
    return _dateAPI;
}

- (TaoTuiJianStockAPI *)stockListAPI {
    if (_stockListAPI == nil) {
        _stockListAPI = [TaoTuiJianStockAPI new];
        _stockListAPI.delegate = self;
        _stockListAPI.d = @"";
        _stockListAPI.code = @"gptj";
    }
    return _stockListAPI;
}

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_genmai_nor"]];
        _topImageView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 180 * kScale);
    }
    return _topImageView;
}

- (UILabel *)topLb {
    if (_topLb == nil) {
        _topLb = [UILabel new];
        _topLb.textColor = kUIColorFromRGB(0xffffff);
        _topLb.font = [UIFont systemFontOfSize:16 * kScale];
        _topLb.numberOfLines = 0;
    }
    return _topLb;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 15 * kScale, 0, 15 * kScale);
        [_tableView registerClass:[TaoTuiJianTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
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

@end
