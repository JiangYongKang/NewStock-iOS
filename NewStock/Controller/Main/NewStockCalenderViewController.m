//
//  NewStockCalenderViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/5/3.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "NewStockCalenderViewController.h"
#import "NewStockApplyViewController.h"
#import "NewStockPerformViewController.h"
#import "NewStockWaitingViewController.h"
#import "WebViewController.h"
#import "HMSegmentedControl.h"
#import "DMLazyScrollView.h"

#import "Defination.h"
#import <Masonry.h>

@interface NewStockCalenderViewController ()<DMLazyScrollViewDelegate>

@property (nonatomic) DMLazyScrollView *lazyScrollView;
@property (nonatomic) HMSegmentedControl *segmentControl;
@property (nonatomic) NSMutableArray *viewControllerArray;
@property (nonatomic) UIButton *rightBtn;

@end

@implementation NewStockCalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新股日历";
    [_navBar setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    UILabel *titlelb = [_navBar valueForKeyPath:@"_titleLb"];
    
    titlelb.attributedText = [[NSMutableAttributedString alloc] initWithString:self.title attributes:@{NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff),NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    _navBar.backgroundColor = kTitleColor;
    
    [_lazyScrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.lazyScrollView];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBar.mas_bottom).offset(0);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(335 * kScale));
        make.height.equalTo(@(40 * kScale));
    }];
    
    _navBar.backgroundColor = kTitleColor;
    [_navBar addSubview:self.rightBtn];
    [self.view bringSubviewToFront:_navBar];
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

- (void)loadData {
    BaseViewController *contr = [self.viewControllerArray objectAtIndex:(long)self.segmentControl.selectedSegmentIndex];
    [contr loadData];
}

#pragma mark delegate

- (UIViewController *)controllerAtIndex:(NSInteger) index {
    if (index > self.viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        if (index == 0) {
            NewStockApplyViewController *contr = [[NewStockApplyViewController alloc] init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        } else if(index == 1) {
            NewStockWaitingViewController *contr = [[NewStockWaitingViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        } else if (index == 2) {
            NewStockPerformViewController *contr = [[NewStockPerformViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
    }
    return res;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [_lazyScrollView moveByPages:segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];
    
    BaseViewController *contr = [self.viewControllerArray objectAtIndex:(long)segmentedControl.selectedSegmentIndex];
    [contr loadData];
}

- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentControl setSelectedSegmentIndex:pageIndex];
    [self segmentedControlChangedValue:self.segmentControl];
}

#pragma mark action

- (void)rightBtnClick:(UIButton *)btn {
    NSLog(@"push to h5 NS0001");
    NSString *url = [NSString stringWithFormat:@"%@%@",API_URL,H5_NEW_STOCK_APPLY];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WebViewController *vc = [WebViewController new];
    vc.type = WEB_VIEW_TYPE_NOR;
    vc.myUrl = urlStr;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark lazy loading

- (NSMutableArray *)viewControllerArray {
    if (_viewControllerArray == nil) {
        NSUInteger numberOfPages = 3;
        _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
        for (NSUInteger k = 0; k < numberOfPages; ++k) {
            [_viewControllerArray addObject:[NSNull null]];
        }
    }
    return _viewControllerArray;
}

- (DMLazyScrollView *)lazyScrollView {
    if (_lazyScrollView == nil) {
        _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, 64 + 40 * kScale, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - 44 - 40 * kScale)];
        [_lazyScrollView setEnableCircularScroll:NO];
        [_lazyScrollView setAutoPlay:NO];
        __weak __typeof(&*self)weakSelf = self;
        _lazyScrollView.dataSource = ^(NSUInteger index) {
            return [weakSelf controllerAtIndex:index];
        };
        
        [_lazyScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
        _lazyScrollView.numberOfPages = 3;
        _lazyScrollView.controlDelegate = self;
    }
    return _lazyScrollView;
}

- (HMSegmentedControl *)segmentControl {
    if (_segmentControl == nil) {
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"新股申购",@"等待上市",@"上市表现"]];
        _segmentControl.selectionIndicatorHeight = 3.0f;
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],NSForegroundColorAttributeName : kUIColorFromRGB(0x666666)};
        _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kTitleColor};
        
        _segmentControl.selectionIndicatorColor = kTitleColor;
        _segmentControl.verticalDividerColor = kUIColorFromRGB(0x666666);
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        [_segmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (UIButton *)rightBtn {
    if (_rightBtn == nil) {
        _rightBtn = [UIButton new];
        [_rightBtn setTitle:@"申购流程" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 * kScale];
        _rightBtn.frame = CGRectMake(_navBar.frame.size.width - 90 * kScale, 22, 100 * kScale, 40);
        [_navBar addSubview:_rightBtn];
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}


@end
