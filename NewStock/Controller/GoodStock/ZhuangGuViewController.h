//
//  ZhuangGuViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/3/8.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "HMSegmentedControl.h"
#import "DMLazyScrollView.h"

@interface ZhuangGuViewController : BaseViewController<DMLazyScrollViewDelegate>{
    
    HMSegmentedControl *_segmentedControl;
    
    NSMutableArray *_viewControllerArray;
    
    DMLazyScrollView *_lazyScrollView;
}

@end
