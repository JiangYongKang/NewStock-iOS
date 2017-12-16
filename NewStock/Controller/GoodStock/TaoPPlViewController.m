//
//  TaoPPlViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/3/7.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoPPlViewController.h"
#import "IndexChartViewController.h"
#import "StockChartViewController.h"

#import "TaoPPlDateRangeAPI.h"
#import "TaoDateRangeModel.h"
#import "TaoPPlUserSearchAPI.h"
#import "TaoPPlStockSearchAPI.h"
#import "TaoSearchPPlModel.h"
#import "TaoSearchPPlCell.h"
#import "WDHorButton.h"

static NSString *cellID = @"TaoPPlViewCell";

@interface TaoPPlViewController () <UITableViewDelegate , UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) TaoPPlDateRangeAPI *taoPPlDateRangeAPI;
@property (nonatomic, strong) TaoPPlUserSearchAPI *userSearchAPI;
@property (nonatomic, strong) TaoPPlStockSearchAPI *stockSearchAPI;

@property (nonatomic, strong) NSArray <TaoDateRangeModel *> *dateArray;
@property (nonatomic, strong) NSArray <TaoSearchPPlListModel *>*dataArray;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *topLb;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_stock;
@property (nonatomic, strong) UILabel *lb_code;
@property (nonatomic, strong) WDHorButton *btn_date;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *pickerTopView;
@property (nonatomic, strong) UIView *coverView;

@end

@implementation TaoPPlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    
    self.title = @"牛散达人详情";
    UILabel *titleLb = [_navBar valueForKeyPath:@"_titleLb"];
    titleLb.text = @"牛散达人";
    titleLb.textColor = kUIColorFromRGB(0xffffff);
    _navBar.backgroundColor = [UIColor clearColor];
    _navBar.line_view.hidden = YES;
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    [self setupUI];
    [self getDate];
    
    [self.view bringSubviewToFront:_navBar];
}

- (void)getDate {
    [self.taoPPlDateRangeAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@",request.responseJSONObject);
        self.dateArray = [MTLJSONAdapter modelsOfClass:[TaoDateRangeModel class] fromJSONArray:request.responseJSONObject error:nil];
        TaoDateRangeModel *model = self.dateArray.firstObject;
        self.btn_date.title = model.n;
        [self setupPickerView];
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"%@ failed",[request class]);
    }];
    
}

- (void)setupPickerView {
    
    [self loadData];
    
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
    [self.view addSubview:self.topView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(140 * kScale));
    }];
    
    [self.topView addSubview:self.topLb];
    [self.topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(15 * kScale);
        make.right.equalTo(self.topView).offset(-15 * kScale);
        make.bottom.equalTo(self.topView).offset(-15 * kScale);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom).offset(50 * kScale);
    }];
    
    [self.view addSubview:self.lb_name];
    [self.view addSubview:self.lb_code];
    [self.view addSubview:self.lb_stock];
    [self.view addSubview:self.btn_date];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15 * kScale);
        make.top.equalTo(self.topView.mas_bottom).offset(0 * kScale);
        make.bottom.equalTo(self.tableView.mas_top);
        make.width.equalTo(@(200 * kScale));
    }];
    
    [self.lb_stock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(11 * kScale);
        make.left.equalTo(self.view).offset(15 * kScale);
    }];
    
    [self.lb_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15 * kScale);
        make.top.equalTo(self.lb_stock.mas_bottom).offset(3 * kScale);
    }];
    
    [self.btn_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15 * kScale);
        make.centerY.equalTo(self.lb_name);
        make.width.equalTo(@(130 * kScale));
        make.height.equalTo(@(24 * kScale));
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
    if (self.dateArray.count == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未查询到相关信息!" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    if (self.n.length) {
        [self.userSearchAPI start];
    } else {
        [self.stockSearchAPI start];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"%@ failed",[request class]);
}

- (void)requestFinished:(APIBaseRequest *)request {
    if (request == self.taoPPlDateRangeAPI) {
        return;
    }
    NSLog(@"%@",request.responseJSONObject);
    [self setDscLb:request.responseJSONObject[@"dsc"]];
    self.dataArray = [MTLJSONAdapter modelsOfClass:[TaoSearchPPlListModel class] fromJSONArray:request.responseJSONObject[@"list"] error:nil];
    
    [self.tableView reloadData];
}

