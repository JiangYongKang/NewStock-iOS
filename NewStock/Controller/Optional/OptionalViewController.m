//
//  OptionalViewController.m
//  NewStock
//
//  Created by Willey on 16/11/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "OptionalViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MarketConfig.h"

@interface OptionalViewController ()

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIView *introView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OptionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBtnImg:[UIImage imageNamed:@"white_search_nor"]];
    [_navBar setTitle:@""];
    _navBar.backgroundColor = kTitleColor;
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"自选", @"行情"]];
    _segmentedControl.backgroundColor = [UIColor clearColor];
    _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],NSForegroundColorAttributeName : [UIColor colorWithWhite:1 alpha:1]};
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kTitleColor};
    
    _segmentedControl.selectionIndicatorColor = kUIColorFromRGB(0xffffff);
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    _segmentedControl.selectionIndicatorBoxOpacity = 1;
    _segmentedControl.selectionIndicatorBoxMaskToBouns = YES;
    _segmentedControl.selectionIndicatorBoxCornerRadius = 14;

    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    _segmentedControl.layer.borderWidth = 1;
    _segmentedControl.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    _segmentedControl.layer.cornerRadius = 14;
    _segmentedControl.layer.masksToBounds = YES;
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [_navBar addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_segmentedControl.superview).offset(-8);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(120);
        make.centerX.equalTo(_segmentedControl.superview.mas_centerX);
    }];
    
    
    NSUInteger numberOfPages = 2;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }

    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, _nMainViewWidth, _nMainViewHeight)];
    [_lazyScrollView setEnableCircularScroll:NO];
    [_lazyScrollView setAutoPlay:NO];
//    _lazyScrollView.scrollEnabled = NO;
    __weak __typeof(&*self)weakSelf = self;
    _lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    _lazyScrollView.numberOfPages = numberOfPages;
    _lazyScrollView.controlDelegate = self;
    [_mainView addSubview:_lazyScrollView];
    [_lazyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lazyScrollView.superview).offset(0);
        make.left.equalTo(_lazyScrollView.superview).offset(0);
        make.right.equalTo(_lazyScrollView.superview).offset(0);
        make.bottom.equalTo(_lazyScrollView.superview).offset(0);
    }];

    [self loadData];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [_lazyScrollView moveByPages:segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];
    
    BaseViewController *contr = [_viewControllerArray objectAtIndex:(long)segmentedControl.selectedSegmentIndex];
    [contr loadData];
}

- (UIViewController *)controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        if (index == 0) {
            MyStockViewController *contr = [[MyStockViewController alloc] init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        } else if(index == 1) {
            QuotationViewController *contr = [[QuotationViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
    }
    return res;
}

#pragma mark - search
- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - DMLazyScrollViewDelegate
- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
    [self segmentedControlChangedValue:_segmentedControl];
}

- (void)loadData {
    if (_hangQing == 1) {
        [_segmentedControl setSelectedSegmentIndex:1];
        BaseViewController *contr = [_viewControllerArray objectAtIndex:(long)_segmentedControl.selectedSegmentIndex];
        [contr loadData];
        [_lazyScrollView moveByPages:_segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:NO];
    } else if (_hangQing == 2) {
        NSLog(@"自选列表");
    } else if (_hangQing == 12) {
        NSLog(@"自选资讯");
    } else {
        BaseViewController *contr = [_viewControllerArray objectAtIndex:_segmentedControl.selectedSegmentIndex];
        [contr loadData];
    }
    _hangQing = 0;
}

- (void)refreshFunc {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        MyStockViewController *vc = (MyStockViewController *)_viewControllerArray[0];
        [vc loadNewData];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        QuotationViewController *vc = (QuotationViewController *)_viewControllerArray[1];
        [vc loadNewData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.timer invalidate];
    _timer = nil;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:[MarketConfig getRefreshTime] target:self selector:@selector(refreshFunc) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
