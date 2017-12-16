//
//  TaoDeepTigerViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/20.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaoDeepTigerViewController.h"
#import "TigerSearchViewController.h"
#import "TaoDeepStockViewController.h"
#import "TaoDeepJGViewController.h"
#import "TaoDeepDeathViewController.h"
#import "TaoDeepYZViewController.h"
#import "TaoDeepDepartmentViewController.h"

#import "TaoDeepCalenderAPI.h"
#import "Defination.h"
#import <Masonry.h>
#import "TaoDateList.h"
#import "WDHorButton.h"
#import "YearModel.h"
#import "TaoDateRangeModel.h"

@interface TaoDeepTigerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource,TaoDeepTigetSendCountDelegate>

@property (nonatomic, strong) TaoDeepCalenderAPI *deepCalenderAPI;
@property (nonatomic, strong) NSArray *yearArray;
@property (nonatomic, strong) NSArray *sendDateArray;
@property (nonatomic, strong) NSArray <TaoDateRangeModel *> *dateArray;
@property (nonatomic, strong) NSArray *dataYearArr;
@property (nonatomic, strong) NSArray *dataMonthArr;
@property (nonatomic, strong) NSArray *dataDayArr;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *pickerTopView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UILabel *centerLb;
@property (nonatomic, strong) UILabel *centerNumLb;
@property (nonatomic, strong) WDHorButton *calenderBtn;
@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;


@end

@implementation TaoDeepTigerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    self.title = @"深度龙虎榜";
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    NSMutableAttributedString *nmAttrStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{
                                                                                                                     NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),
                                                                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]                                        }];
    titlelb.attributedText = nmAttrStr.copy;
    _navBar.backgroundColor = kTitleColor;
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    [self.deepCalenderAPI start];
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToTop) name:STATESBAR_TOUCH_NOTIFICATION object:nil];
}

- (void)setupUI {
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_navBar.mas_bottom);
        make.height.equalTo(@(49 * kScale));
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
        make.left.equalTo(self.view).offset(12 * kScale);
        make.centerY.equalTo(self.centerLb);
        make.width.equalTo(@(110 * kScale));
        make.height.equalTo(@(27 * kScale));
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-12 * kScale);
        make.centerY.equalTo(self.centerLb);
        make.width.equalTo(@(110 * kScale));
        make.height.equalTo(@(27 * kScale));
    }];
    
    [self.view addSubview:self.segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBar.mas_bottom).offset((49 + 10) * kScale);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(40 * kScale));
    }];
    
    NSUInteger numberOfPages = 5;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, _nMainViewWidth, _nMainViewHeight)];
    [_lazyScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    [_lazyScrollView setEnableCircularScroll:NO];
    [_lazyScrollView setAutoPlay:NO];
    __weak __typeof(&*self)weakSelf = self;
    _lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    _lazyScrollView.numberOfPages = numberOfPages;
    _lazyScrollView.controlDelegate = self;
    [self.view addSubview:_lazyScrollView];
    [_lazyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom).offset(0);
        make.left.equalTo(_lazyScrollView.superview).offset(0);
        make.right.equalTo(_lazyScrollView.superview).offset(0);
        make.bottom.equalTo(_lazyScrollView.superview).offset(0);
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
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark request

- (void)loadData {
    NSInteger index = _segmentedControl.selectedSegmentIndex;
    NSString *date = self.calenderBtn.title;
    if (index == 0) {
        TaoDeepStockViewController *contr = (TaoDeepStockViewController *)_viewControllerArray[0];
        contr.dateStr = date;
        [contr loadData];
    } else if (index == 1) {
        TaoDeepJGViewController *contr = (TaoDeepJGViewController *)_viewControllerArray[1];
        contr.date = date;
        [contr loadData];
    } else if (index == 2) {
        TaoDeepDeathViewController *contr = (TaoDeepDeathViewController *)_viewControllerArray[2];
        contr.date = date;
        [contr loadData];
    } else if (index == 3) {
        TaoDeepYZViewController *contr = (TaoDeepYZViewController *)_viewControllerArray[3];
        contr.date = date;
        [contr loadData];
    } else if (index == 4) {
        TaoDeepDepartmentViewController *contr = (TaoDeepDepartmentViewController *)_viewControllerArray[4];
        contr.date = date;
        [contr loadData];
    }
}

- (void)requestFailed:(APIBaseRequest *)request {

}

- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"%@",request.responseJSONObject);
    self.sendDateArray = request.responseJSONObject;
    [self setupPickerView];
}

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

