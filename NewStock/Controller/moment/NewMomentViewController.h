//
//  NewMomentViewController.h
//  NewStock
//
//  Created by Willey on 16/11/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "HMSegmentedControl.h"
#import "DMLazyScrollView.h"

@interface NewMomentViewController : BaseViewController <DMLazyScrollViewDelegate> {
    
    NSMutableArray *_viewControllerArray;
}

@property (nonatomic ,assign) BOOL isPostVC;

@property (nonatomic, assign) NSInteger nativePush;

- (void)getUnreadNum ;

@end
