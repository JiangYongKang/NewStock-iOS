//
//  MainViewController.h
//  NewStock
//
//  Created by Willey on 16/7/21.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "BaseViewController.h"
#import "IndexBlock.h"
#import "HMSegmentedControl.h"
#import "iCarousel.h"
#import "StockNewsListAPI.h"


@interface MainViewController : BaseViewController<IndexBlockDelegate, iCarouselDelegate,APIRequestDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IndexBlock *_shIndex;
    IndexBlock *_szIndex;
    IndexBlock *_cybIndex;
    
    
    NSTimer *_myTimer;
}
@end
