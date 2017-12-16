//
//  BoardViewController.m
//  NewStock
//
//  Created by Willey on 16/11/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BoardViewController.h"
#import "MarketConfig.h"
#import "SearchViewController.h"
#import "BoardListViewController.h"
#import "AppDelegate.h"

@interface BoardViewController ()

@end

@implementation BoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setRightBtnImg:[UIImage imageNamed:@"white_search_nor"]];
    
    [_navBar setTitle:self.title];
    
    //
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"概念", @"行业", @"地区"]];
    _segmentedControl.selectionIndicatorHeight = 3.0f;
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],NSForegroundColorAttributeName : kUIColorFromRGB(0x666666)};
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : kTitleColor};
    
    _segmentedControl.selectionIndicatorColor = kTitleColor;
    _segmentedControl.selectionIndicatorBoxOpacity = 0.0;//0.1
    _segmentedControl.verticalDividerColor = kUIColorFromRGB(0x666666);
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [_mainView addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.superview).offset(0);
        make.left.equalTo(_segmentedControl.superview).offset(0);
        make.right.equalTo(_segmentedControl.superview).offset(0);
        make.height.mas_equalTo(40);
    }];
    [_segmentedControl layoutIfNeeded];

    
    NSUInteger numberOfPages = 3;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }
    
    NSLog(@"%f@%f@%f", _segmentedControl.frame.size.height, _segmentedControl.frame.size.width, _nMainViewHeight-_segmentedControl.frame.size.height);
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, _segmentedControl.frame.size.height, _segmentedControl.frame.size.width, _nMainViewHeight-_segmentedControl.frame.size.height)];
    [_lazyScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
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
        make.top.equalTo(_lazyScrollView.superview).offset(39.5);
        make.left.equalTo(_lazyScrollView.superview).offset(0);
        make.right.equalTo(_lazyScrollView.superview).offset(0);
        make.bottom.equalTo(_lazyScrollView.superview).offset(0);
    }];
    
    [_mainView bringSubviewToFront:_segmentedControl];
}

- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null])
    {
        if (index == 0)
        {
            BoardListViewController *contr = [[BoardListViewController alloc] init];
            contr.title = @"热点概念";
            contr.BoardDetailType = BoardDetailType_10;
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
        else if(index == 1)
        {
            BoardListViewController *contr = [[BoardListViewController alloc]init];
            contr.title = @"热点行业";
            contr.BoardDetailType = BoardDetailType_30;
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
        else if(index == 2)
        {
            BoardListViewController *contr = [[BoardListViewController alloc]init];
            contr.title = @"地区板块";
            contr.BoardDetailType = BoardDetailType_20;
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
    
    BaseViewController *contr = [_viewControllerArray objectAtIndex:(long)segmentedControl.selectedSegmentIndex];
    [contr loadData];
    
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - DMLazyScrollViewDelegate
- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
    BaseViewController *contr = [_viewControllerArray objectAtIndex:pageIndex];
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

#pragma mark - search
- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}

@end