- (void)setDscLb:(NSString *)s {
    
    if ((NSNull *)s == [NSNull null] || s.length == 0) {
        return;
    }
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 4 * kScale;
    NSAttributedString *attrS = [[NSAttributedString alloc] initWithString:s attributes:@{
                                                                                          NSParagraphStyleAttributeName : para,
                                                                                          NSFontAttributeName : [UIFont systemFontOfSize:14 * kScale],
                                                                                          
                                                                                          NSForegroundColorAttributeName :  kUIColorFromRGB(0xffffff),
                                                                                          }];
    
    CGRect rect = [attrS boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH - 30 * kScale, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(64 + rect.size.height + 20 * kScale));
    }];
    
    self.topLb.attributedText = attrS;
}

#pragma mark action

- (void)calenderBtnClick {
    self.pickerView.hidden = NO;
    self.coverView.hidden = NO;
    self.pickerTopView.hidden = NO;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self closePickerView];
}

- (void)sureBtnClick:(UIButton *)btn {
    [self closePickerView];
    
    NSInteger index = [self.pickerView selectedRowInComponent:0];
    TaoDateRangeModel *model = self.dateArray[index];
    if (self.n.length) {
        self.userSearchAPI.sd = model.sd;
        self.userSearchAPI.ed = model.ed;
    } else {
        self.stockSearchAPI.sd = model.sd;
        self.stockSearchAPI.ed = model.ed;
    }
    
    self.btn_date.title = model.n;
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

- (void)tap1:(UITapGestureRecognizer *)tap {
    
    if (!(self.t && self.s && self.m && self.stockName)) {
        return;
    }
    
    if (([self.t intValue] == 1) || ([self.t intValue] == 2)) {
        IndexChartViewController *viewController = [[IndexChartViewController alloc] init];
        
        IndexInfoModel *model = [[IndexInfoModel alloc] init];
        model.marketCd = self.m;
        model.symbol = self.s;
        model.symbolName = self.n;
        model.symbolTyp = self.t;
        
        viewController.indexModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        StockChartViewController *viewController = [[StockChartViewController alloc] init];
        StockListModel *model = [[StockListModel alloc] init];
        model.marketCd = self.m;
        model.symbol = self.s;
        model.symbolName = self.n;
        model.symbolTyp = self.t;
        
        viewController.stockListModel = model;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
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
    holdLb.text = @"持股数";
    holdLb.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *valueLb = [UILabel new];
    valueLb.textColor = kUIColorFromRGB(0x666666);
    valueLb.font = [UIFont systemFontOfSize:12 * kScale];
    valueLb.text = @"当前市值";
    
    UILabel *bdLb = [UILabel new];
    bdLb.textColor = kUIColorFromRGB(0x666666);
    bdLb.font = [UIFont systemFontOfSize:12 * kScale];
    bdLb.text = @"增减仓";
    
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
        make.right.equalTo(view.mas_centerX).offset(-20 * kScale);
    }];
    
    [valueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_centerX).offset(25 * kScale);
    }];
    
    [bdLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15 * kScale);
        make.centerY.equalTo(view);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//   TaoSearchPPlListModel *model = self.dataArray[indexPath.row];
    
    return 54 * kScale;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoSearchPPlCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    TaoSearchPPlListModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoSearchPPlListModel *model = self.dataArray[indexPath.row];
    TaoPPlViewController *vc = [TaoPPlViewController new];
    if (model.s.length) {
        vc.t = model.t;
        vc.s = model.s;
        vc.m = model.m;
        vc.stockName = model.n;
    } else {
        vc.n = model.n;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark pickerView delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dateArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    TaoDateRangeModel *model = self.dateArray[row];
    return model.n;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40 * kScale;
}


#pragma mark lazy 

