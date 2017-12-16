//
//  TaoDeepTigerViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/6/20.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "HMSegmentedControl.h"
#import "DMLazyScrollView.h"

@interface TaoDeepTigerViewController : BaseViewController<DMLazyScrollViewDelegate> {
    
    NSMutableArray *_viewControllerArray;
    
    DMLazyScrollView *_lazyScrollView;
}

@end
