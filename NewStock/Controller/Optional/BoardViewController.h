//
//  BoardViewController.h
//  NewStock
//
//  Created by Willey on 16/11/28.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "DMLazyScrollView.h"
#import "HMSegmentedControl.h"

@interface BoardViewController : BaseViewController<DMLazyScrollViewDelegate>
{
    HMSegmentedControl *_segmentedControl;
    
    DMLazyScrollView *_lazyScrollView;
    
    NSMutableArray *_viewControllerArray;
    
    int _curPageIndex;
}
@end
