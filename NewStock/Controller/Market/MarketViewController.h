//
//  MarketViewController.h
//  NewStock
//
//  Created by Willey on 16/7/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "DMLazyScrollView.h"
#import "HMSegmentedControl.h"


@interface MarketViewController : BaseViewController<DMLazyScrollViewDelegate>
{
    HMSegmentedControl *_segmentedControl;
    
    DMLazyScrollView *_lazyScrollView;
    
    NSMutableArray *_viewControllerArray;
    
    int _curPageIndex;
    
    NSTimer *_myTimer;

}
@end
