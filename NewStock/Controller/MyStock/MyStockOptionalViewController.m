//
//  MyStockOptionalViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/6/12.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "MyStockNewsViewController.h"
#import "MyStockAnnounceListViewController.h"
#import "MyStockOptionalViewController.h"
#import "HMSegmentedControl.h"
#import "DMLazyScrollView.h"
#import "AppDelegate.h"

@interface MyStockOptionalViewController ()

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) DMLazyScrollView *lazyScrollView;

@end

@implementation MyStockOptionalViewController {
    NSMutableArray *_viewControllerArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_lazyScrollView removeFromSuperview];
    [_mainView removeFromSuperview];
    
    [self setLeftBtnImg:[UIImage imageNamed:@"ic_back1_nor"]];
    [_navBar setTitle:@""];
    _navBar.backgroundColor = kTitleColor;
    
    [_navBar addSubview:self.segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_segmentedControl.superview).offset(-8);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(150 * kScale);
        make.centerX.equalTo(_segmentedControl.superview.mas_centerX);
    }];
    
    [self.view addSubview:self.lazyScrollView];
    [_lazyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lazyScrollView.superview).offset(64);
        make.left.equalTo(_lazyScrollView.superview).offset(0);
        make.right.equalTo(_lazyScrollView.superview).offset(0);
        make.bottom.equalTo(_lazyScrollView.superview).offset(0);
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToTop) name:STATESBAR_TOUCH_NOTIFICATION object:nil];
}

- (void)scrollToTop {
    NSLog(@"dsd");
    if (_segmentedControl.selectedSegmentIndex == 0) {
        MyStockNewsViewController *vc = (MyStockNewsViewController *)_viewControllerArray[0];
        [vc scrollToTop];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        MyStockAnnounceListViewController *vc = (MyStockAnnounceListViewController *)_viewControllerArray[1];
        [vc scrollToTop];
    }
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
            MyStockNewsViewController *contr = [[MyStockNewsViewController alloc] init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        } else if(index == 1) {
            MyStockAnnounceListViewController *contr = [[MyStockAnnounceListViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
    }
    return res;
}

#pragma mark - DMLazyScrollViewDelegate
- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
    [self segmentedControlChangedValue:_segmentedControl];
}

- (void)loadData {
    if (self.pushIndex == 1) {
        _segmentedControl.selectedSegmentIndex = 0;
        [self segmentedControlChangedValue:_segmentedControl];
    } else if (self.pushIndex == 2) {
        _segmentedControl.selectedSegmentIndex = 1;
        [self segmentedControlChangedValue:_segmentedControl];
    }
    
    self.pushIndex = 0;
    BaseViewController *contr = [_viewControllerArray objectAtIndex:_segmentedControl.selectedSegmentIndex];
    [contr loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    BaseViewController *contr = [_viewControllerArray objectAtIndex:_segmentedControl.selectedSegmentIndex];
    [contr viewWillDisappear:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark lazyloading

- (HMSegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"自选资讯", @"自选公告"]];
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
    }
    return _segmentedControl;
}

- (DMLazyScrollView *)lazyScrollView {
    if (_lazyScrollView == nil) {
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
        [_lazyScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.appDelegate.navigationController.interactivePopGestureRecognizer];
    }
    return _lazyScrollView;
}

- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end
