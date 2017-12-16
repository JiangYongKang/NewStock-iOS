//
//  TaosSearchDepartmentViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TaosSearchDepartmentViewController.h"
#import "DepartmentListViewController.h"
#import "TaoSearchStockViewController.h"
#import "TaoSearchDepartmentAPI.h"
#import "AppDelegate.h"
#import "TaoSearchDepartmentModel.h"
#import "TaoDateRangeAPI.h"
#import "TaoDateRangeModel.h"

@interface TaosSearchDepartmentViewController ()

@property (nonatomic, strong) TaoSearchDepartmentAPI *searchDepartmentAPI;

@property (nonatomic, strong) TaoDateRangeAPI *dateRangeAPI;

@property (nonatomic, strong) NSArray <TaoDateRangeModel *> *dateRangeArray;

@property (nonatomic, strong) NSArray <TaoSearchDepartmentListModel *> *listArray;

@property (nonatomic, strong) UILabel *topYybLb;
@property (nonatomic, strong) UILabel *leftLb;
@property (nonatomic, strong) UILabel *rightLb;
@property (nonatomic, strong) UILabel *centerLb;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) TaoSearchDepartmentModel *model;

@end

@implementation TaosSearchDepartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    [_navBar setTitle:@"营业部详情"];
    self.title = [NSString stringWithFormat:@"龙虎榜营业部:%@",self.name];
    
    [self.dateRangeAPI startWithCompletionBlockWithSuccess:^(__kindof APIBaseRequest *request) {
        NSArray *arr = request.responseJSONObject;
        if (arr.count == 0) {
            [self showNoView];
            return ;
        }
        [self loadData];
        self.dateRangeArray = [MTLJSONAdapter modelsOfClass:[TaoDateRangeModel class] fromJSONArray:arr error:nil];
        TaoDateRangeModel *model = self.dateRangeArray.firstObject;
        self.searchDepartmentAPI.sd = model.sd;
        self.searchDepartmentAPI.ed = model.ed;
        [self setupSegment];
    } failure:^(__kindof APIBaseRequest *request) {
        NSLog(@"dsdas");
    }];
    
    [self setupUI];
    
    self.view.backgroundColor = kUIColorFromRGB(0xf1f1f1);
}

- (void)setupSegment {
    if (self.dateRangeArray.count > 0) {
        TaoDateRangeModel *model1 = self.dateRangeArray[0];
        self.centerLb.text = model1.n;
    }
    
    [self.view addSubview:self.segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(10 * kScale);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(39 * kScale));
    }];
    
    NSUInteger numberOfPages = self.dateRangeArray.count;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        DepartmentListViewController *contr = [DepartmentListViewController new];
        [_viewControllerArray addObject:contr];
    }
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, _nMainViewWidth, _nMainViewHeight)];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [_lazyScrollView.panGestureRecognizer requireGestureRecognizerToFail:delegate.navigationController.interactivePopGestureRecognizer];
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
    
    [self.view layoutIfNeeded];
}

- (void)setupUI {
    
    UIView *headerView = [[UIView alloc] init];
    self.headerView = headerView;
    [self.view addSubview:headerView];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    [headerView addSubview:self.topYybLb];
    [headerView addSubview:self.leftLb];
    [headerView addSubview:self.rightLb];
    
    [self.topYybLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15 * kScale);
        make.right.equalTo(headerView).offset(-15 * kScale);
        make.top.equalTo(headerView).offset(15 * kScale);
    }];
    self.topYybLb.text = self.name;
    
    UIView *centerView = [UIView new];
    
    [headerView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.top.equalTo(self.topYybLb.mas_bottom).offset(15 * kScale);
        make.height.equalTo(@(20 * kScale));
        make.bottom.equalTo(headerView).offset(-72 * kScale);
    }];
    
    UILabel *line1 = [UILabel new];
    UILabel *line2 = [UILabel new];
    
    line1.backgroundColor = kUIColorFromRGB(0xd3d3d3);
    line2.backgroundColor = kUIColorFromRGB(0xd3d3d3);
    
    [centerView addSubview:line1];
    [centerView addSubview:line2];
    [centerView addSubview:self.centerLb];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView).offset(15 * kScale);
        make.centerY.equalTo(centerView);
        make.height.equalTo(@0.5);
        make.width.equalTo(@(140 * kScale));
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerView).offset(-15 * kScale);
        make.centerY.equalTo(centerView);
        make.height.equalTo(@0.5);
        make.width.equalTo(line1);
    }];
    
    [self.centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(centerView);
    }];
    
    UILabel *leftL = [UILabel new];
    leftL.text = @"净买入额最高(个股)";
    leftL.textColor = kUIColorFromRGB(0x333333);
    leftL.font = [UIFont systemFontOfSize:12 * kScale];
    
    UILabel *rightL = [UILabel new];
    rightL.text = @"操作最频繁(个股)";
    rightL.textColor = kUIColorFromRGB(0x333333);
    rightL.font = [UIFont systemFontOfSize:12 * kScale];
    
    [headerView addSubview:leftL];
    [headerView addSubview:rightL];
    
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(40 * kScale);
        make.top.equalTo(centerView.mas_bottom).offset(15 * kScale);
    }];
    
    [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-45 * kScale);
        make.top.equalTo(leftL);
    }];
    
    [headerView addSubview:self.leftLb];
    [headerView addSubview:self.rightLb];
    
    [self.leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftL.mas_bottom).offset(10 * kScale);
        make.centerX.equalTo(leftL);
    }];
    
    [self.rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftLb);
        make.centerX.equalTo(rightL);
    }];
    
    UILabel *line3 = [UILabel new];
    line3.backgroundColor = kUIColorFromRGB(0xe4e4e4);
    [headerView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(centerView.mas_bottom).offset(10 * kScale);
        make.bottom.equalTo(headerView).offset(-10 * kScale);
        make.width.equalTo(@0.5);
    }];
    
}