- (TaoPPlDateRangeAPI *)taoPPlDateRangeAPI {
    if (_taoPPlDateRangeAPI == nil) {
        _taoPPlDateRangeAPI = [TaoPPlDateRangeAPI new];
        _taoPPlDateRangeAPI.count = @1000;
        _taoPPlDateRangeAPI.animatingView = self.view;
        _taoPPlDateRangeAPI.delegate = self;
        if (self.n.length) {
            _taoPPlDateRangeAPI.n = self.n;
        } else {
            _taoPPlDateRangeAPI.s = self.s;
            _taoPPlDateRangeAPI.t = [NSNumber numberWithInteger:self.t.integerValue];
            _taoPPlDateRangeAPI.m = [NSNumber numberWithInteger:self.m.integerValue];
        }
    }
    return _taoPPlDateRangeAPI;
}

- (TaoPPlUserSearchAPI *)userSearchAPI {
    if (_userSearchAPI == nil) {
        _userSearchAPI = [TaoPPlUserSearchAPI new];
        _userSearchAPI.animatingView = self.view;
        _userSearchAPI.delegate = self;
        _userSearchAPI.n = self.n;
        _userSearchAPI.count = @1000;
        TaoDateRangeModel *model = self.dateArray.firstObject;
        _userSearchAPI.sd = model.sd;
        _userSearchAPI.ed = model.ed;
    }
    return _userSearchAPI;
}

- (TaoPPlStockSearchAPI *)stockSearchAPI {
    if (_stockSearchAPI == nil) {
        _stockSearchAPI = [TaoPPlStockSearchAPI new];
        _stockSearchAPI.animatingView = self.view;
        _stockSearchAPI.delegate = self;
        TaoDateRangeModel *model = self.dateArray.firstObject;
        _stockSearchAPI.count = @1000;
        _stockSearchAPI.s = self.s;
        _stockSearchAPI.t = [NSNumber numberWithInteger:self.t.integerValue];
        _stockSearchAPI.m = [NSNumber numberWithInteger:self.m.integerValue];
        _stockSearchAPI.sd = model.sd;
        _stockSearchAPI.ed = model.ed;
    }
    return _stockSearchAPI;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = kTitleColor;
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_genmai_nor"]];
        [_topView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_topView);
        }];
    }
    return _topView;
}

- (UILabel *)topLb {
    if (_topLb == nil) {
        _topLb = [UILabel new];
        _topLb.textColor = kUIColorFromRGB(0xffffff);
//        _topLb.font = [UIFont systemFontOfSize:16 * kScale];
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
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15 * kScale, 0, 15 * kScale);
        [_tableView registerClass:[TaoSearchPPlCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (UILabel *)lb_name {
    if (_lb_name == nil) {
        _lb_name = [UILabel new];
        _lb_name.text = self.n;
        _lb_name.textColor = kUIColorFromRGB(0x333333);
        _lb_name.font = [UIFont systemFontOfSize:18 * kScale];
        _lb_name.numberOfLines = 2;
        _lb_name.adjustsFontSizeToFitWidth = YES;
    }
    return _lb_name;
}

- (WDHorButton *)btn_date {
    if (_btn_date == nil) {
        _btn_date = [[WDHorButton alloc] init];
        _btn_date.imgStr = @"calender_nor";
        _btn_date.layer.borderColor = kUIColorFromRGB(0xd3d3d3).CGColor;
        _btn_date.layer.borderWidth = 0.5 * kScale;
        [_btn_date setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
        _btn_date.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_btn_date addTarget:self action:@selector(calenderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_date;
}

- (UILabel *)lb_stock {
    if (_lb_stock == nil) {
        _lb_stock = [UILabel new];
        _lb_stock.textColor = kUIColorFromRGB(0x333333);
        _lb_stock.font = [UIFont boldSystemFontOfSize:16 * kScale];
        _lb_stock.text = self.stockName;
        _lb_stock.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
        [_lb_stock addGestureRecognizer:tap];
    }
    return _lb_stock;
}

- (UILabel *)lb_code {
    if (_lb_code == nil) {
        _lb_code = [UILabel new];
        _lb_code.textColor = kUIColorFromRGB(0x808080);
        _lb_code.font = [UIFont systemFontOfSize:11 * kScale];
        _lb_code.text = self.s;
        _lb_code.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
        [_lb_code addGestureRecognizer:tap];
    }
    return _lb_code;
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

@end
