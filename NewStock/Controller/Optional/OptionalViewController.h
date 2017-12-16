//
//  OptionalViewController.h
//  NewStock
//
//  Created by Willey on 16/11/18.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "HMSegmentedControl.h"
#import "DMLazyScrollView.h"
#import "MyStockViewController.h"
#import "QuotationViewController.h"

@interface OptionalViewController : BaseViewController<DMLazyScrollViewDelegate>
{
    HMSegmentedControl *_segmentedControl;
    
    NSMutableArray *_viewControllerArray;

    DMLazyScrollView *_lazyScrollView;
}

@property (nonatomic, assign) NSInteger hangQing;

@end

