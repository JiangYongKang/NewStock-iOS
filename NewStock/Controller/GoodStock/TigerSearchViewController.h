//
//  TigerSearchViewController.h
//  NewStock
//
//  Created by 王迪 on 2017/2/27.
//  Copyright © 2017年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "DMLazyScrollView.h"

@interface TigerSearchViewController : BaseViewController <DMLazyScrollViewDelegate> {
    
    NSMutableArray *_viewControllerArray;
    
    DMLazyScrollView *_lazyScrollView;
}

@end