- (void)scrollToTop {
    NSInteger index = _segmentedControl.selectedSegmentIndex;
    
    if (index == 0) {
        TaoDeepStockViewController *contr = (TaoDeepStockViewController *)_viewControllerArray[0];
        [contr scrollToTop];
    } else if (index == 1) {
        TaoDeepJGViewController *contr = (TaoDeepJGViewController *)_viewControllerArray[1];
        [contr scrollToTop];
    } else if (index == 2) {
        TaoDeepDeathViewController *contr = (TaoDeepDeathViewController *)_viewControllerArray[2];
        [contr scrollToTop];
    } else if (index == 3) {
        TaoDeepYZViewController *contr = (TaoDeepYZViewController *)_viewControllerArray[3];
        [contr scrollToTop];
    } else if (index == 4) {
        TaoDeepDepartmentViewController *contr = (TaoDeepDepartmentViewController *)_viewControllerArray[4];
        [contr scrollToTop];
    }
}

#pragma mark delegate

- (void)taoDeepTigerSendCount:(NSString *)countStr {
    self.centerNumLb.text = countStr;
}

#pragma mark lazyScrollView

- (UIViewController *)controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        if (index == 0) {
            TaoDeepStockViewController *contr = [[TaoDeepStockViewController alloc]init];
            contr.delegate = self;
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        } else if (index == 1) {
            TaoDeepJGViewController *contr = [[TaoDeepJGViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            contr.delegate = self;
            return contr;
        } else if (index == 2) {
            TaoDeepDeathViewController *contr = [[TaoDeepDeathViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            contr.delegate = self;
            return contr;
        } else if (index == 3) {
            TaoDeepYZViewController *contr = [[TaoDeepYZViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            contr.delegate = self;
            return contr;
        } else if (index == 4) {
            TaoDeepDepartmentViewController *contr = [[TaoDeepDepartmentViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            contr.delegate = self;
            return contr;
        }
    }
    return res;
}

- (void)secSegmentControlChangedValue:(HMSegmentedControl *)segmentControl {
    [_lazyScrollView moveByPages:segmentControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];
    [self loadData];
}

- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    if (_segmentedControl == nil) {
        return;
    }
    [self.segmentedControl setSelectedSegmentIndex:pageIndex];
    [self secSegmentControlChangedValue:self.segmentedControl];
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

#pragma mark

- (TaoDeepCalenderAPI *)deepCalenderAPI {
    if (_deepCalenderAPI == nil) {
        _deepCalenderAPI = [TaoDeepCalenderAPI new];
        _deepCalenderAPI.delegate = self;
        _deepCalenderAPI.animatingView = self.view;
    }
    return _deepCalenderAPI;
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
        _centerLb.font = [UIFont systemFontOfSize:12 * kScale];
        _centerLb.text = @"今日上榜";
    }
    return _centerLb;
}

- (UILabel *)centerNumLb {
    if (_centerNumLb == nil) {
        _centerNumLb = [UILabel new];
        _centerNumLb.textColor = kUIColorFromRGB(0xf34851);
        _centerNumLb.font = [UIFont systemFontOfSize:12 * kScale];
        _centerNumLb.text = @"0";
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
        _calenderBtn.backgroundColor = kUIColorFromRGB(0xf7f7f7);
    }
    return _calenderBtn;
}

- (UIButton *)searchBtn {
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
        _searchBtn.backgroundColor = kUIColorFromRGB(0xf7f7f7);
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12 * kScale];
        [_searchBtn setTitle:@"龙虎榜搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [_searchBtn setImage:[UIImage imageNamed:@"black_search_nor"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.layer.borderColor = kUIColorFromRGB(0xe4e4e4).CGColor;
        _searchBtn.layer.borderWidth = 0.5 * kScale;
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20 * kScale, 0, 20 * kScale);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70 * kScale, 0, -70 * kScale);
    }
    return _searchBtn;
}

- (HMSegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"股票",@"机构",@"敢死队",@"游资",@"营业部"]];
        _segmentedControl.selectionIndicatorHeight = 3.0f;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0x333333)};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kTitleColor,NSFontAttributeName : [UIFont boldSystemFontOfSize:15 * kScale]};
        
        _segmentedControl.selectionIndicatorColor = kTitleColor;
        _segmentedControl.selectionIndicatorBoxOpacity = 0.0;//0.1
        _segmentedControl.verticalDividerColor = kUIColorFromRGB(0x666666);
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        
        [_segmentedControl addTarget:self action:@selector(secSegmentControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segmentedControl;
}


@end
