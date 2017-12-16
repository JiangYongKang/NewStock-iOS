//
//  TigerSearchViewController.m
//  NewStock
//
//  Created by 王迪 on 2017/2/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "TigerSearchViewController.h"
#import "TigerStockSearchController.h"
#import "TigerDepartmentSearchController.h"
#import "HMSegmentedControl.h"


@interface TigerSearchViewController ()

@property (nonatomic, strong) HMSegmentedControl *segmentControl;

@end

@implementation TigerSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mainView removeFromSuperview];
    [_scrollView removeFromSuperview];
    self.title = @"龙虎榜搜索";
    [_navBar setTitle:@"龙虎榜搜索"];
    [self setupUI];
    
}

- (void)setupUI {
    [self.view addSubview:self.segmentControl];
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentControl.superview).offset(64);
        make.left.equalTo(_segmentControl.superview).offset(0);
        make.right.equalTo(_segmentControl.superview).offset(0);
        make.height.mas_equalTo(40 * kScale);
    }];
    
    NSUInteger numberOfPages = 2;
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
        make.top.equalTo(_lazyScrollView.superview).offset(40 * kScale + 64);
        make.left.equalTo(_lazyScrollView.superview).offset(0);
        make.right.equalTo(_lazyScrollView.superview).offset(0);
        make.bottom.equalTo(_lazyScrollView.superview).offset(0);
    }];

}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [_lazyScrollView moveByPages:segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];
}

#pragma mark lazyScrollView

- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        if (index == 0) {
            TigerStockSearchController *contr = [[TigerStockSearchController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        } else {
            TigerDepartmentSearchController *contr = [[TigerDepartmentSearchController alloc]init];
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
    }
    return res;
}

- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {

    [self.segmentControl setSelectedSegmentIndex:pageIndex];
    [self segmentedControlChangedValue:self.segmentControl];
}



- (void)loadData {
    
}

- (void)requestFinished:(APIBaseRequest *)request {
//    NSLog(@"%@",request.responseJSONObject);
}

- (void)requestFailed:(APIBaseRequest *)request {
    NSLog(@"failed");
}

#pragma mark lazyloading

- (HMSegmentedControl *)segmentControl {
    
    if (_segmentControl == nil) {
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"搜个股",@"搜营业部"]];
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



@end
