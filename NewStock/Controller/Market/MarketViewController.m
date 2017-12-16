//
//  MarketViewController.m
//  NewStock
//
//  Created by Willey on 16/7/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "MarketViewController.h"
#import "StockViewController.h"
#import "StockBoardViewController.h"
#import "StockIndexViewController.h"
#import "SearchViewController.h"
#import "MarketConfig.h"


@interface MarketViewController ()

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftBtnImg:nil];
    [self setRightBtnImg:[UIImage imageNamed:@"white_search_nor"]];

    [_navBar setTitle:self.title];

    //
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, TAB_BAR_HEIGHT+NAV_BAR_HEIGHT, 0));
    }];
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"沪深", @"板块", @"股指"]];
    _segmentedControl.selectionIndicatorHeight = 3.0f;
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],NSForegroundColorAttributeName : kUIColorFromRGB(0x666666)};
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kUIColorFromRGB(0x358ee7)};
    
    _segmentedControl.selectionIndicatorColor = kUIColorFromRGB(0x358ee7);
    _segmentedControl.selectionIndicatorBoxOpacity = 0.0;
    _segmentedControl.verticalDividerColor = kUIColorFromRGB(0x666666);
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;//HMSegmentedControlSelectionStyleFullWidthStripe;//HMSegmentedControlSelectionStyleTextWidthStripe;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [_mainView addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.superview).offset(0);
        make.left.equalTo(_segmentedControl.superview).offset(0);
        make.right.equalTo(_segmentedControl.superview).offset(0);
        make.height.mas_equalTo(40);
    }];
    [_segmentedControl layoutIfNeeded];//

    //[[_segmentedControl layer] setBorderColor:[UIColor clearColor].CGColor];

    
    //
    NSUInteger numberOfPages = 3;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }
    
    NSLog(@"%f@%f@%f", _segmentedControl.frame.size.height, _segmentedControl.frame.size.width, _nMainViewHeight-_segmentedControl.frame.size.height);
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, _segmentedControl.frame.size.height, _segmentedControl.frame.size.width, _nMainViewHeight-_segmentedControl.frame.size.height)];
    [_lazyScrollView setEnableCircularScroll:NO];
    [_lazyScrollView setAutoPlay:NO];
    __weak __typeof(&*self)weakSelf = self;
    _lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    _lazyScrollView.numberOfPages = numberOfPages;
    _lazyScrollView.controlDelegate = self;
    [_mainView addSubview:_lazyScrollView];
    [_lazyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.superview).offset(39.5);
        make.left.equalTo(_segmentedControl.superview).offset(0);
        make.right.equalTo(_segmentedControl.superview).offset(0);
        make.bottom.equalTo(_segmentedControl.superview).offset(0);
    }];

    
    [_mainView bringSubviewToFront:_segmentedControl];
    //[_lazyScrollView showPlaceHolderWithAllSubviews];

}

- (UIViewController *) controllerAtIndex:(NSInteger)index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null])
    {
        if (index == 0)
        {
            StockViewController *contr = [[StockViewController alloc] init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
        else if(index ==1)
        {
            StockBoardViewController *contr = [[StockBoardViewController alloc] init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
        else if(index == 2)
        {
            StockIndexViewController *contr = [[StockIndexViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
    }
    return res;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    [_lazyScrollView moveByPages:segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];
    //[_lazyScrollView setPage:segmentedControl.selectedSegmentIndex animated:YES];
    
    EmbedBaseViewController *contr = [_viewControllerArray objectAtIndex:(long)segmentedControl.selectedSegmentIndex];
    [contr loadData];

}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - DMLazyScrollViewDelegate
- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
    EmbedBaseViewController *contr = [_viewControllerArray objectAtIndex:pageIndex];
    [contr loadData];
    
    if (pageIndex == 0)
    {
        
    }
    else if (pageIndex == 1)
    {
        
    }
    else if (pageIndex == 2)
    {
       
    }
}

- (void)lazyScrollViewWillBeginDragging:(DMLazyScrollView *)pagingView {
}

#pragma mark - loadData
- (void)loadData {
    NSInteger index = _segmentedControl.selectedSegmentIndex;
    
    EmbedBaseViewController *contr = [_viewControllerArray objectAtIndex:index];
    [contr loadData];
}

- (void)timerMethod:(NSTimer *)paramSender {
    
    NSInteger index = _segmentedControl.selectedSegmentIndex;
    
    EmbedBaseViewController *contr = [_viewControllerArray objectAtIndex:index];
    [contr loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear:行情");
    [super viewWillAppear:animated];
    
    //[self loadData];
    
    [_myTimer invalidate];
    float f = [MarketConfig getAppRefreshTime];
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:f
                                                target:self
                                              selector:@selector(timerMethod:) userInfo:nil
                                               repeats:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"viewWillDisappear:行情");

    [super viewWillDisappear:animated];
    
    [_myTimer invalidate];
}

#pragma mark - search
- (void)navBar:(NavBar *)navBar rightButtonTapped:(UIButton *)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
