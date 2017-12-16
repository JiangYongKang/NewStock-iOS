//
//  FollowAndFansController.h
//  NewStock
//
//  Created by 王迪 on 2017/1/16.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "HMSegmentedControl.h"
#import "DMLazyScrollView.h"

@interface FollowAndFansController : BaseViewController <DMLazyScrollViewDelegate>
{
    NSMutableArray *_viewControllerArray;
    
    DMLazyScrollView *_lazyScrollView;
}

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, copy) NSString *url0500;
@property (nonatomic, copy) NSString *url0501;

@end
