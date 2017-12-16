//
//  FollowAndFansController.m
//  NewStock
//
//  Created by 王迪 on 2017/1/16.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "FollowAndFansController.h"
#import "WebViewController.h"
#import "EmbedFFViewController.h"
#import "AppDelegate.h"

@interface FollowAndFansController ()

@property (nonatomic) AppDelegate *appDelegate;

@end

@implementation FollowAndFansController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_navBar setTitle:@""];
    self.title = @"关注 / 粉丝";
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"关注", @"粉丝"]];
    _segmentedControl.backgroundColor = [UIColor clearColor];
    _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],NSForegroundColorAttributeName : kTitleColor};
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    _segmentedControl.selectionIndicatorColor = kTitleColor;
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    _segmentedControl.selectionIndicatorBoxOpacity = 1;
    _segmentedControl.selectionIndicatorBoxMaskToBouns = YES;
    _segmentedControl.selectionIndicatorBoxCornerRadius = 14;
    
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    _segmentedControl.layer.borderWidth = 1;
    _segmentedControl.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:25.0/255.0 alpha:0.5].CGColor;
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
    
    if (self.url0500.length) {
        self.url0501 = [self.url0500 stringByReplacingOccurrencesOfString:@"MY0500" withString:@"MY0501"];
    }else if (self.url0501.length) {
        self.url0500 = [self.url0501 stringByReplacingOccurrencesOfString:@"MY0501" withString:@"MY0500"];
    }
    
    NSUInteger numberOfPages = 2;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }
    
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, _nMainViewWidth, _nMainViewHeight)];

    [_lazyScrollView setEnableCircularScroll:NO];
    [_lazyScrollView setAutoPlay:NO];
    __weak __typeof(&*self)weakSelf = self;
    _lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    _lazyScrollView.numberOfPages = numberOfPages;
    _lazyScrollView.controlDelegate = self;
    [_lazyScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.appDelegate.navigationController.interactivePopGestureRecognizer];
    [_mainView addSubview:_lazyScrollView];
    [_lazyScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lazyScrollView.superview).offset(0);
        make.left.equalTo(_lazyScrollView.superview).offset(0);
        make.right.equalTo(_lazyScrollView.superview).offset(0);
        make.bottom.equalTo(_lazyScrollView.superview).offset(0);
    }];
    
    [self loadData];
}

- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        if (index == 0) {
            EmbedFFViewController *contr = [[EmbedFFViewController alloc] init];
            NSString *url;
            if (self.url0500.length) {
                url = self.url0500;
            }else {
                url = [NSString stringWithFormat:@"%@%@",API_URL,H5_ACCOUNT_MY_FOLLOW];
            }
            contr.myUrl = url;
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        } else if(index == 1) {
            EmbedFFViewController *contr = [[EmbedFFViewController alloc] init];
            NSString *url;
            if (self.url0501.length) {
                url = self.url0501;
            }else {
                url = [NSString stringWithFormat:@"%@%@",API_URL,H5_ACCOUNT_MY_FANS];
            }
            contr.myUrl = url;
            [_viewControllerArray replaceObjectAtIndex:index withObject:contr];
            return contr;
        }
    }
    return res;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [_lazyScrollView moveByPages:segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:YES];
}

- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex {
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
    [self segmentedControlChangedValue:_segmentedControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_lazyScrollView moveByPages:_segmentedControl.selectedSegmentIndex-_lazyScrollView.currentPage animated:NO];
}

- (AppDelegate *)appDelegate {
    if (_appDelegate == nil) {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end
