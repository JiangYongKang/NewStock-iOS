//
//  IndexViewController.m
//  NewStock
//
//  Created by Willey on 16/11/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "IndexViewController.h"
#import "MarketConfig.h"
#import "SearchViewController.h"
#import "IndexListViewController.h"
#import "ForeignIndexListViewController.h"
#import "ForeignTableViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBtnImg:[UIImage imageNamed:@"white_search_nor"]];
    
    [_navBar setTitle:self.title];
    
    //
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0));
    }];
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"国内指数", @"其他指数"]];
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
    
    NSUInteger numberOfPages = 2;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }

    
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, _segmentedControl.frame.size.height, _segmentedControl.frame.size.width, _nMainViewHeight-_segmentedControl.frame.size.height)];
    [_lazyScrollView setEnableCircularScroll:NO];
    [_lazyScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
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
    if (res == [NSNull null]) {
        if (index == 0)
        {
            IndexListViewController *contr = [[IndexListViewController alloc] init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
        else if(index == 1)
        {
            ForeignTableViewController *contr = [[ForeignTableViewController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
    }
    return res;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {

    [_lazyScrollView moveByPages:segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];
    
    BaseViewController *contr = [_viewControllerArray objectAtIndex:(long)segmentedControl.selectedSegmentIndex];
    [contr loadData];
}

#pragma mark - DMLazyScrollViewDelegate
- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
    BaseViewController *contr = [_viewControllerArray objectAtIndex:pageIndex];
    [contr loadData];
}

#pragma mark - search
- (void)navBar:(NavBar*)navBar rightButtonTapped:(UIButton*)sender {
    SearchViewController *viewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