- (void)showNoView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"该营业部三年内没有龙虎榜信息!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark lazyScrollView

- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        DepartmentListViewController *contr = [[DepartmentListViewController alloc]init];
        [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
        
        return contr;
    }
    return res;
}

- (void)secSegmentControlChangedValue:(HMSegmentedControl *)segmentControl {
    
    [_lazyScrollView moveByPages:segmentControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];

    TaoDateRangeModel *model = self.dateRangeArray[segmentControl.selectedSegmentIndex];
    
    self.searchDepartmentAPI.sd = model.sd;
    self.searchDepartmentAPI.ed = model.ed;
    [self loadData];
    
    self.centerLb.text = model.n;
}

- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    if (_segmentedControl == nil) {
        return;
    }
    [self.segmentedControl setSelectedSegmentIndex:pageIndex];
    [self secSegmentControlChangedValue:self.segmentedControl];
}

#pragma mark loaddata 

- (void)loadData {
    [self.searchDepartmentAPI start];
}

#pragma mark action

- (void)tap:(UITapGestureRecognizer *)tap {
    TaoSearchDepartmentListModel *model;
    if (tap.view.tag == 1) {
        model = self.model.mnb;
    } else {
        model = self.model.mop;
    }
    
    TaoSearchStockViewController *vc = [TaoSearchStockViewController new];
    vc.t = model.t;
    vc.s = model.s;
    vc.m = model.m;
    vc.n = model.n;
    vc.d = model.tm.length ? model.tm : @"";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark request

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
    
    TaoSearchDepartmentModel *model = [MTLJSONAdapter modelOfClass:[TaoSearchDepartmentModel class] fromJSONDictionary:request.responseJSONObject error:nil];
    self.model = model;
    self.leftLb.text = model.mnb.n;
    self.rightLb.text = model.mop.n;
    
    self.listArray = model.list;
    
    DepartmentListViewController *contr = _viewControllerArray[_segmentedControl.selectedSegmentIndex];
    contr.dataArray = self.listArray;
}

#pragma mark lazy loading

- (TaoSearchDepartmentAPI *)searchDepartmentAPI {
    if (_searchDepartmentAPI == nil) {
        _searchDepartmentAPI = [TaoSearchDepartmentAPI new];
        _searchDepartmentAPI.animatingView = self.view;
        _searchDepartmentAPI.n = self.name;
        _searchDepartmentAPI.sd = self.startDate;
        _searchDepartmentAPI.ed = self.endDate;
        _searchDepartmentAPI.count = @1000;
        _searchDepartmentAPI.delegate = self;
    }
    return _searchDepartmentAPI;
}

- (TaoDateRangeAPI *)dateRangeAPI {
    if (_dateRangeAPI == nil) {
        _dateRangeAPI = [TaoDateRangeAPI new];
        _dateRangeAPI.animatingView = self.view;
        _dateRangeAPI.count = @1000;
        _dateRangeAPI.n = self.name;
    }
    return _dateRangeAPI;
}

- (UILabel *)topYybLb {
    if (_topYybLb == nil) {
        _topYybLb = [UILabel new];
        _topYybLb.textColor = kUIColorFromRGB(0x333333);
        _topYybLb.font = [UIFont systemFontOfSize:14 * kScale];
        _topYybLb.numberOfLines = 0;
    }
    return _topYybLb;
}

- (UILabel *)leftLb {
    if (_leftLb == nil) {
        _leftLb = [UILabel new];
        _leftLb.textColor = kUIColorFromRGB(0x358ee7);
        _leftLb.font = [UIFont systemFontOfSize:16 * kScale];
        _leftLb.tag = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_leftLb addGestureRecognizer:tap];
        _leftLb.userInteractionEnabled = YES;

    }
    return _leftLb;
}

- (UILabel *)rightLb {
    if (_rightLb == nil) {
        _rightLb = [UILabel new];
        _rightLb.textColor = kUIColorFromRGB(0x358ee7);
        _rightLb.font = [UIFont systemFontOfSize:16 * kScale];
        _rightLb.tag = 2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_rightLb addGestureRecognizer:tap];
        _rightLb.userInteractionEnabled = YES;
    }
    return _rightLb;
}

- (UILabel *)centerLb {
    if (_centerLb == nil) {
        _centerLb = [UILabel new];
        _centerLb.textColor = kUIColorFromRGB(0x666666);
        _centerLb.font = [UIFont systemFontOfSize:11 * kScale];
    }
    return _centerLb;
}

- (HMSegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        
        NSMutableArray *nmArr = [NSMutableArray array];
        for (TaoDateRangeModel *model in self.dateRangeArray) {
            [nmArr addObject:model.n];
        }
        
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:nmArr.copy];
        _segmentedControl.selectionIndicatorHeight = 3.0f;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f * kScale],NSForegroundColorAttributeName : kUIColorFromRGB(0x666666)};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kTitleColor};
        
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
