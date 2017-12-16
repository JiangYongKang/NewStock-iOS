//
//  TaosSearchDepartmentViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/2/24.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "HMSegmentedControl.h"
#import "DMLazyScrollView.h"

@interface TaosSearchDepartmentViewController : BaseViewController <DMLazyScrollViewDelegate> {
        
    NSMutableArray *_viewControllerArray;
    
    DMLazyScrollView *_lazyScrollView;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *endDate;

@end
